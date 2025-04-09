package user

import (
	"bytes"
	"context"
	"database/sql"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"strconv"
	"strings"
	"time"

	"log"

	"github.com/thongsoi/biomassx-05/database"
	"golang.org/x/crypto/bcrypt"
)

func fetchUserData(db *sql.DB, userID int) (*UserDetail, error) {
	log.Printf("Fetching user data for userID: %d", userID)

	// First fetch basic user information
	userQuery := `
    SELECT id, first_name, last_name, organization_name, username, phone, email
    FROM users 
    WHERE id = $1
    `

	var user UserDetail
	err := db.QueryRow(userQuery, userID).Scan(
		&user.ID, &user.FirstName, &user.LastName, &user.Organization,
		&user.Username, &user.Phone, &user.Email,
	)
	if err != nil {
		log.Println("Error fetching user data:", err)
		return nil, err
	}

	log.Printf("User basic info - Name: %v %v, Organization: %v, Username: %v, Phone: %v, Email: %v",
		user.FirstName.String, user.LastName.String, user.Organization.String,
		user.Username.String, user.Phone.String, user.Email.String)

	// ดึงข้อมูลที่อยู่พร้อมกับข้อมูลตำแหน่ง และประเภทที่อยู่
	log.Println("Fetching addresses with location and type data for user ID:", userID)
	addressQuery := `
SELECT 
    a.id, a.address_type_id, at.en_name, at.th_name, 
    a.branch_number, a.tax_number, a.street, a.address, a.postal_code, a.created_at,
    c.id, c.en_name, c.th_name, 
    p.id, p.en_name, p.th_name, 
    d.id, d.en_name, d.th_name, 
    s.id, s.en_name, s.th_name
FROM addresses a
LEFT JOIN address_types at ON a.address_type_id = at.id
LEFT JOIN countries c ON a.country_id = c.id
LEFT JOIN provinces p ON a.province_id = p.id
LEFT JOIN districts d ON a.district_id = d.id
LEFT JOIN subdistricts s ON a.subdistrict_id = s.id
WHERE a.user_id = $1
ORDER BY a.created_at ASC;

    `

	rows, err := db.Query(addressQuery, userID)
	if err != nil {
		log.Println("Error fetching addresses:", err)
		return nil, err
	}
	defer rows.Close()

	addressCount := 0
	for rows.Next() {
		addressCount++
		var addr Address
		var addressType Location
		var country, province, district, subdistrict Location

		err := rows.Scan(
			&addr.ID, &addr.AddressTypeID, &addressType.EnName, &addressType.ThName,
			&addr.BranchNumber, &addr.Taxnumber,
			&addr.Street, &addr.Address, &addr.PostalCode, &addr.CreatedAt,
			&country.ID, &country.EnName, &country.ThName,
			&province.ID, &province.EnName, &province.ThName,
			&district.ID, &district.EnName, &district.ThName,
			&subdistrict.ID, &subdistrict.EnName, &subdistrict.ThName,
		)

		if err != nil {
			log.Println("Error scanning address:", err)
			return nil, err
		}

		// Set location data for this address
		addr.AddressType = addressType
		addr.Country = country
		addr.Province = province
		addr.District = district
		addr.Subdistrict = subdistrict

		// หลังจาก Scan แต่ละ address สำเร็จ:
		log.Printf("Address Data: ID: %v, AddressType: %v, BranchNumber: %v, TaxNumber: %v, Street: %v, Address: %v, PostalCode: %v",
			addr.ID.Int64, addressType.EnName.String, addr.BranchNumber.String, addr.Taxnumber.String,
			addr.Street.String, addr.Address.String, addr.PostalCode.String,
		)

		log.Printf("Location Data - Country: %v, Province: %v, District: %v, Subdistrict: %v",
			country.EnName.String, province.EnName.String, district.EnName.String, subdistrict.EnName.String,
		)
		if !addr.Taxnumber.Valid {
			log.Printf("Address ID %v has invalid (NULL) tax_number.", addr.ID.Int64)
		} else {
			log.Printf("Tax Number for Address ID %v: %v", addr.ID.Int64, addr.Taxnumber.String)
		}

		user.Addresses = append(user.Addresses, addr)
	}

	log.Printf("Total addresses found: %d", addressCount)
	log.Printf("Completed fetching data for userID: %d", userID)

	return &user, nil
}

