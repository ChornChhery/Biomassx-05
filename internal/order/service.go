package order

import (
	"html/template"
	"log"
	"net/http"
	"strconv"

	"github.com/thongsoi/biomassx-05/database"
)

//this service is for cascade form

func SubmarketHandler(w http.ResponseWriter, r *http.Request) {
	db := database.GetDB()
	marketIDStr := r.URL.Query().Get("marketID")
	lang := r.URL.Query().Get("lang") // เพิ่มพารามิเตอร์ lang เพื่อระบุภาษา

	marketID, err := strconv.Atoi(marketIDStr)
	if err != nil {
		http.Error(w, "Invalid market ID", http.StatusBadRequest)
		return
	}

	submarkets, err := FetchSubmarketsByMarketID(db, marketID)
	if err != nil {
		log.Printf("Error fetching submarkets: %v", err)
		http.Error(w, "Unable to fetch submarkets", http.StatusInternalServerError)
		return
	}

	var templateStr string
	// ตรวจสอบค่า lang ที่ส่งมา ถ้าเป็น "th" ให้ใช้ ThName ถ้าไม่ใช่ให้ใช้ EnName
	if lang == "th" {
		templateStr = `{{range .}}<option value="{{.ID}}">{{.ThName}}</option>{{end}}`
	} else {
		templateStr = `{{range .}}<option value="{{.ID}}">{{.EnName}}</option>{{end}}`
	}

	tmpl, err := template.New("submarkets").Parse(templateStr)
	if err != nil {
		log.Printf("Error creating template: %v", err)
		http.Error(w, "Template error", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "text/html")
	err = tmpl.Execute(w, submarkets)
	if err != nil {
		log.Printf("Error executing template: %v", err)
		http.Error(w, "Template execution error", http.StatusInternalServerError)
	}
}

func ProductHandler(w http.ResponseWriter, r *http.Request) {
	db := database.GetDB()
	submarketIDStr := r.URL.Query().Get("submarketID")
	lang := r.URL.Query().Get("lang") // รับค่าภาษา

	submarketID, err := strconv.Atoi(submarketIDStr)
	if err != nil {
		http.Error(w, "Invalid submarket ID", http.StatusBadRequest)
		return
	}

	products, err := FetchProductsBySubmarketID(db, submarketID)
	if err != nil {
		log.Printf("Error fetching products: %v", err)
		http.Error(w, "Unable to fetch products", http.StatusInternalServerError)
		return
	}

	var templateStr string
	// ตรวจสอบค่า lang ถ้าเป็น "th" ใช้ ThName ถ้าไม่ใช่ใช้ EnName
	if lang == "th" {
		templateStr = `{{range .}}<option value="{{.ID}}">{{.ThName}}</option>{{end}}`
	} else {
		templateStr = `{{range .}}<option value="{{.ID}}">{{.EnName}}</option>{{end}}`
	}

	tmpl, err := template.New("products").Parse(templateStr)
	if err != nil {
		log.Printf("Error creating template: %v", err)
		http.Error(w, "Template error", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "text/html")
	err = tmpl.Execute(w, products)
	if err != nil {
		log.Printf("Error executing template: %v", err)
		http.Error(w, "Template execution error", http.StatusInternalServerError)
	}
}

func QualityHandler(w http.ResponseWriter, r *http.Request) {
	db := database.GetDB()

	// ดึง productID จาก query string
	productIDStr := r.URL.Query().Get("productID")
	if productIDStr == "" {
		http.Error(w, "Missing product ID", http.StatusBadRequest)
		return
	}

	// แปลง productID เป็น integer
	productID, err := strconv.Atoi(productIDStr)
	if err != nil {
		log.Printf("Invalid product ID: %v", err)
		http.Error(w, "Invalid product ID", http.StatusBadRequest)
		return
	}

	// ดึงข้อมูล qualities จาก database
	qualities, err := FetchQualitiesByProductID(db, productID)
	if err != nil {
		log.Printf("Error fetching qualities for product ID %d: %v", productID, err)
		http.Error(w, "Unable to fetch qualities", http.StatusInternalServerError)
		return
	}

	// สร้าง template สำหรับ options
	tmpl := `{{range .}}<option value="{{.ID}}">Standard: {{.StandardID}}  -  Grade: {{.GradeID}}</option>{{else}}<option value="">No qualities available</option>{{end}}`
	t, err := template.New("qualities").Parse(tmpl)
	if err != nil {
		log.Printf("Error creating template: %v", err)
		http.Error(w, "Template error", http.StatusInternalServerError)
		return
	}

	// กำหนด Content-Type และแสดงผล
	w.Header().Set("Content-Type", "text/html")
	if err := t.Execute(w, qualities); err != nil {
		log.Printf("Error executing template: %v", err)
		http.Error(w, "Template execution error", http.StatusInternalServerError)
	}
}

func DistrictHandler(w http.ResponseWriter, r *http.Request) {
	db := database.GetDB()
	provinceIDStr := r.URL.Query().Get("province_id")
	lang := r.URL.Query().Get("lang") // รับค่าภาษา

	provinceID, err := strconv.Atoi(provinceIDStr)
	if err != nil {
		http.Error(w, "Invalid province ID", http.StatusBadRequest)
		return
	}

	districts, err := FetchDistrictByProvinceID(db, provinceID)
	if err != nil {
		log.Printf("Error fetching districts: %v", err)
		http.Error(w, "Unable to fetch districts", http.StatusInternalServerError)
		return
	}

	var templateStr string
	if lang == "th" {
		templateStr = `{{range .}}<option value="{{.ID}}">{{.ThName}}</option>{{end}}`
	} else {
		templateStr = `{{range .}}<option value="{{.ID}}">{{.EnName}}</option>{{end}}`
	}

	tmpl, err := template.New("districts").Parse(templateStr)
	if err != nil {
		log.Printf("Error creating template: %v", err)
		http.Error(w, "Template error", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "text/html")
	err = tmpl.Execute(w, districts)
	if err != nil {
		log.Printf("Error executing template: %v", err)
		http.Error(w, "Template execution error", http.StatusInternalServerError)
	}
}
func SubdistrictHandler(w http.ResponseWriter, r *http.Request) {
	db := database.GetDB()
	districtIDStr := r.URL.Query().Get("district_id") // ใช้ district_id แทน province_id
	lang := r.URL.Query().Get("lang")                 // รับค่าภาษา

	districtID, err := strconv.Atoi(districtIDStr)
	if err != nil {
		http.Error(w, "Invalid district ID", http.StatusBadRequest)
		return
	}

	subdistricts, err := FetchSubdistrictByProvinceID(db, districtID) // ส่ง district_id เข้าไป
	if err != nil {
		log.Printf("Error fetching subdistricts: %v", err)
		http.Error(w, "Unable to fetch subdistricts", http.StatusInternalServerError)
		return
	}

	var templateStr string
	if lang == "th" {
		templateStr = `{{range .}}<option value="{{.ID}}">{{.ThName}}</option>{{end}}`
	} else {
		templateStr = `{{range .}}<option value="{{.ID}}">{{.EnName}}</option>{{end}}`
	}

	tmpl, err := template.New("subdistricts").Parse(templateStr)
	if err != nil {
		log.Printf("Error creating template: %v", err)
		http.Error(w, "Template error", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "text/html")
	err = tmpl.Execute(w, subdistricts)
	if err != nil {
		log.Printf("Error executing template: %v", err)
		http.Error(w, "Template execution error", http.StatusInternalServerError)
	}
}

func PaymentTermHandler(w http.ResponseWriter, r *http.Request) {
	db := database.GetDB()
	marketspaceIDStr := r.URL.Query().Get("marketspaceID")
	lang := r.URL.Query().Get("lang") // รับค่าภาษา

	marketspaceID, err := strconv.Atoi(marketspaceIDStr)
	if err != nil {
		http.Error(w, "Invalid marketspaceID", http.StatusBadRequest)
		return
	}

	payments, err := FetchPaymentbyMarketspaceID(db, marketspaceID)
	if err != nil {
		log.Printf("Error fetching Payment: %v", err)
		http.Error(w, "Unable to fetch Payment", http.StatusInternalServerError)
		return
	}

	var templateStr string
	// ตรวจสอบค่า lang ถ้าเป็น "th" ใช้ ThName ถ้าไม่ใช่ใช้ EnName
	if lang == "th" {
		templateStr = `{{range .}}<option value="{{.ID}}">{{.ThName}}</option>{{end}}`
	} else {
		templateStr = `{{range .}}<option value="{{.ID}}">{{.EnName}}</option>{{end}}`
	}

	tmpl, err := template.New("payments").Parse(templateStr)
	if err != nil {
		log.Printf("Error creating template: %v", err)
		http.Error(w, "Template error", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "text/html")
	err = tmpl.Execute(w, payments)
	if err != nil {
		log.Printf("Error executing template: %v", err)
		http.Error(w, "Template execution error", http.StatusInternalServerError)
	}
}

func DeliveryHandler(w http.ResponseWriter, r *http.Request) {
	db := database.GetDB()
	marketspaceIDStr := r.URL.Query().Get("marketspaceID")
	lang := r.URL.Query().Get("lang") // รับค่าภาษา

	marketspaceID, err := strconv.Atoi(marketspaceIDStr)
	if err != nil {
		http.Error(w, "Invalid marketspaceID", http.StatusBadRequest)
		return
	}

	deliverys, err := FetchDeliveryByMarketspaceID(db, marketspaceID)
	if err != nil {
		log.Printf("Error fetching Delivery: %v", err)
		http.Error(w, "Unable to fetch Delivery", http.StatusInternalServerError)
		return
	}

	var templateStr string
	// ตรวจสอบค่า lang ถ้าเป็น "th" ใช้ ThName ถ้าไม่ใช่ใช้ EnName
	if lang == "th" {
		templateStr = `{{range .}}<option value="{{.ID}}">{{.ThName}}</option>{{end}}`
	} else {
		templateStr = `{{range .}}<option value="{{.ID}}">{{.EnName}}</option>{{end}}`
	}

	tmpl, err := template.New("deliverys").Parse(templateStr)
	if err != nil {
		log.Printf("Error creating template: %v", err)
		http.Error(w, "Template error", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "text/html")
	err = tmpl.Execute(w, deliverys)
	if err != nil {
		log.Printf("Error executing template: %v", err)
		http.Error(w, "Template execution error", http.StatusInternalServerError)
	}
}
