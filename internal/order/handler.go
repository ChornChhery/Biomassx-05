package order

import (
	//"encoding/json"
	"database/sql"
	"html/template"
	"log"
	"net/http"

	"github.com/golang-jwt/jwt"
	"github.com/thongsoi/biomassx-05/database"
)

var jwtKey = []byte("your_secret_key")

// Helper function to parse JWT and return user ID
func getUserIDFromToken(r *http.Request) (int, error) {
	cookie, err := r.Cookie("token")
	if err != nil {
		return 0, err
	}

	token, err := jwt.Parse(cookie.Value, func(token *jwt.Token) (interface{}, error) {
		return jwtKey, nil
	})
	if err != nil || !token.Valid {
		return 0, err
	}

	claims, ok := token.Claims.(jwt.MapClaims)
	if !ok {
		return 0, err
	}
	userID := int(claims["user_id"].(float64))
	return userID, nil
}

func OrderHandler(w http.ResponseWriter, r *http.Request) {
	db := database.GetDB()
	log.Printf("Handling request: %s %s", r.Method, r.URL.Path)

	if r.Method == http.MethodGet {
		log.Println("Handling GET request for order form")

		// เลือกภาษา
		language := r.URL.Query().Get("lang")
		if language == "" {
			language = "en"
		}

		var contentFile string
		switch language {
		case "th":
			contentFile = "views/pages/th/order_th.html"
		case "en":
			contentFile = "views/pages/en/order_en.html"
		default:
			http.Error(w, "Invalid language", http.StatusBadRequest)
			return
		}

		// ดึงข้อมูลที่ต้องใช้ทั้งหมด
		data, err := fetchOrderData(db)
		if err != nil {
			http.Error(w, "Unable to fetch order data", http.StatusInternalServerError)
			return
		}

		// โหลดเทมเพลต
		tmpl, err := template.ParseFiles("views/pages/order.html", contentFile)
		if err != nil {
			log.Println("Error parsing template:", err)
			http.Error(w, "Template not found", http.StatusInternalServerError)
			return
		}

		log.Println("Selected language:", language)
		data["lang"] = language

		tmpl.ExecuteTemplate(w, "base", data)
	} else if r.Method == http.MethodPost {
		log.Println("Handling POST request for creating order")
		SubmitOrderHandler(w, r)
	} else {
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
	}
}

func fetchOrderData(db *sql.DB) (map[string]interface{}, error) {

	marketspaces, err := FetchMarketspaces(db)
	if err != nil {
		return nil, err
	}
	markets, err := FetchMarkets(db)
	if err != nil {
		return nil, err
	}
	orderTypes, err := FetchOrderTypes(db)
	if err != nil {
		return nil, err
	}
	matchingTypes, err := FetchMatchingTypes(db)
	if err != nil {
		return nil, err
	}
	contractTypes, err := FetchContractTypes(db)
	if err != nil {
		return nil, err
	}
	currencies, err := FetchCurrency(db)
	if err != nil {
		return nil, err
	}
	uomIDs, err := FetchUom(db)
	if err != nil {
		return nil, err
	}
	packingIDs, err := FetchPacking(db)
	if err != nil {
		return nil, err
	}
	countryIDs, err := FetchCountry(db)
	if err != nil {
		return nil, err
	}
	portOfLoadings, err := FetchPortofloadings(db)
	if err != nil {
		return nil, err
	}
	portOfDischarges, err := FetchPortofdischarges(db)
	if err != nil {
		return nil, err
	}
	provinces, err := FetchProvinces(db)
	if err != nil {
		return nil, err
	}

	return map[string]interface{}{
		"Marketspaces":     marketspaces,
		"Markets":          markets,
		"OrderTypes":       orderTypes,
		"MatchingTypes":    matchingTypes,
		"ContractTypes":    contractTypes,
		"Currencies":       currencies,
		"UomIDs":           uomIDs,
		"PackingIDs":       packingIDs,
		"CountryIDs":       countryIDs,
		"Portofloadings":   portOfLoadings,
		"Portofdischarges": portOfDischarges,
		"Provinces":        provinces,
	}, nil
}