// deleteAddress ลบที่อยู่ของผู้ใช้ตาม ID
func deleteAddress(db *sql.DB, addressID int, userID int) error {
	// สร้าง context สำหรับ transaction
	ctx := context.Background()

	// เริ่ม transaction
	tx, err := db.BeginTx(ctx, nil)
	if err != nil {
		log.Printf("[deleteAddress] Error starting transaction: %v", err)
		return err
	}

	// ใช้ defer พร้อมกับ anonymous function เพื่อตรวจสอบผลลัพธ์ของ transaction
	defer func() {
		if err != nil {
			log.Printf("[deleteAddress] Rolling back transaction due to error: %v", err)
			tx.Rollback()
			return
		}
	}()

	// ก่อนลบ ตรวจสอบว่าที่อยู่นี้เป็นของผู้ใช้ที่ร้องขอจริงๆ เพื่อความปลอดภัย
	var count int
	err = tx.QueryRowContext(ctx, "SELECT COUNT(*) FROM addresses WHERE id = $1 AND user_id = $2", addressID, userID).Scan(&count)
	if err != nil {
		log.Printf("[deleteAddress] Error verifying address ownership: %v", err)
		return err
	}

	if count == 0 {
		log.Printf("[deleteAddress] Address ID %d does not belong to user ID %d or does not exist", addressID, userID)
		return fmt.Errorf("address not found or unauthorized")
	}

	// ดำเนินการลบที่อยู่
	_, err = tx.ExecContext(ctx, "DELETE FROM addresses WHERE id = $1", addressID)
	if err != nil {
		log.Printf("[deleteAddress] Error deleting address: %v", err)
		return err
	}

	// Commit transaction
	err = tx.Commit()
	if err != nil {
		log.Printf("[deleteAddress] Error committing transaction: %v", err)
		return err
	}

	log.Printf("[deleteAddress] Successfully deleted address ID %d for user ID %d", addressID, userID)
	return nil
}

func HandleDeleteAddress(w http.ResponseWriter, r *http.Request) {
	db := database.GetDB()
	log.Println("[handleDeleteAddress] Processing delete address request")
	log.Printf("[handleDeleteAddress] Request method: %s", r.Method)
	log.Printf("[handleDeleteAddress] Content-Type: %s", r.Header.Get("Content-Type"))

	// ตรวจสอบว่าเป็น POST request
	if r.Method != http.MethodPost && r.Method != http.MethodDelete {
		log.Printf("[handleDeleteAddress] Method not allowed: %s", r.Method)
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	// ดึง user ID จาก token
	userID, err := getUserIDFromToken(r)
	if err != nil {
		log.Printf("[handleDeleteAddress] Error getting user ID from token: %v", err)
		http.Error(w, "Unauthorized", http.StatusUnauthorized)
		return
	}

	// ดึง address ID จาก request body
	var addressID int

	contentType := r.Header.Get("Content-Type")
	if strings.Contains(contentType, "application/json") {
		// Log the raw request body for debugging
		var body []byte
		body, _ = io.ReadAll(r.Body)
		r.Body = io.NopCloser(bytes.NewBuffer(body))
		log.Printf("[handleDeleteAddress] Raw JSON body: %s", string(body))

		var requestBody struct {
			AddressID int `json:"addressId"` // Make sure this matches the frontend field name
		}

		err := json.NewDecoder(r.Body).Decode(&requestBody)
		if err != nil {
			log.Printf("[handleDeleteAddress] Error parsing JSON request body: %v", err)
			http.Error(w, "Invalid request body", http.StatusBadRequest)
			return
		}

		addressID = requestBody.AddressID
		log.Printf("[handleDeleteAddress] Got address ID %d from JSON", addressID)

		// Check for valid address ID
		if addressID <= 0 {
			log.Printf("[handleDeleteAddress] Invalid address ID: %d", addressID)
			http.Error(w, "Invalid address ID", http.StatusBadRequest)
			return
		}
	} else {
		// ถ้าไม่ใช่ JSON ให้ใช้ parameter จาก URL query หรือ form
		addressIDStr := r.URL.Query().Get("addressId")
		if addressIDStr == "" {
			// ถ้าไม่มีใน URL ให้ลองดึงจาก form
			addressIDStr = r.FormValue("addressId")
		}

		if addressIDStr == "" {
			log.Printf("[handleDeleteAddress] Address ID not provided in request")
			http.Error(w, "Address ID not provided", http.StatusBadRequest)
			return
		}

		var parseErr error
		addressID, parseErr = strconv.Atoi(addressIDStr)
		if parseErr != nil || addressID <= 0 {
			log.Printf("[handleDeleteAddress] Invalid address ID format: %v", parseErr)
			http.Error(w, "Invalid address ID", http.StatusBadRequest)
			return
		}
		log.Printf("[handleDeleteAddress] Got address ID %d from form/query", addressID)
	}

	// เรียกใช้ฟังก์ชั่นลบที่อยู่
	err = deleteAddress(db, addressID, userID)
	if err != nil {
		log.Printf("[handleDeleteAddress] Error deleting address: %v", err)
		http.Error(w, "Failed to delete address", http.StatusInternalServerError)
		return
	}

	// ส่งผลลัพธ์กลับไปเป็น JSON
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"success": true,
		"message": "Address deleted successfully",
	})
	log.Println("[handleDeleteAddress] Address deleted successfully")
}

