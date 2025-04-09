package contract

import (
	"database/sql"
	"fmt"
	"log"
	"net/http"
	"sort"
	"strconv"
	"text/template"
	"time"

	"github.com/go-pdf/fpdf"
	"github.com/golang-jwt/jwt"
	"github.com/gorilla/mux"
	"github.com/thongsoi/biomassx-05/database"
)

var jwtKey = []byte("your_secret_key")

func ContractHandler(w http.ResponseWriter, r *http.Request) {
	log.Printf("[ContractHandler] Handling request: Method=%s, Path=%s", r.Method, r.URL.Path)

	if r.Method != http.MethodGet {
		log.Printf("[ContractHandler] Unsupported HTTP Method: %s", r.Method)
		http.Error(w, "Method Not Allowed", http.StatusMethodNotAllowed)
		return
	}

	db := database.GetDB()
	log.Println("[ContractHandler] Received GET request for contract page")

	userID, err := getUserIDFromToken(r)
	if err != nil {
		log.Printf("[ContractHandler] Unauthorized: Failed to extract user_id from token: %v", err)
		http.Error(w, "Unauthorized", http.StatusUnauthorized)
		return
	}
	log.Printf("[ContractHandler] Successfully extracted user_id: %d", userID)

	contractData, err := FetchContractData(db)
	if err != nil {
		log.Printf("[ContractHandler] Error fetching contract data: %v", err)
		http.Error(w, "Error fetching contract data", http.StatusInternalServerError)
		return
	}
	log.Printf("[ContractHandler] Successfully fetched %d contracts", len(contractData))

	// ประกาศตัวแปรให้ถูกต้อง
	var sellContracts []Contract
	var buyContracts []Contract

	log.Println("[ContractHandler] Starting contract filtering process")
	for _, contract := range contractData {
		var sellerID, buyerID int64
		if contract.SellerUserID.Valid {
			sellerID, _ = strconv.ParseInt(contract.SellerUserID.String, 10, 64)
		}
		if contract.BuyerUserID.Valid {
			buyerID, _ = strconv.ParseInt(contract.BuyerUserID.String, 10, 64)
		}

		log.Printf("[ContractHandler] Processing contract ID=%d: SellerUserID=%d, BuyerUserID=%d", contract.ID, sellerID, buyerID)

		if sellerID == int64(userID) {
			log.Printf("[ContractHandler] Adding contract ID=%d to sellContracts", contract.ID)
			sellContracts = append(sellContracts, contract)
		}
		if buyerID == int64(userID) {
			log.Printf("[ContractHandler] Adding contract ID=%d to buyContracts", contract.ID)
			buyContracts = append(buyContracts, contract)
		}
	}
	log.Printf("[ContractHandler] Filtering complete: Found %d sell contracts and %d buy contracts", len(sellContracts), len(buyContracts))

	// เรียงลำดับ contracts ตาม ID
	log.Println("[ContractHandler] Sorting contracts by ID")
	sort.Slice(sellContracts, func(i, j int) bool {
		log.Printf("[ContractHandler] Comparing sell contracts: %d < %d = %v",
			sellContracts[i].ID, sellContracts[j].ID, sellContracts[i].ID < sellContracts[j].ID)
		return sellContracts[i].ID < sellContracts[j].ID
	})

	sort.Slice(buyContracts, func(i, j int) bool {
		log.Printf("[ContractHandler] Comparing buy contracts: %d < %d = %v",
			buyContracts[i].ID, buyContracts[j].ID, buyContracts[i].ID < buyContracts[j].ID)
		return buyContracts[i].ID < buyContracts[j].ID
	})

	log.Println("[ContractHandler] Sorting complete")

	// แสดงผลลำดับ ID หลังการเรียง
	log.Println("[ContractHandler] Sell contracts after sorting:")
	for i, contract := range sellContracts {
		log.Printf("[ContractHandler] - Sell contract #%d: ID=%d", i+1, contract.ID)
	}

	log.Println("[ContractHandler] Buy contracts after sorting:")
	for i, contract := range buyContracts {
		log.Printf("[ContractHandler] - Buy contract #%d: ID=%d", i+1, contract.ID)
	}

	language := r.URL.Query().Get("lang")
	if language == "" {
		language = getLanguageFromToken(r)
	}
	if language == "" {
		language = "en"
	}
	log.Printf("[ContractHandler] Using language: %s", language)

	var contentFile string
	switch language {
	case "th":
		contentFile = "views/pages/th/contract_th.html"
	case "en":
		contentFile = "views/pages/en/contract_en.html"
	default:
		http.Error(w, "Invalid language", http.StatusBadRequest)
		return
	}
	log.Printf("[ContractHandler] Selected content file: %s", contentFile)

	// โหลดเทมเพลตทั้งหมด
	log.Println("[ContractHandler] Loading templates")
	tmpl := template.New("")
	tmpl, err = tmpl.ParseFiles("views/pages/contract.html", contentFile)
	if err != nil {
		log.Println("[ContractHandler] Error parsing template:", err)
		http.Error(w, "Template not found", http.StatusInternalServerError)
		return
	}
	log.Println("[ContractHandler] Templates loaded successfully")

	data := struct {
		SellContracts []Contract
		BuyContracts  []Contract
		Lang          string // เปลี่ยนเป็นตัวพิมพ์ใหญ่ - สามารถเข้าถึงได้จากเทมเพลต
	}{
		SellContracts: sellContracts,
		BuyContracts:  buyContracts,
		Lang:          language,
	}

	// แสดงข้อมูลที่จะส่งไปเทมเพลตเพื่อการตรวจสอบ
	log.Printf("[ContractHandler] Rendering with lang=%s, SellContracts=%d, BuyContracts=%d",
		language, len(sellContracts), len(buyContracts))

	err = tmpl.ExecuteTemplate(w, "base", data)
	if err != nil {
		log.Printf("[ContractHandler] Error executing template: %v", err)
		http.Error(w, "Error rendering page", http.StatusInternalServerError)
		return
	}

	log.Println("[ContractHandler] Successfully rendered contract page")
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

func ContractDetailHandler(w http.ResponseWriter, r *http.Request) {
	log.Println("[ContractDetailHandler] Handling contract detail request")

	vars := mux.Vars(r)
	contractID := vars["id"]
	if contractID == "" {
		http.Error(w, "Contract ID is required", http.StatusBadRequest)
		return
	}
	log.Printf("[ContractDetailHandler] Fetching contract with ID: %s", contractID)

	db := database.GetDB()
	contract, err := FetchContractUserDetails(db, contractID)
	if err != nil {
		log.Printf("[ContractDetailHandler] Error fetching contract: %v", err)
		http.Error(w, "Error fetching contract", http.StatusInternalServerError)
		return
	}

	// ดึง userID จากโทเค็น
	userID, err := getUserIDFromToken(r)
	if err != nil {
		log.Println("[ContractDetailHandler] Error retrieving user ID from token:", err)
		http.Error(w, "Unauthorized", http.StatusUnauthorized)
		return
	}

	// ตรวจสอบสิทธิ์เข้าถึง
	if (contract.SellerUserID.Valid && contract.SellerUserID.Int64 == int64(userID)) ||
		(contract.BuyerUserID.Valid && contract.BuyerUserID.Int64 == int64(userID)) {
		log.Println("[ContractDetailHandler] User authorized to view contract")
	} else {
		http.Error(w, "This page is unavailable.", http.StatusForbidden)
		return
	}

	// อ่านค่าภาษา
	language := r.URL.Query().Get("lang")
	if language == "" {
		language = getLanguageFromToken(r)
	}
	if language == "" {
		language = "en"
	}

	// เลือกไฟล์เทมเพลตตามภาษา
	var contentFile string
	switch language {
	case "th":
		contentFile = "views/pages/th/contract_detail_th.html"
	case "en":
		contentFile = "views/pages/en/contract_detail_en.html"
	default:
		http.Error(w, "Invalid language", http.StatusBadRequest)
		return
	}

	// เตรียมข้อมูลสำหรับเทมเพลต
	data := struct {
		Contract ContractUserDetails
		UserID   int
		Lang     string
	}{
		Contract: contract,
		UserID:   userID,
		Lang:     language,
	}

	// โหลดและ render เทมเพลต
	tmpl, err := template.New("base").ParseFiles("views/pages/contract.html", contentFile)
	if err != nil {
		log.Printf("[ContractDetailHandler] Error loading template: %v", err)
		http.Error(w, "Error loading template", http.StatusInternalServerError)
		return
	}

	err = tmpl.ExecuteTemplate(w, "base", data)
	if err != nil {
		log.Printf("[ContractDetailHandler] Error rendering template: %v", err)
		http.Error(w, "Error rendering template", http.StatusInternalServerError)
		return
	}

	log.Println("[ContractDetailHandler] Successfully rendered contract detail page")
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

func DownloadContractPDFHandlerEn(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	contractID := vars["id"]

	if contractID == "" {
		log.Println("Error: Contract ID is missing")
		http.Error(w, "Contract ID is required", http.StatusBadRequest)
		return
	}

	log.Printf("Fetching contract details for ID: %s", contractID)
	db := database.GetDB()
	contract, err := FetchContractUserDetails(db, contractID)
	if err != nil {
		log.Printf("Error fetching contract: %v", err)
		http.Error(w, "Error fetching contract", http.StatusInternalServerError)
		return
	}

	log.Printf("Fetching buyer details for user ID: %v", contract.BuyerUserID)
	buyerInfo, buyerAddress, err := FetchUserAndLocationDetails(db, contract.BuyerUserID)
	if err != nil {
		log.Printf("Error fetching buyer details: %v", err)
		http.Error(w, "Error fetching buyer details", http.StatusInternalServerError)
		return
	}

	log.Printf("Fetching seller details for user ID: %v", contract.SellerUserID)
	sellerInfo, sellerAddress, err := FetchUserAndLocationDetails(db, contract.SellerUserID)
	if err != nil {
		log.Printf("Error fetching seller details: %v", err)
		http.Error(w, "Error fetching seller details", http.StatusInternalServerError)
		return
	}

	log.Println("Generating PDF document")
	pdf := GenerateContractPDFEn(contract, buyerInfo, sellerInfo, buyerAddress, sellerAddress)

	w.Header().Set("Content-Type", "application/pdf")
	w.Header().Set("Content-Disposition", "attachment; filename=contract_"+contractID+".pdf")

	if err := pdf.Output(w); err != nil {
		log.Printf("Error generating PDF: %v", err)
		http.Error(w, "Error generating PDF", http.StatusInternalServerError)
	}

	log.Println("PDF generated and sent successfully")
}

func DownloadContractPDFHandlerTh(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	contractID := vars["id"]

	if contractID == "" {
		log.Println("Error: Contract ID is missing")
		http.Error(w, "Contract ID is required", http.StatusBadRequest)
		return
	}

	log.Printf("Fetching contract details for ID: %s", contractID)
	db := database.GetDB()
	contract, err := FetchContractUserDetails(db, contractID)
	if err != nil {
		log.Printf("Error fetching contract: %v", err)
		http.Error(w, "Error fetching contract", http.StatusInternalServerError)
		return
	}

	log.Printf("Fetching buyer details for user ID: %v", contract.BuyerUserID)
	buyerInfo, buyerAddress, err := FetchUserAndLocationDetails(db, contract.BuyerUserID)
	if err != nil {
		log.Printf("Error fetching buyer details: %v", err)
		http.Error(w, "Error fetching buyer details", http.StatusInternalServerError)
		return
	}

	log.Printf("Fetching seller details for user ID: %v", contract.SellerUserID)
	sellerInfo, sellerAddress, err := FetchUserAndLocationDetails(db, contract.SellerUserID)
	if err != nil {
		log.Printf("Error fetching seller details: %v", err)
		http.Error(w, "Error fetching seller details", http.StatusInternalServerError)
		return
	}

	log.Println("Generating PDF document")
	pdf := GenerateContractPDFTh(contract, buyerInfo, sellerInfo, buyerAddress, sellerAddress)

	w.Header().Set("Content-Type", "application/pdf")
	w.Header().Set("Content-Disposition", "attachment; filename=contract_"+contractID+".pdf")

	if err := pdf.Output(w); err != nil {
		log.Printf("Error generating PDF: %v", err)
		http.Error(w, "Error generating PDF", http.StatusInternalServerError)
	}

	log.Println("PDF generated and sent successfully")
}

func GenerateContractPDFEn(contract ContractUserDetails, buyer User, seller User, buyerAddress Address, sellerAddress Address) *fpdf.Fpdf {
	pdf := fpdf.New("P", "mm", "A4", "")
	pdf.SetMargins(10, 10, 10)
	pdf.AddPage()

	// เพิ่ม Page Number หน้าที่ 1
	pdf.SetY(5)   // ตำแหน่ง Y ที่มุมล่างของหน้า
	pdf.SetX(180) // ตำแหน่ง X ที่มุมขวา
	pdf.SetFont("Arial", "", 10)
	pdf.Cell(20, 10, "Page 1/2")

	// วาดโลโก้ตรงกลาง - ปรับตำแหน่ง Y ให้สูงขึ้นเล็กน้อย
	pdf.ImageOptions(
		"./static/images/biomassx.png",
		85, // X (กึ่งกลางหน้า A4 กว้าง 210mm)
		3,  // Y ปรับให้สูงขึ้น
		40, // ความกว้าง
		0,  // ปรับขนาดอัตโนมัติ
		false,
		fpdf.ImageOptions{ImageType: "PNG", ReadDpi: true},
		0,
		"",
	)

	// กำหนดขอบเขตของตาราง - ขยับให้สูงขึ้น
	tableStartY := 45 // ปรับให้เริ่มสูงขึ้นอีกเล็กน้อย จาก 55 เป็น 50
	tableWidth := 190
	tableHeight := 230 // เพิ่มความสูงของตารางเล็กน้อย
	colWidth := tableWidth / 2

	// ปรับความสูงของแต่ละแถว (ลดลงเล็กน้อย เพื่อให้พอดีกับหน้ากระดาษ)
	rowHeight := tableHeight / 17 // ปรับจาก 20 เป็น 21 เพื่อให้แถวแคบลงเล็กน้อย

	// วาดกรอบใหญ่
	pdf.SetY(float64(tableStartY))
	pdf.SetLineWidth(0.5)
	pdf.Rect(10, float64(tableStartY), float64(tableWidth), float64(tableHeight), "D")

	// วาดเส้นแบ่งคอลัมน์ตรงกลาง
	pdf.Line(10+float64(colWidth), float64(tableStartY), 10+float64(colWidth), float64(tableStartY+tableHeight))

	// วาดเส้นแบ่งแถวแนวนอน (18 เส้น สำหรับ 19 แถว)
	for i := 1; i < 17; i++ {
		// ข้ามการวาดเส้นแบ่งสำหรับแถวที่ 4 (index i=3) ที่ต้องขยายความสูง
		if i == 4 {
			continue
		}
		yPos := tableStartY + (i * rowHeight)
		pdf.Line(10, float64(yPos), 10+float64(tableWidth), float64(yPos))
	}

	// ลดขนาดฟอนต์ทั้งหมดเล็กน้อย เพื่อให้พอดีกับหน้ากระดาษ
	pdf.SetFont("Arial", "", 12) // ลดจาก 10 เป็น 9

	// แถวที่ 1: Contract number
	currentY := float64(tableStartY + 2)
	pdf.SetXY(12, currentY)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("Contract number: %d", contract.ID))
	pdf.SetXY(12+float64(colWidth), currentY)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), "Exchange platform: BiomassX.com")

	// แถวที่ 2: Contract type
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("Contract type: %s", contract.ContractTypeEnName.String))
	pdf.SetXY(12+float64(colWidth), currentY)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("Market: %s/%s/%s", contract.MarketspaceEnName.String, contract.MarketEnName.String, contract.SubmarketEnName.String))

	// แถวที่ 3: Contract date
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), "Contract date:")
	pdf.SetXY(12+float64(colWidth), currentY)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), contract.ContractDate.Format("02 Jan 2006"))

	// แถวที่ 4: Seller และ Buyer address - ปรับลดความสูงลงเล็กน้อย
	currentY += float64(rowHeight)
	specialRowHeight := int(float64(rowHeight)*2.8) - 3

	// ข้อมูล Seller ทางซ้าย - ปรับลดขนาดฟอนต์
	pdf.SetFont("Arial", "", 12) // ลดขนาดฟอนต์ในส่วนที่อาจมีข้อความยาว

	pdf.SetXY(12, currentY)

	// ตรวจสอบ SellerOrgName ว่าเป็น NULL หรือไม่
	var sellerNameDisplay string
	if contract.SellerOrgName.Valid && contract.SellerOrgName.String != "" {
		sellerNameDisplay = contract.SellerOrgName.String
	} else {
		sellerNameDisplay = fmt.Sprintf("%s %s", contract.SellerFirstName.String, contract.SellerLastName.String)
	}

	pdf.MultiCell(float64(colWidth-4), float64(specialRowHeight)/7, fmt.Sprintf("Seller:  %s\n%s %s\n%s %s %s %s\nT: %s E: %s \ncontact person: %s %s",
		sellerNameDisplay,
		sellerAddress.Address.String, sellerAddress.Street.String,
		sellerAddress.SubdistrictEN.String, sellerAddress.DistrictEN.String,
		sellerAddress.ProvinceEN.String, sellerAddress.PostalCode.String,
		seller.Phone.String, seller.Email.String,
		contract.SellerFirstName.String, contract.SellerLastName.String), "", "L", false)

	// ข้อมูล Buyer ทางขวา
	pdf.SetXY(12+float64(colWidth), currentY)

	// ตรวจสอบ BuyerOrgName ว่าเป็น NULL หรือไม่
	var buyerNameDisplay string
	if contract.BuyerOrgName.Valid && contract.BuyerOrgName.String != "" {
		buyerNameDisplay = contract.BuyerOrgName.String
	} else {
		buyerNameDisplay = fmt.Sprintf("%s %s", contract.BuyerFirstName.String, contract.BuyerLastName.String)
	}

	pdf.MultiCell(float64(colWidth-4), float64(specialRowHeight)/7, fmt.Sprintf("Buyer:  %s\n%s %s\n%s %s %s %s\nT: %s E: %s \ncontact person: %s %s",
		buyerNameDisplay,
		buyerAddress.Address.String, buyerAddress.Street.String,
		buyerAddress.SubdistrictEN.String, buyerAddress.DistrictEN.String,
		buyerAddress.ProvinceEN.String, buyerAddress.PostalCode.String,
		buyer.Phone.String, buyer.Email.String,
		contract.BuyerFirstName.String, contract.BuyerLastName.String), "", "L", false)

	// เปลี่ยนกลับเป็นฟอนต์หัวข้อสำหรับแถวถัดไป
	pdf.SetFont("Arial", "", 12) // ใช้ฟอนต์ขนาด 9 แทนขนาด 10

	// ปรับ currentY ให้เลื่อนลงตามความสูงพิเศษของแถวที่ 4
	// ปรับ currentY ให้เลื่อนลงตามความสูงพิเศษของแถวที่ 4
	currentY += float64(specialRowHeight - rowHeight) // เพิ่มแค่ส่วนต่างเพราะเราบวก rowHeight ไปแล้วครั้งหนึ่ง

	// แถวที่ 5: Product

	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), "Product")
	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("%s", contract.ProductEnName.String))

	// แถวที่ 6: Quality Standard
	currentY += float64(rowHeight) // เพิ่ม rowHeight สำหรับแถวถัดไป
	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), "Quality specification:")
	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("%s, Grade: %s", contract.StandardEnName.String, contract.GradeEnName.String))
	// แถวที่ 7: Quality Standard
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), "Unit price:")
	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("%v %s per %s", contract.Price, contract.CurrencyEnName.String, contract.UomDescription.String))

	// แถวที่ 8: Unit price
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), "Volume:")
	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("%v %s", contract.Quantity, contract.UomDescription.String))

	// แถวที่ 9: Contract value
	contractValue := int(contract.Quantity * contract.Price)
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("Contract value: "))
	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("%v %s", contractValue, contract.CurrencyEnName.String))

	// แถวที่ 10: Payment term
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("Packing condition: "))
	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("%s", contract.PackingEn.String))

	// แถวที่ 11: Location
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("Payment term: "))
	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("%s", contract.PaymentTermEn.String))

	// แถวที่ 12: Location
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("Delivery term: "))
	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("%s", contract.DeliveryTermEn.String))

	// แถวที่ 13: Location
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("Seller country: %s", contract.SellerCountryEn.String))
	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("Buyer country: %s", contract.BuyerCountryEn.String))

	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY+3)

	if contract.PodProvinceEn.Valid {
		// ถ้า PodProvinceEn ไม่เป็น NULL ให้แสดงข้อมูลเดิม
		pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("Place of delivery: "))
		pdf.SetXY(12+float64(colWidth), currentY+3)
		pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("Province/State: %s", contract.PodProvinceEn.String))

		// แถวที่ 15: แสดง District/city และ Subdistrict/town
		currentY += float64(rowHeight)
		pdf.SetXY(12, currentY+3)
		pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("District/City: %s", contract.PodDistrictEn.String))
		pdf.SetXY(12+float64(colWidth), currentY+3)
		pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("Subdistrict/Town: %s", contract.PodSubdistrictEn.String))
	} else {
		// ถ้า PodProvinceEn เป็น NULL
		// แถว 14: แสดง Port of loading และ SellerPolEn
		pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("Port of loading: "))
		pdf.SetXY(12+float64(colWidth), currentY+3)
		pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("%s", contract.SellerPolEn.String))

		// แถว 15: แสดง Port of discharge และ BuyerPodEn
		currentY += float64(rowHeight)
		pdf.SetXY(12, currentY+3)
		pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("Port of discharge: "))
		pdf.SetXY(12+float64(colWidth), currentY+3)
		pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("%s", contract.BuyerPodEn.String))
	}
	// แถวที่ 16: First delivery date
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight),
		fmt.Sprintf("Start delivery date: %s", formatNullTime(contract.StartDelivery, "02 Jan 2006")))

	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight),
		fmt.Sprintf("Last delivery date: %s", formatNullTime(contract.FinishDelivery, "02 Jan 2006")))

	// หน้าที่ 2
	pdf.AddPage()
	pdf.Ln(10)
	pdf.SetFont("Arial", "", 14)

	hasRemarks := false

	// ตรวจสอบว่ามี Seller Remark หรือไม่
	if contract.SellerRemark.Valid && contract.SellerRemark.String != "" {
		hasRemarks = true
		pdf.Cell(0, 5, "The seller' s remark(s)")
		pdf.Ln(8)
		pdf.SetFont("Arial", "", 12)
		pdf.MultiCell(190, 6, contract.SellerRemark.String, "", "L", false)
		pdf.Ln(5)
	}

	// ตรวจสอบว่ามี Buyer Remark หรือไม่
	if contract.BuyerRemark.Valid && contract.BuyerRemark.String != "" {
		hasRemarks = true
		pdf.SetFont("Arial", "", 14)
		pdf.Cell(0, 5, "The buyer' s remark(s)")
		pdf.Ln(8)
		pdf.SetFont("Arial", "", 12)
		pdf.MultiCell(190, 6, contract.BuyerRemark.String, "", "L", false)
		pdf.Ln(5)
	}

	// ถ้ามี remarks เพิ่ม space เพิ่มเติมหลังจากแสดง remarks
	if hasRemarks {
		pdf.Ln(5)
	}

	pdf.Cell(0, 5, "General terms and conditions")
	pdf.Ln(5)
	pdf.SetFont("Arial", "", 12)

	pdf.MultiCell(190, 6, fmt.Sprintf(
		"1) The parties hereby acknowledge themselves to be familiar with and to be bound by the defaults terms and conditions if applicable as stipulated in contract number %d and generally by the BiomassX.com/terms_conditions.html.",
		contract.ID), "", "L", false)
	pdf.Ln(3)
	pdf.MultiCell(190, 6, "2) Neither party shall cede of assign any rights or obligations in terms hereof without the written authority of the other party.", "", "L", false)
	pdf.Ln(3)
	pdf.MultiCell(190, 6, "3) Any broker not possessing actual authority in terms hereof shall be deemed to have contracted on his own behalf.", "", "L", false)
	pdf.Ln(3)
	pdf.MultiCell(190, 6, "4) BiomassX will charge both the seller and the buyer a bioenergy exchange trading commission of 0.50% of each contract value excluding VAT.", "", "L", false)
	pdf.Ln(3)
	pdf.MultiCell(190, 6, "5) In the event of a dispute arising under this contract agreement, whether as to the interpretation or the extent of any purported breach, such dispute shall be submitted to arbitration for determination in terms of regulation of the BiomassX. Any determination consequent upon such arbitration shall be valid and binding upon all parties thereto.", "", "L", false)
	pdf.Ln(5)

	pdf.Ln(10)
	pdf.SetFont("Arial", "", 14)
	pdf.Cell(0, 5, "Thus done and signed")
	pdf.Ln(10)

	// กำหนดค่าชื่อ Seller และ Buyer ตามเงื่อนไข OrgName
	sellerName := contract.SellerOrgName.String
	if sellerName == "" {
		sellerName = fmt.Sprintf("%s %s", contract.SellerFirstName.String, contract.SellerLastName.String)
	}

	buyerName := contract.BuyerOrgName.String
	if buyerName == "" {
		buyerName = fmt.Sprintf("%s %s", contract.BuyerFirstName.String, contract.BuyerLastName.String)
	}

	// FOR THE SELLER / FOR THE BUYER
	pdf.SetFont("Arial", "", 11)
	pdf.CellFormat(95, 6, "For the seller:", "", 0, "L", false, 0, "")
	pdf.SetX(115) // จัดระยะให้ FOR THE BUYER ไม่ชิดขวาเกินไป
	pdf.CellFormat(95, 6, "For the buyer:", "", 0, "L", false, 0, "")
	pdf.Ln(6)

	// NAME
	pdf.SetFont("Arial", "", 11)
	pdf.CellFormat(95, 6, fmt.Sprintf("%s", sellerName), "", 0, "L", false, 0, "")
	pdf.SetX(115) // จัดระยะให้ NAME ของ Buyer อยู่ตรงกับ SIGNATURE
	pdf.CellFormat(95, 6, fmt.Sprintf("%s", buyerName), "", 0, "L", false, 0, "")
	pdf.Ln(6)

	// SIGNATURE
	pdf.CellFormat(95, 6, "Signature: ____________________", "", 0, "L", false, 0, "")
	pdf.SetX(115) // จัดระยะให้ SIGNATURE ของ Buyer อยู่ในแนวเดียวกับ NAME
	pdf.CellFormat(95, 6, "Signature: ____________________", "", 0, "L", false, 0, "")
	pdf.Ln(10)

	// เพิ่ม Page Number หน้าที่ 2
	pdf.SetY(5)   // ตำแหน่ง Y ที่มุมล่างของหน้า
	pdf.SetX(180) // ตำแหน่ง X ที่มุมขวา
	pdf.SetFont("Arial", "", 10)
	pdf.Cell(20, 10, "Page 2/2")

	return pdf
}

