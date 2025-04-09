package order

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strconv"
	"time"

	"github.com/thongsoi/biomassx-05/database"
	"github.com/thongsoi/biomassx-05/internal/matching"
)

func FetchMarketspaces(db *sql.DB) ([]Marketspace, error) {
	rows, err := db.Query("SELECT id, en_name, th_name FROM marketspaces ORDER BY id ASC")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var marketspaces []Marketspace
	for rows.Next() {
		var marketspace Marketspace
		err := rows.Scan(&marketspace.ID, &marketspace.EnName, &marketspace.ThName)
		if err != nil {
			log.Println(err)
			continue
		}
		marketspaces = append(marketspaces, marketspace)
	}
	return marketspaces, nil
}

func FetchMarkets(db *sql.DB) ([]Market, error) {
	rows, err := db.Query("SELECT id, en_name, th_name FROM markets ORDER BY id ASC")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var markets []Market
	for rows.Next() {
		var market Market
		err := rows.Scan(&market.ID, &market.EnName, &market.ThName)
		if err != nil {
			log.Println(err)
			continue
		}
		markets = append(markets, market)
	}
	return markets, nil
}

func FetchOrderTypes(db *sql.DB) ([]OrderType, error) {
	rows, err := db.Query("SELECT id, en_name,th_name FROM order_types ORDER BY id ASC")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var orderTypes []OrderType
	for rows.Next() {
		var orderType OrderType
		err := rows.Scan(&orderType.ID, &orderType.EnName, &orderType.ThName)
		if err != nil {
			log.Println(err)
			continue
		}
		orderTypes = append(orderTypes, orderType)
	}
	return orderTypes, nil
}

func FetchMatchingTypes(db *sql.DB) ([]MatchingType, error) {
	rows, err := db.Query("SELECT id, en_name, th_name FROM matching_types WHERE id=7 ORDER BY id ASC")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var matchingTypes []MatchingType
	for rows.Next() {
		var matchingType MatchingType
		err := rows.Scan(&matchingType.ID, &matchingType.EnName, &matchingType.ThName)
		if err != nil {
			log.Println(err)
			continue
		}
		matchingTypes = append(matchingTypes, matchingType)
	}
	return matchingTypes, nil
}

func FetchContractTypes(db *sql.DB) ([]ContractType, error) {
	rows, err := db.Query("SELECT id, en_name,th_name FROM contract_types ORDER BY id ASC")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var contractTypes []ContractType
	for rows.Next() {
		var contractType ContractType
		err := rows.Scan(&contractType.ID, &contractType.EnName, &contractType.ThName)
		if err != nil {
			log.Println(err)
			continue
		}
		contractTypes = append(contractTypes, contractType)
	}
	return contractTypes, nil
}

func FetchUom(db *sql.DB) ([]Uom_id, error) {
	rows, err := db.Query("SELECT id,en_name, th_name FROM uoms ORDER BY id ASC")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var uom_ids []Uom_id
	for rows.Next() {
		var uom_id Uom_id
		err := rows.Scan(&uom_id.ID, &uom_id.EnName, &uom_id.ThName)
		if err != nil {
			log.Println(err)
			continue
		}
		uom_ids = append(uom_ids, uom_id)
	}
	return uom_ids, nil
}

func FetchCurrency(db *sql.DB) ([]Currency, error) {
	rows, err := db.Query("SELECT id,code FROM currencies ORDER BY id ASC")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var currencies []Currency
	for rows.Next() {
		var currency Currency
		err := rows.Scan(&currency.ID, &currency.Code)
		if err != nil {
			log.Println(err)
			continue
		}
		currencies = append(currencies, currency)
	}
	return currencies, nil
}

func FetchPacking(db *sql.DB) ([]PackingID, error) {
	rows, err := db.Query("SELECT id,en_name,th_name FROM packings ORDER BY id ASC")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var packingIDs []PackingID
	for rows.Next() {
		var packingID PackingID
		err := rows.Scan(&packingID.ID, &packingID.EnName, &packingID.ThName)
		if err != nil {
			log.Println(err)
			continue
		}
		packingIDs = append(packingIDs, packingID)
	}
	return packingIDs, nil
}

func FetchCountry(db *sql.DB) ([]Country, error) {
	rows, err := db.Query("SELECT id,en_name FROM countries ORDER BY id ASC")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var countryIDs []Country
	for rows.Next() {
		var countryID Country
		err := rows.Scan(&countryID.ID, &countryID.EnName)
		if err != nil {
			log.Println(err)
			continue
		}
		countryIDs = append(countryIDs, countryID)
	}
	return countryIDs, nil
}