// UpdateProfileHandler handles the profile update API endpoint
func UpdateProfileHandler(db *sql.DB) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		// Set content type
		w.Header().Set("Content-Type", "application/json")

		// Log the request
		log.Println("[UpdateProfileHandler] Received profile update request")

		// Get user ID from JWT token
		userID, err := getUserIDFromToken(r)
		if err != nil {
			log.Printf("[UpdateProfileHandler] Authentication error: %v", err)
			respondWithError(w, http.StatusUnauthorized, "Not authenticated")
			return
		}

		// Parse request body
		var reqData UpdateProfileRequest
		err = json.NewDecoder(r.Body).Decode(&reqData)
		if err != nil {
			log.Printf("[UpdateProfileHandler] Failed to parse request body: %v", err)
			respondWithError(w, http.StatusBadRequest, "Invalid request format")
			return
		}

		// Log the request data (remove sensitive information in production)
		log.Printf("[UpdateProfileHandler] Request data: %+v", reqData)

		// Start a transaction
		tx, err := db.Begin()
		if err != nil {
			log.Printf("[UpdateProfileHandler] Failed to begin transaction: %v", err)
			respondWithError(w, http.StatusInternalServerError, "Database error")
			return
		}
		defer func() {
			if err != nil {
				tx.Rollback()
				log.Printf("[UpdateProfileHandler] Transaction rolled back due to error")
			}
		}()

		// Build the SQL query dynamically using PostgreSQL style placeholders
		query := "UPDATE users SET updated_at = $1 "
		args := []interface{}{time.Now()}
		paramCount := 1

		// Add fields to update
		if reqData.FirstName != "" {
			paramCount++
			query += fmt.Sprintf(", first_name = $%d ", paramCount)
			args = append(args, reqData.FirstName)
		}

		if reqData.LastName != "" {
			paramCount++
			query += fmt.Sprintf(", last_name = $%d ", paramCount)
			args = append(args, reqData.LastName)
		}

		if reqData.OrganizationName != "" {
			paramCount++
			query += fmt.Sprintf(", organization_name = $%d ", paramCount)
			args = append(args, reqData.OrganizationName)
		}

		if reqData.Username != "" {
			// Check if username exists
			var count int
			checkQuery := "SELECT COUNT(*) FROM users WHERE username = $1 AND id != $2"
			err = db.QueryRow(checkQuery, reqData.Username, userID).Scan(&count)
			if err != nil {
				log.Printf("[UpdateProfileHandler] Username check failed: %v", err)
				respondWithError(w, http.StatusInternalServerError, "Database error")
				return
			}

			if count > 0 {
				respondWithError(w, http.StatusConflict, "Username already exists")
				return
			}

			paramCount++
			query += fmt.Sprintf(", username = $%d ", paramCount)
			args = append(args, reqData.Username)
		}

		if reqData.Password != "" {
			// Hash password
			hashedPassword, err := bcrypt.GenerateFromPassword([]byte(reqData.Password), bcrypt.DefaultCost)
			if err != nil {
				log.Printf("[UpdateProfileHandler] Password hashing failed: %v", err)
				respondWithError(w, http.StatusInternalServerError, "Error processing password")
				return
			}

			paramCount++
			query += fmt.Sprintf(", hashed_password = $%d ", paramCount)
			args = append(args, string(hashedPassword))
		}

		if reqData.Phone != "" {
			paramCount++
			query += fmt.Sprintf(", phone = $%d ", paramCount)
			args = append(args, reqData.Phone)
		}

		if reqData.Email != "" {
			// Check if email exists
			var count int
			checkQuery := "SELECT COUNT(*) FROM users WHERE email = $1 AND id != $2"
			err = db.QueryRow(checkQuery, reqData.Email, userID).Scan(&count)
			if err != nil {
				log.Printf("[UpdateProfileHandler] Email check failed: %v", err)
				respondWithError(w, http.StatusInternalServerError, "Database error")
				return
			}

			if count > 0 {
				respondWithError(w, http.StatusConflict, "Email already exists")
				return
			}

			paramCount++
			query += fmt.Sprintf(", email = $%d ", paramCount)
			args = append(args, reqData.Email)
		}

		// Complete the query
		paramCount++
		query += fmt.Sprintf(" WHERE id = $%d", paramCount)
		args = append(args, userID)

		// Log the query and arguments
		log.Printf("[UpdateProfileHandler] Query: %s", query)
		log.Printf("[UpdateProfileHandler] Args: %v", args)

		// Execute the query
		result, err := tx.Exec(query, args...)
		if err != nil {
			log.Printf("[UpdateProfileHandler] Query execution failed: %v", err)
			respondWithError(w, http.StatusInternalServerError, "Error updating profile: "+err.Error())
			return
		}

		// Check if any rows were affected
		rowsAffected, err := result.RowsAffected()
		if err != nil {
			log.Printf("[UpdateProfileHandler] Failed to get rows affected: %v", err)
			respondWithError(w, http.StatusInternalServerError, "Error checking update result")
			return
		}

		log.Printf("[UpdateProfileHandler] Rows affected: %d", rowsAffected)

		// Commit the transaction
		err = tx.Commit()
		if err != nil {
			log.Printf("[UpdateProfileHandler] Transaction commit failed: %v", err)
			respondWithError(w, http.StatusInternalServerError, "Error committing transaction")
			return
		}

		// Return success response
		log.Printf("[UpdateProfileHandler] Profile updated successfully for user ID: %d", userID)
		json.NewEncoder(w).Encode(UpdateProfileResponse{
			Success: true,
			Message: "Profile updated successfully",
		})
	}
}