func GenerateContractPDFTh(contract ContractUserDetails, buyer User, seller User, buyerAddress Address, sellerAddress Address) *fpdf.Fpdf {
	pdf := fpdf.New("P", "mm", "A4", "")
	pdf.SetMargins(10, 10, 10)
	pdf.AddPage()
	pdf.AddUTF8Font("ANGSA", "", "./internal/contract/ANGSA.ttf")

	// วาดโลโก้ตรงกลาง - ปรับตำแหน่ง Y ให้สูงขึ้นเล็กน้อย
	pdf.ImageOptions(
		"./static/images/biomassx.png",
		85, // X (กึ่งกลางหน้า A4 กว้าง 210mm)
		3,  // Y ปรับให้สูงขึ้น
		40, // ความกว้าง
		0,  // ปรับขนาดอัตโนมัติ
		false,
		fpdf.ImageOptions{ImageType: "PNG", ReadDpi: true},
		0,
		"",
	)

	// กำหนดขอบเขตของตาราง - ขยับให้สูงขึ้น
	tableStartY := 45 // ปรับให้เริ่มสูงขึ้นอีกเล็กน้อย จาก 55 เป็น 50
	tableWidth := 190
	tableHeight := 230 // เพิ่มความสูงของตารางเล็กน้อย
	colWidth := tableWidth / 2

	// ปรับความสูงของแต่ละแถว (ลดลงเล็กน้อย เพื่อให้พอดีกับหน้ากระดาษ)
	rowHeight := tableHeight / 17 // ปรับจาก 20 เป็น 21 เพื่อให้แถวแคบลงเล็กน้อย

	// วาดกรอบใหญ่
	pdf.SetY(float64(tableStartY))
	pdf.SetLineWidth(0.5)
	pdf.Rect(10, float64(tableStartY), float64(tableWidth), float64(tableHeight), "D")

	// วาดเส้นแบ่งคอลัมน์ตรงกลาง
	pdf.Line(10+float64(colWidth), float64(tableStartY), 10+float64(colWidth), float64(tableStartY+tableHeight))

	// วาดเส้นแบ่งแถวแนวนอน (18 เส้น สำหรับ 19 แถว)
	for i := 1; i < 17; i++ {
		// ข้ามการวาดเส้นแบ่งสำหรับแถวที่ 4 (index i=3) ที่ต้องขยายความสูง
		if i == 4 {
			continue
		}
		yPos := tableStartY + (i * rowHeight)
		pdf.Line(10, float64(yPos), 10+float64(tableWidth), float64(yPos))
	}

	// ลดขนาดฟอนต์ทั้งหมดเล็กน้อย เพื่อให้พอดีกับหน้ากระดาษ
	pdf.SetFont("ANGSA", "", 14) // ลดจาก 10 เป็น 9

	// แถวที่ 1: Contract number
	currentY := float64(tableStartY + 2)
	pdf.SetXY(12, currentY)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("สัญญาเลขที่: %d", contract.ID))
	pdf.SetXY(12+float64(colWidth), currentY)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), "แพลตฟอร์ม: BiomassX.com")

	// แถวที่ 2: Contract type
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("ประเภทสัญญา: %s", contract.ContractTypeThName.String))
	pdf.SetXY(12+float64(colWidth), currentY)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("ตลาด: %s/%s/%s", contract.MarketspaceThName.String, contract.MarketThName.String, contract.SubmarketThName.String))

	// แถวที่ 3: Contract date
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), "วันที่ทำสัญญา:")
	pdf.SetXY(12+float64(colWidth), currentY)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), formatThaiDateWithThaiMonth(contract.FinishDelivery.Time))

	// แถวที่ 4: Seller และ Buyer address - ปรับลดความสูงลงเล็กน้อย
	currentY += float64(rowHeight)
	specialRowHeight := int(float64(rowHeight)*2.8) - 3

	// ข้อมูล Seller ทางซ้าย - ปรับลดขนาดฟอนต์
	pdf.SetFont("ANGSA", "", 16) // ลดขนาดฟอนต์ในส่วนที่อาจมีข้อความยาว

	pdf.SetXY(12, currentY)

	// ตรวจสอบ SellerOrgName ว่าเป็น NULL หรือไม่
	var sellerNameDisplay string
	if contract.SellerOrgName.Valid && contract.SellerOrgName.String != "" {
		sellerNameDisplay = contract.SellerOrgName.String
	} else {
		sellerNameDisplay = fmt.Sprintf("%s %s", contract.SellerFirstName.String, contract.SellerLastName.String)
	}

	pdf.MultiCell(float64(colWidth-4), float64(specialRowHeight)/7, fmt.Sprintf("ผู้ขาย:  %s\n%s %s\n%s %s %s %s\nT: %s E: %s\nผู้ประสานงาน: %s %s",
		sellerNameDisplay,
		sellerAddress.Address.String, sellerAddress.Street.String,
		sellerAddress.SubdistrictTH.String, sellerAddress.DistrictTH.String,
		sellerAddress.ProvinceTH.String, sellerAddress.PostalCode.String,
		seller.Phone.String, seller.Email.String,
		contract.SellerFirstName.String, contract.SellerLastName.String), "", "L", false)

	// ข้อมูล Buyer ทางขวา
	pdf.SetXY(12+float64(colWidth), currentY)

	// ตรวจสอบ BuyerOrgName ว่าเป็น NULL หรือไม่
	var buyerNameDisplay string
	if contract.BuyerOrgName.Valid && contract.BuyerOrgName.String != "" {
		buyerNameDisplay = contract.BuyerOrgName.String
	} else {
		buyerNameDisplay = fmt.Sprintf("%s %s", contract.BuyerFirstName.String, contract.BuyerLastName.String)
	}

	pdf.MultiCell(float64(colWidth-4), float64(specialRowHeight)/7, fmt.Sprintf("ผู้ซื้อ:  %s\n%s %s\n%s %s %s %s\nT: %s E: %s \nผู้ประสานงาน: %s %s",
		buyerNameDisplay,
		buyerAddress.Address.String, buyerAddress.Street.String,
		buyerAddress.SubdistrictTH.String, buyerAddress.DistrictTH.String,
		buyerAddress.ProvinceTH.String, buyerAddress.PostalCode.String,
		buyer.Phone.String, buyer.Email.String,
		contract.BuyerFirstName.String, contract.BuyerLastName.String), "", "L", false)

	// เปลี่ยนกลับเป็นฟอนต์หัวข้อสำหรับแถวถัดไป
	pdf.SetFont("ANGSA", "", 14) // ใช้ฟอนต์ขนาด 9 แทนขนาด 10

	// ปรับ currentY ให้เลื่อนลงตามความสูงพิเศษของแถวที่ 4
	// ปรับ currentY ให้เลื่อนลงตามความสูงพิเศษของแถวที่ 4
	currentY += float64(specialRowHeight - rowHeight) // เพิ่มแค่ส่วนต่างเพราะเราบวก rowHeight ไปแล้วครั้งหนึ่ง

	// แถวที่ 5: Product

	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), "สินค้า")
	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("%s", contract.ProductThName.String))

	// แถวที่ 6: Quality Standard
	currentY += float64(rowHeight) // เพิ่ม rowHeight สำหรับแถวถัดไป
	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), "คุณภาพ:")
	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("มาตรฐาน: %s, เกรด: %s", contract.StandardThName.String, contract.GradeThName.String))
	// แถวที่ 7: Quality Standard
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), "ราคาต่อหน่วย:")
	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("%v %s ต่อ %s", contract.Price, contract.CurrencyThName.String, contract.UomTh.String))

	// แถวที่ 8: Unit price
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), "จำนวน:")
	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("%v %s", contract.Quantity, contract.UomTh.String))

	// แถวที่ 9: Contract value
	contractValue := int(contract.Quantity * contract.Price)
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("มูลค่าสัญญา: "))
	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("%v %s", contractValue, contract.CurrencyThName.String))

	// แถวที่ 10: Payment term
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("บรรจุภัณฑ์: "))
	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("%s", contract.PackingTh.String))

	// แถวที่ 11: Location
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("เงื่อนไขการชำระเงิน: "))
	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("%s", contract.PaymentTermTh.String))

	// แถวที่ 12: Location
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("เงื่อนไขการส่งมอบ: "))
	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("%s", contract.DeliveryTermTh.String))

	// แถวที่ 13: Location
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("ประเทศผู้ซื้อ: %s", contract.SellerCountryTh.String))
	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("ประเทศผู้ขาย: %s", contract.BuyerCountryTh.String))

	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY+3)

	if contract.PodProvinceEn.Valid {
		// ถ้า PodProvinceEn ไม่เป็น NULL ให้แสดงข้อมูลเดิม
		pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("สถานที่ส่งมอบ: "))
		pdf.SetXY(12+float64(colWidth), currentY+3)
		pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("จังหวัด: %s", contract.PodProvinceTh.String))

		// แถวที่ 15: แสดง District/city และ Subdistrict/town
		currentY += float64(rowHeight)
		pdf.SetXY(12, currentY+3)
		pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("อำเภอ/เขต: %s", contract.PodDistrictTh.String))
		pdf.SetXY(12+float64(colWidth), currentY+3)
		pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("ตำบล/แขวง: %s", contract.PodSubdistrictTh.String))
	} else {
		// ถ้า PodProvinceEn เป็น NULL
		// แถว 14: แสดง Port of loading และ SellerPolEn
		pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("ท่าเรือบรรจุสินค้า: "))
		pdf.SetXY(12+float64(colWidth), currentY+3)
		pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("%s", contract.SellerPolTh.String))

		// แถว 15: แสดง Port of discharge และ BuyerPodEn
		currentY += float64(rowHeight)
		pdf.SetXY(12, currentY+3)
		pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("ท่าเรือส่งออก: "))
		pdf.SetXY(12+float64(colWidth), currentY+3)
		pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("%s", contract.BuyerPodTh.String))
	}

	// แก้ไขโค้ดส่วนแสดงวันที่เริ่มต้นและสิ้นสุดการส่งมอบด้วยชื่อเดือนภาษาไทย
	currentY += float64(rowHeight)
	pdf.SetXY(12, currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("วันส่งมอบเริ่มต้น: %s", formatNullTimeThai(contract.StartDelivery)))
	pdf.SetXY(12+float64(colWidth), currentY+3)
	pdf.Cell(float64(colWidth-4), float64(rowHeight), fmt.Sprintf("วันส่งมอบสุดท้าย: %s", formatNullTimeThai(contract.FinishDelivery)))

	// เพิ่ม Page Number หน้าที่ 1
	pdf.SetY(5)   // ตำแหน่ง Y ที่มุมล่างของหน้า
	pdf.SetX(180) // ตำแหน่ง X ที่มุมขวา
	pdf.SetFont("ANGSA", "", 14)
	pdf.Cell(20, 10, "หน้าที่ 1/2")

	pdf.AddPage()
	pdf.Ln(10)
	pdf.SetFont("ANGSA", "", 14)

	// เพิ่ม Seller และ Buyer Remarks ถ้ามีค่า
	hasRemarks := false

	// ตรวจสอบว่ามี Seller Remark หรือไม่
	if contract.SellerRemark.Valid && contract.SellerRemark.String != "" {
		hasRemarks = true
		pdf.SetFont("ANGSA", "", 14)
		pdf.Cell(0, 5, "หมายเหตุจากผู้ขาย")
		pdf.Ln(8)
		pdf.SetFont("ANGSA", "", 14)
		pdf.MultiCell(190, 6, contract.SellerRemark.String, "", "L", false)
		pdf.Ln(5)
	}

	// ตรวจสอบว่ามี Buyer Remark หรือไม่
	if contract.BuyerRemark.Valid && contract.BuyerRemark.String != "" {
		hasRemarks = true
		pdf.SetFont("ANGSA", "", 14)
		pdf.Cell(0, 5, "หมายเหตุจากผู้ซื้อ")
		pdf.Ln(8)
		pdf.SetFont("ANGSA", "", 14)
		pdf.MultiCell(190, 6, contract.BuyerRemark.String, "", "L", false)
		pdf.Ln(5)
	}

	// ถ้ามี remarks เพิ่ม space เพิ่มเติมหลังจากแสดง remarks
	if hasRemarks {
		pdf.Ln(5)
	}
	pdf.SetFont("ANGSA", "", 14)
	pdf.Cell(0, 5, "เงื่อนไขการให้บริการตลาดกลางพลังงานชีวภาพ(BiomassX.com)")
	pdf.Ln(5)
	pdf.SetFont("ANGSA", "", 14)

	pdf.MultiCell(190, 6, fmt.Sprintf(
		"1) ทั้งสองฝ่ายรับทราบและผูกำันตามข้อกำหนดและเงื่อนไขตามสัญญาหมายเลข %dและเงื่อนไขทั่วไปของตลาดกลางพลังงานชีวภาพ(BiomassX.com/terms_conditions.html.)",
		contract.ID), "", "L", false)
	pdf.Ln(3)
	pdf.MultiCell(190, 6, "2) ทั้งสองฝ่ายจะไม่โอนสิทธิ์หรือภาระผูกพันใดๆ ตามสัญญานี้โดยไม่ได้รับอนุญาติเป็นลายลักษณ์อักษรจากอีกฝ่ายหนึ่ง", "", "L", false)
	pdf.Ln(3)
	pdf.MultiCell(190, 6, "3) สัญญาฉบับนี้ออกโดยระบบคอมพิวเตอร์และถือว่าผู้ใช้งาน(user)ที่ลงทะเบียนไว้กับ BiomassX มีอำนาจกระทำการเสนอซื้อ เสนอขาย หรือได้รับอำนาจให้กระทำการเสนอซื้อเสนอขาย จากผู้มีอำนาจในนามบุคคลหรือนิติบุคคลแล้ว", "", "L", false)
	pdf.Ln(3)
	pdf.MultiCell(190, 6, "4) BiomassX จะเรียกเก็บค่าคอมมิชชั้นการซื้อขายแลกเปลี่ยนพลังงานชีวภาพจากทั้งจากผู้ขายและผู้ซื้อในอัตรา 0.50% ของมูลค่าสัญญาแต่ละฉบับ(ยังไม่รวมภาษีมูลค่าเพิ่ม)", "", "L", false)
	pdf.Ln(3)
	pdf.MultiCell(190, 6, "5) BiomassX ให้บริการในการจับคู่เสนอซื้อ เสนอขาย เท่านั้นในกรณีที่เกิดข้อพิพาทระหว่างคู่สัญญาภายใต้ข้อตกลงแห่งสัญญานี้ ไม่ว่าจะเป็น การตึความหรือขอบเขตของการละเมิดสัญญาคู่สัญญามีหน้าที่รับผิดชอบทางกฎหมายต่อข้อพิพาทดังกล่าวด้วยค่าใช้จ่ายของคู่สัญญาเอง", "", "L", false)
	pdf.Ln(5)

	pdf.Ln(10)
	pdf.SetFont("ANGSA", "", 14)
	pdf.Cell(0, 5, "คู่สัญญาทั้งสองฝ่ายได้อ่านและเข้าใจเนื้อหาแห่งสัญญาโดยครบถ้วนดีแล้ว จึงลงลายมือชื่อไว้เป็นหลักฐาน")
	pdf.Ln(10)

	// กำหนดค่าชื่อ Seller และ Buyer ตามเงื่อนไข OrgName
	sellerName := contract.SellerOrgName.String
	if sellerName == "" {
		sellerName = fmt.Sprintf("%s %s", contract.SellerFirstName.String, contract.SellerLastName.String)
	}

	buyerName := contract.BuyerOrgName.String
	if buyerName == "" {
		buyerName = fmt.Sprintf("%s %s", contract.BuyerFirstName.String, contract.BuyerLastName.String)
	}

	// FOR THE SELLER / FOR THE BUYER
	pdf.SetFont("ANGSA", "", 14)
	pdf.CellFormat(95, 6, "ในนานผู้ขาย:", "", 0, "L", false, 0, "")
	pdf.SetX(115) // จัดระยะให้ FOR THE BUYER ไม่ชิดขวาเกินไป
	pdf.CellFormat(95, 6, "ในนามผู้ซื้อ", "", 0, "L", false, 0, "")
	pdf.Ln(6)

	// NAME
	pdf.SetFont("ANGSA", "", 14)
	pdf.CellFormat(95, 6, fmt.Sprintf("%s", sellerName), "", 0, "L", false, 0, "")
	pdf.SetX(115) // จัดระยะให้ NAME ของ Buyer อยู่ตรงกับ SIGNATURE
	pdf.CellFormat(95, 6, fmt.Sprintf("%s", buyerName), "", 0, "L", false, 0, "")
	pdf.Ln(6)

	// SIGNATURE
	pdf.CellFormat(95, 6, "ลงชื่อ: ____________________", "", 0, "L", false, 0, "")
	pdf.SetX(115) // จัดระยะให้ SIGNATURE ของ Buyer อยู่ในแนวเดียวกับ NAME
	pdf.CellFormat(95, 6, "ลงชื่อ: ____________________", "", 0, "L", false, 0, "")
	pdf.Ln(10)

	pdf.SetY(5)   // ตำแหน่ง Y ที่มุมล่างของหน้า
	pdf.SetX(180) // ตำแหน่ง X ที่มุมขวา
	pdf.SetFont("ANGSA", "", 14)
	pdf.Cell(20, 10, "หน้าที่ 2/2")

	return pdf
}

// สร้างฟังก์ชันสำหรับแปลงวันที่เป็นรูปแบบไทยพร้อมชื่อเดือนภาษาไทย
func formatThaiDateWithThaiMonth(t time.Time) string {
	// ชื่อเดือนภาษาไทย
	thaiMonths := []string{
		"มกราคม", "กุมภาพันธ์", "มีนาคม", "เมษายน", "พฤษภาคม", "มิถุนายน",
		"กรกฎาคม", "สิงหาคม", "กันยายน", "ตุลาคม", "พฤศจิกายน", "ธันวาคม",
	}

	// แปลงปีเป็น พ.ศ.
	thaiYear := t.Year() + 543
	thaiMonth := thaiMonths[t.Month()-1]

	return fmt.Sprintf("%d %s %d", t.Day(), thaiMonth, thaiYear)
}

func formatNullTime(nt sql.NullTime, layout string) string {
	if nt.Valid {
		return nt.Time.Format(layout)
	}
	return "-" // หรือค่าอื่นที่ต้องการ
}

func formatNullTimeThai(nt sql.NullTime) string {
	if nt.Valid {
		return formatThaiDateWithThaiMonth(nt.Time)
	}
	return "-" // หรือค่าอื่นที่ต้องการ
}
