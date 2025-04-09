package middleware

import (
	"fmt"
	"html/template"
	"log"
	"net/http"
	"time"

	"github.com/thongsoi/biomassx-05/database"
	"github.com/thongsoi/biomassx-05/internal/user"

	"github.com/golang-jwt/jwt"
	"golang.org/x/crypto/bcrypt"
)

var jwtKey = []byte("your_secret_key")

func LoginHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method == "GET" {
		language := r.URL.Query().Get("lang") // ✅ เปลี่ยนจาก "Lang" เป็น "lang"
		if language == "" {
			language = getLanguageFromToken(r) // ✅ อ่านค่าจาก Token ถ้ามี
		}
		if language == "" {
			language = "en" // Default
		}

		var contentFile string
		switch language {
		case "th":
			contentFile = "views/pages/th/login_th.html"
		case "en":
			contentFile = "views/pages/en/login_en.html"
		default:
			http.Error(w, "Invalid language", http.StatusBadRequest)
			return
		}

		tmpl, err := template.ParseFiles("views/pages/login.html", contentFile)
		if err != nil {
			log.Println("Error parsing template:", err)
			http.Error(w, "Template not found", http.StatusInternalServerError)
			return
		}

		data := map[string]string{
			"lang": language,
		}

		tmpl.ExecuteTemplate(w, "base", data)
		return
	}

	language := r.FormValue("lang")
	if language == "" {
		language = getLanguageFromToken(r)
	}
	if language == "" {
		language = "en"
	}
	log.Println("Selected language:", language)

	username := r.FormValue("username")
	password := r.FormValue("password")

	var user user.User
	if err := database.DB.QueryRow("SELECT id, username, hashed_password FROM users WHERE username = $1", username).Scan(&user.ID, &user.Username, &user.Password); err != nil {
		w.Write([]byte(`<div class="error">Login failed. The username has not been registered. Please try again.</div>`))
		return
	}

	if err := bcrypt.CompareHashAndPassword([]byte(user.Password), []byte(password)); err != nil {
		w.Write([]byte(`<div class="error">Login failed. The username has been registered. Please recheck your password and try again.</div>`))
		return
	}

	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"user_id":  user.ID,
		"language": language, // ✅ บันทึกค่าภาษาใน Token
		"exp":      time.Now().Add(time.Minute * 60).Unix(),
	})

	tokenString, err := token.SignedString(jwtKey)
	if err != nil {
		http.Error(w, "Error creating token", http.StatusInternalServerError)
		return
	}

	http.SetCookie(w, &http.Cookie{
		Name:     "token",
		Value:    tokenString,
		Expires:  time.Now().Add(24 * time.Hour),
		HttpOnly: true,
	})

	w.Write([]byte(`<div class="success">Login successful! Redirecting...</div><script>window.location.href = '/dashboard';</script>`))
	fmt.Println("user id is", user.ID)
}

func LogoutHandler(w http.ResponseWriter, r *http.Request) {
	http.SetCookie(w, &http.Cookie{
		Name:     "token",
		Value:    "",
		Expires:  time.Now().Add(-time.Hour),
		HttpOnly: true,
	})
	w.Header().Set("HX-Redirect", "/login")
}

func AuthMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		cookie, err := r.Cookie("token")
		if err != nil {
			http.Redirect(w, r, "/login", http.StatusSeeOther)
			return
		}

		token, err := jwt.Parse(cookie.Value, func(token *jwt.Token) (interface{}, error) {
			return jwtKey, nil
		})

		if err != nil || !token.Valid {
			http.Redirect(w, r, "/login", http.StatusSeeOther)
			return
		}

		next.ServeHTTP(w, r)
	})
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