// respondWithError sends an error response
func respondWithError(w http.ResponseWriter, code int, message string) {
	w.WriteHeader(code)
	json.NewEncoder(w).Encode(UpdateProfileResponse{
		Success: false,
		Message: message,
	})
}

func AddAddressHandler(w http.ResponseWriter, r *http.Request) {
	// Parse request data
	if r.Method != http.MethodPost {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		return
	}

	// Extract user ID from token
	userID, err := getUserIDFromToken(r)
	if err != nil {
		log.Printf("[AddAddressHandler] Error getting user ID from token: %v", err)
		http.Error(w, "Unauthorized access", http.StatusUnauthorized)
		return
	}

	// Parse the request body
	var addressData struct {
		AddressTypeID int    `json:"address_type_id"`
		BranchNumber  string `json:"branch_number"`
		TaxNumber     string `json:"tax_number"`
		CountryID     int    `json:"country_id"`
		ProvinceID    int    `json:"province_id"`
		DistrictID    int    `json:"district_id"`
		SubdistrictID int    `json:"subdistrict_id"`
		Street        string `json:"street"`
		Address       string `json:"address"`
		PostalCode    string `json:"postal_code"`
	}

	err = json.NewDecoder(r.Body).Decode(&addressData)
	if err != nil {
		log.Printf("[AddAddressHandler] Error decoding request body: %v", err)
		http.Error(w, "Invalid request format", http.StatusBadRequest)
		return
	}

	// Connect to database
	db := database.GetDB()

	// Begin transaction
	tx, err := db.Begin()
	if err != nil {
		log.Printf("[AddAddressHandler] Failed to begin transaction: %v", err)
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	defer tx.Rollback() // Will be ignored if transaction is committed

	// Current timestamp
	now := time.Now()

	// Insert address
	insertQuery := `
        INSERT INTO addresses (
            user_id, address_type_id, branch_number,tax_number, country_id, 
            province_id, district_id, subdistrict_id, street, 
            address, postal_code, created_at, updated_at
        ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)
        RETURNING id
    `

	var addressID int
	err = tx.QueryRow(
		insertQuery,
		userID, addressData.AddressTypeID, addressData.BranchNumber, addressData.TaxNumber, addressData.CountryID,
		addressData.ProvinceID, addressData.DistrictID, addressData.SubdistrictID, addressData.Street,
		addressData.Address, addressData.PostalCode, now, now,
	).Scan(&addressID)

	if err != nil {
		log.Printf("[AddAddressHandler] Error inserting address: %v", err)
		http.Error(w, "Failed to save address", http.StatusInternalServerError)
		return
	}

	// Commit transaction
	if err = tx.Commit(); err != nil {
		log.Printf("[AddAddressHandler] Failed to commit transaction: %v", err)
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}

	// Return success response
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusOK)
	json.NewEncoder(w).Encode(map[string]interface{}{
		"success":   true,
		"message":   "Address added successfully",
		"addressId": addressID,
	})
}