func FetchSubmarketsByMarketID(db *sql.DB, marketID int) ([]Submarket, error) {
	rows, err := db.Query("SELECT id, en_name, th_name  FROM submarkets WHERE market_id = $1 ORDER BY en_name ASC", marketID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var submarkets []Submarket
	for rows.Next() {
		var submarket Submarket
		err := rows.Scan(&submarket.ID, &submarket.EnName, &submarket.ThName)
		if err != nil {
			log.Println(err)
			continue
		}
		submarkets = append(submarkets, submarket)
	}
	return submarkets, nil
}

func FetchProductsBySubmarketID(db *sql.DB, submarketID int) ([]Product, error) {
	rows, err := db.Query("SELECT id, en_name, th_name FROM products WHERE submarket_id = $1 ORDER BY en_name ASC", submarketID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var products []Product
	for rows.Next() {
		var product Product
		err := rows.Scan(&product.ID, &product.EnName, &product.ThName)
		if err != nil {
			log.Println(err)
			continue
		}
		products = append(products, product)
	}
	return products, nil
}

func FetchQualitiesByProductID(db *sql.DB, productID int) ([]Quality, error) {
	query := `
        SELECT q.id, q.standard_id, s.en_name as standard_en_name, q.grade_id, g.en_name as grade_en_name
        FROM qualities q
        LEFT JOIN standards s ON q.standard_id = s.id
        LEFT JOIN grades g ON q.grade_id = g.id
        WHERE q.product_id = $1
        ORDER BY s.en_name ASC
    `
	rows, err := db.Query(query, productID)
	if err != nil {
		return nil, fmt.Errorf("database query error: %w", err)
	}
	defer rows.Close()

	var qualities []Quality
	for rows.Next() {
		var quality Quality
		var standardEnName, gradeEnName string
		if err := rows.Scan(&quality.ID, &quality.StandardID, &standardEnName, &quality.GradeID, &gradeEnName); err != nil {
			log.Printf("Error scanning row: %v", err)
			continue
		}

		// เพิ่มค่า en_name ที่ดึงมาจาก standards และ grades ลงใน Quality struct
		quality.StandardID = standardEnName
		quality.GradeID = gradeEnName
		qualities = append(qualities, quality)
	}

	if err := rows.Err(); err != nil {
		return nil, fmt.Errorf("row iteration error: %w", err)
	}

	return qualities, nil
}

func FetchPortofloadings(db *sql.DB) ([]Portofloading, error) {
	rows, err := db.Query("SELECT id,en_name,th_name FROM ports ORDER BY id ASC")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var portofloadings []Portofloading
	for rows.Next() {
		var portofloading Portofloading
		err := rows.Scan(&portofloading.ID, &portofloading.EnName, &portofloading.ThName)
		if err != nil {
			log.Println(err)
			continue
		}
		portofloadings = append(portofloadings, portofloading)
	}
	return portofloadings, nil
}

func FetchPortofdischarges(db *sql.DB) ([]Portofdischarge, error) {
	rows, err := db.Query("SELECT id,en_name,th_name FROM ports ORDER BY id ASC")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var portofdischarges []Portofdischarge
	for rows.Next() {
		var portofdischarge Portofdischarge
		err := rows.Scan(&portofdischarge.ID, &portofdischarge.EnName, &portofdischarge.ThName)
		if err != nil {
			log.Println(err)
			continue
		}
		portofdischarges = append(portofdischarges, portofdischarge)
	}
	return portofdischarges, nil
}

func FetchProvinces(db *sql.DB) ([]Province, error) {
	rows, err := db.Query("SELECT id,en_name,th_name FROM provinces ORDER BY id ASC")
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var provinces []Province
	for rows.Next() {
		var province Province
		err := rows.Scan(&province.ID, &province.EnName, &province.ThName)
		if err != nil {
			log.Println(err)
			continue
		}
		provinces = append(provinces, province)
	}
	return provinces, nil
}

func FetchDistrictByProvinceID(db *sql.DB, provinceID int) ([]District, error) {
	rows, err := db.Query("SELECT id, en_name,th_name FROM districts WHERE province_id = $1 ORDER BY en_name ASC", provinceID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var districts []District
	for rows.Next() {
		var district District
		err := rows.Scan(&district.ID, &district.EnName, &district.ThName)
		if err != nil {
			log.Println(err)
			continue
		}
		districts = append(districts, district)
	}
	return districts, nil
}

func FetchSubdistrictByProvinceID(db *sql.DB, districtID int) ([]Subdistrict, error) {
	rows, err := db.Query("SELECT id, en_name, th_name FROM subdistricts WHERE district_id = $1 ORDER BY en_name ASC", districtID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var subdistricts []Subdistrict
	for rows.Next() {
		var subdistrict Subdistrict
		err := rows.Scan(&subdistrict.ID, &subdistrict.EnName, &subdistrict.ThName)
		if err != nil {
			log.Println(err)
			continue
		}
		subdistricts = append(subdistricts, subdistrict)
	}
	return subdistricts, nil
}

func FetchPaymentbyMarketspaceID(db *sql.DB, marketspaceID int) ([]Payment, error) {
	query := `
	SELECT pt.id, pt.en_name, pt.th_name
	FROM payment_terms_marketspaces ptm
	INNER JOIN payment_terms pt ON ptm.payment_term_id = pt.id
	WHERE ptm.marketspace_id = $1
	ORDER BY pt.en_name ASC
`
	rows, err := db.Query(query, marketspaceID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var payments []Payment
	for rows.Next() {
		var payment Payment
		err := rows.Scan(&payment.ID, &payment.EnName, &payment.ThName)
		if err != nil {
			log.Println(err)
			continue
		}
		payments = append(payments, payment)
	}
	return payments, nil
}

func FetchDeliveryByMarketspaceID(db *sql.DB, marketspaceID int) ([]Delivery, error) {
	query := `
        SELECT dt.id, dt.en_name, dt.th_name
        FROM delivery_terms_marketspaces dtm
        INNER JOIN delivery_terms dt ON dtm.delivery_term_id = dt.id
        WHERE dtm.marketspace_id = $1
        ORDER BY dt.en_name ASC
    `
	rows, err := db.Query(query, marketspaceID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var deliverys []Delivery // ใช้ตัวแปรนี้ตามที่คุณต้องการ
	for rows.Next() {
		var delivery Delivery
		err := rows.Scan(&delivery.ID, &delivery.EnName, &delivery.ThName)
		if err != nil {
			log.Println("Error scanning row:", err)
			continue
		}
		deliverys = append(deliverys, delivery)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return deliverys, nil // ส่งคืน deliverys
}

// /////////////////////////////////////////////////////////////////////
func SubmitOrderHandler(w http.ResponseWriter, r *http.Request) {
	db := database.GetDB()

	// Get user ID from token
	userID, err := getUserIDFromToken(r)
	if err != nil {
		log.Printf("Error parsing token: %v", err)
		http.Error(w, "Unauthorized", http.StatusUnauthorized)
		return
	}

	var order Order
	order.UserID = userID

	if r.Header.Get("Content-Type") == "application/json" {
		// Parse JSON Payload
		err := json.NewDecoder(r.Body).Decode(&order)
		if err != nil {
			log.Printf("Error decoding JSON: %v", err)
			http.Error(w, "Invalid JSON payload", http.StatusBadRequest)
			return
		}
	} else {
		// Parse form data
		err := r.ParseForm()
		if err != nil {
			log.Printf("Error parsing form: %v", err)
			http.Error(w, "Invalid form data", http.StatusBadRequest)
			return
		}

		// Map form data to struct
		order.MarketspaceID = atoi(r.FormValue("marketspaceID"))
		order.MarketID = atoi(r.FormValue("marketID"))
		order.SubmarketID = atoi(r.FormValue("submarketID"))
		order.OrderTypeID = atoi(r.FormValue("orderTypeID"))
		order.MatchingTypeID = atoi(r.FormValue("matchingTypeID"))
		order.ContractTypeID = atoi(r.FormValue("contractTypeID"))
		order.ProductID = atoi(r.FormValue("productID"))
		order.QualityID = atoi(r.FormValue("quality_id"))
		order.Price = atof(r.FormValue("price"))
		order.Currencies = atoi(r.FormValue("currency_id"))
		order.Quantity = atof(r.FormValue("quantity"))
		order.UOMID = atoi(r.FormValue("uom_id"))
		order.PackingID = atoi(r.FormValue("packing_id"))
		order.PaymentTermID = atoi(r.FormValue("payment_term_id"))
		order.DeliveryTermID = atoi(r.FormValue("delivery_term_id"))
		order.CountryIDs = atoi(r.FormValue("country_id"))
		order.PortofloadingID = atoi(r.FormValue("port_of_loading_id"))
		order.PortofdischargeID = atoi(r.FormValue("port_of_discharge_id"))
		order.ProvinceID = atoi(r.FormValue("province_id"))
		order.DistrictID = atoi(r.FormValue("district_id"))
		order.SubdistrictID = atoi(r.FormValue("subdistrict_id"))
		order.FirstDeliveryDate, _ = time.Parse("2006-01-02", r.FormValue("first_delivery_date"))
		order.LastDeliveryDate, _ = time.Parse("2006-01-02", r.FormValue("last_delivery_date"))
		order.Remark = r.FormValue("remark")
		order.StatusID = 13 // Default status
	}

	price := r.FormValue("price")
	quantity := r.FormValue("quantity")

	if price == "" || quantity == "" {
		log.Println("Price or Quantity is missing")
		http.Error(w, "Price and Quantity are required fields", http.StatusBadRequest)
		return
	}

	// Insert data into database
	queryOrders := `
		INSERT INTO orders (
       	 	user_id, marketspace_id, market_id, submarket_id, order_type_id, matching_type_id, contract_type_id,
        	product_id, quality_id, price, currency_id, quantity, uom_id, packing_id, payment_term_id, delivery_term_id,
        	country_id,port_of_loading_id,port_of_discharge_id,province_id, district_id, subdistrict_id, first_delivery_date, last_delivery_date,
			remark, status_id
    ) VALUES (
        $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25 ,$26
    )RETURNING matching_type_id`

	var matchingTypeID int
	row := db.QueryRow(queryOrders, order.UserID, order.MarketspaceID, order.MarketID, order.SubmarketID, order.OrderTypeID,
		order.MatchingTypeID, order.ContractTypeID, order.ProductID, order.QualityID, order.Price, order.Currencies, order.Quantity,
		order.UOMID, order.PackingID, order.PaymentTermID, order.DeliveryTermID, order.CountryIDs, order.PortofloadingID, order.PortofdischargeID,
		order.ProvinceID, order.DistrictID, order.SubdistrictID, order.FirstDeliveryDate, order.LastDeliveryDate, order.Remark, order.StatusID)

	err = row.Scan(&matchingTypeID)

	if err != nil {
		log.Printf("Error inserting order: %v", err)
		http.Error(w, "Unable to create order", http.StatusInternalServerError)
		return
	}

	// Insert data into "matchings" table
	queryMatchings := `
    	INSERT INTO matchings (
       	 	user_id, marketspace_id, market_id, submarket_id, order_type_id, matching_type_id, contract_type_id,
        	product_id, quality_id, price, currency_id, quantity, uom_id, packing_id, payment_term_id, delivery_term_id,country_id,
        	port_of_loading_id,port_of_discharge_id,province_id, district_id, subdistrict_id, first_delivery_date, last_delivery_date,
			remark, status_id
    ) VALUES (
        $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23, $24, $25 ,$26
    )`

	_, err = db.Exec(queryMatchings, order.UserID, order.MarketspaceID, order.MarketID, order.SubmarketID, order.OrderTypeID,
		order.MatchingTypeID, order.ContractTypeID, order.ProductID, order.QualityID, order.Price, order.Currencies, order.Quantity,
		order.UOMID, order.PackingID, order.PaymentTermID, order.DeliveryTermID, order.CountryIDs, order.PortofloadingID, order.PortofdischargeID,
		order.ProvinceID, order.DistrictID, order.SubdistrictID, order.FirstDeliveryDate, order.LastDeliveryDate, order.Remark, order.StatusID)

	if err != nil {
		log.Printf("Error inserting into matchings: %v", err)
		http.Error(w, "Unable to create matching", http.StatusInternalServerError)
		return
	}
	if matchingTypeID == 7 {
		err = matching.MatchOrders(db)
		if err != nil {
			log.Printf("Error matching orders: %v", err)
			http.Error(w, "Error processing matching orders", http.StatusInternalServerError)
			return
		}
	}
	http.Redirect(w, r, "/dashboard", http.StatusSeeOther)
}

// Helper functions for converting strings to int/float
func atoi(str string) int {
	val, _ := strconv.Atoi(str)
	return val
}

func atof(str string) float64 {
	val, _ := strconv.ParseFloat(str, 64)
	return val
}

///////////////////////////////////////////////////////////////
