package user

import (
	"database/sql"
	"encoding/json"
	"net/http"

	"github.com/thongsoi/biomassx-05/database"
)

// API endpoints to fetch data for cascading forms

// 1. Handler for fetching address types
func GetAddressTypesHandler(w http.ResponseWriter, r *http.Request) {
	db := database.GetDB()

	rows, err := db.Query("SELECT id, en_name, th_name FROM address_types ORDER BY en_name")
	if err != nil {
		http.Error(w, "Failed to fetch address types", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var addressTypes []map[string]interface{}
	for rows.Next() {
		var id int
		var enName, thName sql.NullString
		if err := rows.Scan(&id, &enName, &thName); err != nil {
			http.Error(w, "Error processing data", http.StatusInternalServerError)
			return
		}
		addressTypes = append(addressTypes, map[string]interface{}{
			"id":     id,
			"enName": enName.String,
			"thName": thName.String,
		})
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"success":      true,
		"addressTypes": addressTypes,
	})
}

// 2. Handler for fetching countries
func GetCountriesHandler(w http.ResponseWriter, r *http.Request) {
	db := database.GetDB()

	rows, err := db.Query("SELECT id, en_name, th_name FROM countries ORDER BY en_name")
	if err != nil {
		http.Error(w, "Failed to fetch countries", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var countries []map[string]interface{}
	for rows.Next() {
		var id int
		var enName, thName sql.NullString
		if err := rows.Scan(&id, &enName, &thName); err != nil {
			http.Error(w, "Error processing data", http.StatusInternalServerError)
			return
		}
		countries = append(countries, map[string]interface{}{
			"id":     id,
			"enName": enName.String,
			//"thName": thName.String,
		})
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"success":   true,
		"countries": countries,
	})
}

// 3. Handler for fetching provinces by country
func GetProvincesHandler(w http.ResponseWriter, r *http.Request) {
	countryID := r.URL.Query().Get("countryId")
	if countryID == "" {
		http.Error(w, "Country ID is required", http.StatusBadRequest)
		return
	}

	db := database.GetDB()
	rows, err := db.Query("SELECT id, en_name, th_name FROM provinces WHERE country_id = $1 ORDER BY en_name", countryID)
	if err != nil {
		http.Error(w, "Failed to fetch provinces", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var provinces []map[string]interface{}
	for rows.Next() {
		var id int
		var enName, thName sql.NullString
		if err := rows.Scan(&id, &enName, &thName); err != nil {
			http.Error(w, "Error processing data", http.StatusInternalServerError)
			return
		}
		provinces = append(provinces, map[string]interface{}{
			"id":     id,
			"enName": enName.String,
			"thName": thName.String,
		})
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"success":   true,
		"provinces": provinces,
	})
}

// 4. Handler for fetching districts by province
func GetDistrictsHandler(w http.ResponseWriter, r *http.Request) {
	provinceID := r.URL.Query().Get("provinceId")
	if provinceID == "" {
		http.Error(w, "Province ID is required", http.StatusBadRequest)
		return
	}

	db := database.GetDB()

	rows, err := db.Query("SELECT id, en_name, th_name FROM districts WHERE province_id = $1 ORDER BY en_name", provinceID)
	if err != nil {
		http.Error(w, "Failed to fetch districts", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var districts []map[string]interface{}
	for rows.Next() {
		var id int
		var enName, thName sql.NullString
		if err := rows.Scan(&id, &enName, &thName); err != nil {
			http.Error(w, "Error processing data", http.StatusInternalServerError)
			return
		}
		districts = append(districts, map[string]interface{}{
			"id":     id,
			"enName": enName.String,
			"thName": thName.String,
		})
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"success":   true,
		"districts": districts,
	})
}

// 5. Handler for fetching subdistricts by district
func GetSubdistrictsHandler(w http.ResponseWriter, r *http.Request) {
	districtID := r.URL.Query().Get("districtId")
	if districtID == "" {
		http.Error(w, "District ID is required", http.StatusBadRequest)
		return
	}

	db := database.GetDB()

	rows, err := db.Query("SELECT id, en_name, th_name FROM subdistricts WHERE district_id = $1 ORDER BY en_name", districtID)
	if err != nil {
		http.Error(w, "Failed to fetch subdistricts", http.StatusInternalServerError)
		return
	}
	defer rows.Close()

	var subdistricts []map[string]interface{}
	for rows.Next() {
		var id int
		var enName, thName sql.NullString
		if err := rows.Scan(&id, &enName, &thName); err != nil {
			http.Error(w, "Error processing data", http.StatusInternalServerError)
			return
		}
		subdistricts = append(subdistricts, map[string]interface{}{
			"id":     id,
			"enName": enName.String,
			"thName": thName.String,
		})
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(map[string]interface{}{
		"success":      true,
		"subdistricts": subdistricts,
	})
}