func VerifyAddressBelongsToUser(userID int, addressID int64) (bool, error) {
	db := database.GetDB()
	var count int
	err := db.QueryRow("SELECT COUNT(*) FROM addresses WHERE id = $1 AND user_id = $2", addressID, userID).Scan(&count)
	if err != nil {
		return false, err
	}
	return count > 0, nil
}

func UpdateAddressHandler(w http.ResponseWriter, r *http.Request) {
	// Parse the JSON request
	var requestData struct {
		AddressID     int64  `json:"address_id"`
		AddressTypeID *int64 `json:"address_type_id,omitempty"`
		BranchNumber  string `json:"branch_number,omitempty"`
		TaxNumber     string `json:"tax_number,omitempty"`
		CountryID     *int64 `json:"country_id,omitempty"`
		ProvinceID    *int64 `json:"province_id,omitempty"`
		DistrictID    *int64 `json:"district_id,omitempty"`
		SubdistrictID *int64 `json:"subdistrict_id,omitempty"`
		Street        string `json:"street,omitempty"`
		Address       string `json:"address,omitempty"`
		PostalCode    string `json:"postal_code,omitempty"`
	}

	err := json.NewDecoder(r.Body).Decode(&requestData)
	if err != nil {
		http.Error(w, "Invalid request format", http.StatusBadRequest)
		return
	}

	// Get current user ID from session
	userID, err := getUserIDFromToken(r)
	if err != nil {
		log.Printf("[UpdateAddressHandler] Error getting user ID from token: %v", err)
		http.Error(w, "Unauthorized access", http.StatusUnauthorized)
		return
	}

	// Get database connection
	db := database.GetDB()

	// Verify that the address belongs to the user
	addressExists, err := VerifyAddressBelongsToUser(userID, requestData.AddressID)
	if err != nil {
		log.Printf("Error verifying address ownership: %v", err)
		http.Error(w, "Server error", http.StatusInternalServerError)
		return
	}
	if !addressExists {
		http.Error(w, "Address not found or does not belong to user", http.StatusForbidden)
		return
	}

	// Start building SQL update statement and values
	query := "UPDATE addresses SET updated_at = NOW()"
	var args []interface{}
	var argIndex int = 1

	// Add fields to update only if they are provided in the request
	if requestData.AddressTypeID != nil {
		query += fmt.Sprintf(", address_type_id = $%d", argIndex)
		args = append(args, *requestData.AddressTypeID)
		argIndex++
	}
	if requestData.BranchNumber != "" {
		query += fmt.Sprintf(", branch_number = $%d", argIndex)
		args = append(args, requestData.BranchNumber)
		argIndex++
	}
	if requestData.TaxNumber != "" {
		query += fmt.Sprintf(", tax_number = $%d", argIndex)
		args = append(args, requestData.TaxNumber)
		argIndex++
	}
	if requestData.CountryID != nil {
		query += fmt.Sprintf(", country_id = $%d", argIndex)
		args = append(args, *requestData.CountryID)
		argIndex++
	}
	if requestData.ProvinceID != nil {
		query += fmt.Sprintf(", province_id = $%d", argIndex)
		args = append(args, *requestData.ProvinceID)
		argIndex++
	}
	if requestData.DistrictID != nil {
		query += fmt.Sprintf(", district_id = $%d", argIndex)
		args = append(args, *requestData.DistrictID)
		argIndex++
	}
	if requestData.SubdistrictID != nil {
		query += fmt.Sprintf(", subdistrict_id = $%d", argIndex)
		args = append(args, *requestData.SubdistrictID)
		argIndex++
	}
	if requestData.Street != "" {
		query += fmt.Sprintf(", street = $%d", argIndex)
		args = append(args, requestData.Street)
		argIndex++
	}
	if requestData.Address != "" {
		query += fmt.Sprintf(", address = $%d", argIndex)
		args = append(args, requestData.Address)
		argIndex++
	}
	if requestData.PostalCode != "" {
		query += fmt.Sprintf(", postal_code = $%d", argIndex)
		args = append(args, requestData.PostalCode)
		argIndex++
	}

	// Add WHERE clause at the end with the address ID
	query += fmt.Sprintf(" WHERE id = $%d", argIndex)
	args = append(args, requestData.AddressID)

	// If no fields to update besides timestamp, handle accordingly
	if argIndex == 1 { // Only have the WHERE clause parameter
		query = "UPDATE addresses SET updated_at = NOW() WHERE id = $1"
	}

	// Execute the update query
	_, err = db.Exec(query, args...)
	if err != nil {
		log.Printf("Error updating address: %v", err)
		http.Error(w, "Server error when updating address", http.StatusInternalServerError)
		return
	}

	// Return success response
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"success": true,
		"message": "Address updated successfully",
	})
}

