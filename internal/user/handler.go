package user

import (
	"fmt"
	"html/template"
	"log"
	"net/http"
	"regexp"
	"time"

	"github.com/golang-jwt/jwt"

	"github.com/thongsoi/biomassx-05/database"
	"golang.org/x/crypto/bcrypt"
)

var jwtKey = []byte("your_secret_key")

// Regular expression to validate email format
var emailRegex = regexp.MustCompile(`^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$`)

func RegisterHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method == "GET" {

		language := r.URL.Query().Get("lang")
		if language == "" {
			language = getLanguageFromToken(r)
		}
		if language == "" {
			language = "en"
		}

		var contentFile string
		switch language {
		case "th":
			contentFile = "views/pages/th/register_th.html"
		case "en":
			contentFile = "views/pages/en/register_en.html"
		default:
			http.Error(w, "Invalid language", http.StatusBadRequest)
			return
		}

		// Parse base template + content template
		tmpl, err := template.ParseFiles("views/pages/register.html", contentFile)
		if err != nil {
			log.Println("Error parsing template:", err)
			http.Error(w, "Template not found", http.StatusInternalServerError)
			return
		}

		// ส่งค่า lang ไปที่ Template
		data := map[string]string{
			"lang": language,
		}
		log.Println("Selected language:", language)

		tmpl.ExecuteTemplate(w, "base", data)

		return
	}

	// Parse form values
	firstName := r.FormValue("firstName")
	lastName := r.FormValue("lastName")
	organizationName := r.FormValue("organizationName")
	username := r.FormValue("username")
	password := r.FormValue("password")
	phone := r.FormValue("phone")
	email := r.FormValue("email")

	// Check for empty fields
	if firstName == "" || lastName == "" || username == "" || password == "" || phone == "" || email == "" {
		http.Error(w, "All fields are required", http.StatusBadRequest)
		return
	}

	// Validate email format
	if !emailRegex.MatchString(email) {
		http.Error(w, "Invalid email format", http.StatusBadRequest)
		return
	}

	// Check if username already exists
	var exists bool
	err := database.DB.QueryRow("SELECT EXISTS(SELECT 1 FROM users WHERE username=$1)", username).Scan(&exists)
	if err != nil {
		http.Error(w, "Database error", http.StatusInternalServerError)
		return
	}
	if exists {
		http.Error(w, "Username already exists", http.StatusConflict)
		return
	}

	// Hash the password
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
	if err != nil {
		http.Error(w, "Error hashing password", http.StatusInternalServerError)
		return
	}

	// Get current timestamp
	createdAt := time.Now()

	// Insert new user into database
	_, err = database.DB.Exec(
		"INSERT INTO users (first_name, last_name, organization_name, username, hashed_password, phone, email, created_at) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)",
		firstName, lastName, organizationName, username, string(hashedPassword), phone, email, createdAt,
	)
	if err != nil {
		http.Error(w, "Error creating user", http.StatusInternalServerError)
		return
	}

	// Redirect to login page with success message
	//http.Redirect(w, r, "/login", http.StatusSeeOther)

	// Return success message as HTML
	w.WriteHeader(http.StatusOK)
	fmt.Fprintf(w, "<div style='color: green;'>Registration successful</div>")

}

func getLanguageFromToken(r *http.Request) string {
	cookie, err := r.Cookie("token")
	if err != nil {
		return "en" // Default language if no cookie
	}

	token, err := jwt.Parse(cookie.Value, func(token *jwt.Token) (interface{}, error) {
		return jwtKey, nil
	})
	if err != nil || !token.Valid {
		return "en" // Default language if token is invalid
	}

	claims, ok := token.Claims.(jwt.MapClaims)
	if !ok {
		return "en"
	}

	lang, ok := claims["language"].(string)
	if !ok {
		return "en"
	}

	return lang
}

func getUserIDFromToken(r *http.Request) (int, error) {
	log.Println("[getUserIDFromToken] Extracting token from cookies")

	// ดึง token จาก cookie
	cookie, err := r.Cookie("token")
	if err != nil {
		log.Printf("[getUserIDFromToken] Error retrieving token from cookies: %v", err)
		return 0, err
	}

	// Parse token และตรวจสอบความถูกต้อง
	log.Println("[getUserIDFromToken] Parsing and validating token")
	token, err := jwt.Parse(cookie.Value, func(token *jwt.Token) (interface{}, error) {
		return jwtKey, nil
	})
	if err != nil || !token.Valid {
		log.Printf("[getUserIDFromToken] Invalid or expired token: %v", err)
		return 0, err
	}

	// ดึง claims จาก token
	log.Println("[getUserIDFromToken] Extracting claims from token")
	claims, ok := token.Claims.(jwt.MapClaims)
	if !ok {
		log.Println("[getUserIDFromToken] Error converting token claims")
		return 0, err
	}

	// ดึงค่า user_id จาก claims
	userID := int(claims["user_id"].(float64))
	log.Printf("[getUserIDFromToken] Successfully extracted user_id: %d", userID)
	return userID, nil
}

func ProfileHandler(w http.ResponseWriter, r *http.Request) {
	// ดึงค่าภาษา
	language := r.URL.Query().Get("lang")
	if language == "" {
		language = getLanguageFromToken(r)
	}
	if language == "" {
		language = "en"
	}

	// ดึง user_id จาก token
	userID, err := getUserIDFromToken(r)
	if err != nil {
		http.Error(w, "Unauthorized", http.StatusUnauthorized)
		return
	}

	// เชื่อมต่อ Database
	db := database.GetDB()

	// ดึงข้อมูลผู้ใช้
	user, err := fetchUserData(db, userID)
	if err != nil {
		log.Println("Error fetching user:", err) // เพิ่ม log ที่จุดนี้
		http.Error(w, "User not found", http.StatusNotFound)
		return
	}

	if user == nil {
		log.Println("Fetched user data is nil") // เพิ่ม log ที่จุดนี้
		http.Error(w, "User data is invalid", http.StatusInternalServerError)
		return
	}

	// กำหนดไฟล์ content ตามภาษา
	var contentFile string
	switch language {
	case "th":
		contentFile = "views/pages/th/profile_th.html"
	case "en":
		contentFile = "views/pages/en/profile_en.html"
	default:
		http.Error(w, "Invalid language", http.StatusBadRequest)
		return
	}

	// Parse base template + content template
	tmpl, err := template.ParseFiles("views/pages/profile.html", contentFile)
	if err != nil {
		log.Println("Error parsing template:", err)
		http.Error(w, "Template not found", http.StatusInternalServerError)
		return
	}

	// ใส่ข้อมูลลงในเทมเพลต
	data := map[string]interface{}{
		"lang": language,
		"user": user,
	}
	log.Println("Selected language:", language)

	tmpl.ExecuteTemplate(w, "base", data)
}
