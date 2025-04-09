package middleware

import (
	"html/template"
	"log"
	"net/http"
)

func ServiceHandler(w http.ResponseWriter, r *http.Request) {
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
		contentFile = "views/pages/th/services_th.html"
	case "en":
		contentFile = "views/pages/en/services_en.html"
	default:
		http.Error(w,  "Invalid language", http.StatusBadRequest)
		return
	}

	// Parse base template + content template
	tmpl, err := template.ParseFiles("views/pages/services.html", contentFile)
	if err != nil {
		log.Println("Error parsing template:", err)
		http.Error(w, "Template not found", http.StatusInternalServerError)
		return
	}

	data := map[string]string{
		"lang": language, 
	}
	log.Println("Selected language:", language)

	tmpl.ExecuteTemplate(w, "base", data)
}