// Fix for the GetAddressHandler function
func GetAddressHandler(w http.ResponseWriter, r *http.Request) {
	// Get address ID from query parameter
	addressIDStr := r.URL.Query().Get("id")
	if addressIDStr == "" {
		http.Error(w, "Address ID is required", http.StatusBadRequest)
		return
	}

	addressID, err := strconv.ParseInt(addressIDStr, 10, 64)
	if err != nil {
		http.Error(w, "Invalid address ID", http.StatusBadRequest)
		return
	}

	// Get current user ID from session
	userID, err := getUserIDFromToken(r)
	if err != nil {
		log.Printf("[GetAddressHandler] Error getting user ID from token: %v", err)
		http.Error(w, "Unauthorized access", http.StatusUnauthorized)
		return
	}

	// Get database connection
	db := database.GetDB()

	// Query to get address details
	query := `
        SELECT a.id, a.address_type_id, a.branch_number,a.tax_number , a.country_id, a.province_id, 
               a.district_id, a.subdistrict_id, a.street, a.address, a.postal_code
        FROM addresses a
        WHERE a.id = $1 AND a.user_id = $2
    `

	var address struct {
		ID            int64          `json:"id"`
		AddressTypeID sql.NullInt64  `json:"address_type_id"`
		BranchNumber  sql.NullString `json:"branch_number"`
		TaxNumber     sql.NullString `json:"tax_number"`
		CountryID     sql.NullInt64  `json:"country_id"`
		ProvinceID    sql.NullInt64  `json:"province_id"`
		DistrictID    sql.NullInt64  `json:"district_id"`
		SubdistrictID sql.NullInt64  `json:"subdistrict_id"`
		Street        sql.NullString `json:"street"`
		Address       sql.NullString `json:"address"`
		PostalCode    sql.NullString `json:"postal_code"`
	}

	err = db.QueryRow(query, addressID, userID).Scan(
		&address.ID, &address.AddressTypeID, &address.BranchNumber, &address.TaxNumber, &address.CountryID,
		&address.ProvinceID, &address.DistrictID, &address.SubdistrictID,
		&address.Street, &address.Address, &address.PostalCode,
	)

	if err != nil {
		if err == sql.ErrNoRows {
			http.Error(w, "Address not found or does not belong to user", http.StatusNotFound)
		} else {
			log.Printf("Error fetching address: %v", err)
			http.Error(w, "Server error", http.StatusInternalServerError)
		}
		return
	}

	// Convert SQL null values to JSON appropriate values
	response := map[string]interface{}{
		"success": true,
		"address": map[string]interface{}{
			"id": address.ID,
		},
	}

	// Only include fields that have values
	addressData := response["address"].(map[string]interface{})

	if address.AddressTypeID.Valid {
		addressData["address_type_id"] = address.AddressTypeID.Int64
	}
	if address.BranchNumber.Valid {
		addressData["branch_number"] = address.BranchNumber.String
	}
	if address.TaxNumber.Valid {
		addressData["tax_number"] = address.TaxNumber.String
	}
	if address.CountryID.Valid {
		addressData["country_id"] = address.CountryID.Int64
	}
	if address.ProvinceID.Valid {
		addressData["province_id"] = address.ProvinceID.Int64
	}
	if address.DistrictID.Valid {
		addressData["district_id"] = address.DistrictID.Int64
	}
	if address.SubdistrictID.Valid {
		addressData["subdistrict_id"] = address.SubdistrictID.Int64
	}
	if address.Street.Valid {
		addressData["street"] = address.Street.String
	}
	if address.Address.Valid {
		addressData["address"] = address.Address.String
	}
	if address.PostalCode.Valid {
		addressData["postal_code"] = address.PostalCode.String
	}

	// Return the address data as JSON
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}
