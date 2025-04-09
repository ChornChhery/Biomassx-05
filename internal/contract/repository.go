package contract

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strconv"

	"github.com/thongsoi/biomassx-05/database"
)

func FetchContractData(db *sql.DB) ([]Contract, error) {
	query := `
	SELECT 
		c.id, 
		c.contract_date, 
		seller.user_id AS seller_user_id, 
		seller_user.first_name AS seller_first_name, 
		seller_user.last_name AS seller_last_name, 
		seller_user.organization_name AS seller_org_name, 
		buyer.user_id AS buyer_user_id, 
		buyer_user.first_name AS buyer_first_name, 
		buyer_user.last_name AS buyer_last_name, 
		buyer_user.organization_name AS buyer_org_name, 
		c.product_id,  
		prod.en_name AS product_en_name, prod.th_name AS product_th_name,  
		q.standard_id, 
		std.en_name AS standard_en_name, std.th_name AS standard_th_name, 
		q.grade_id, 
		g.en_name AS grade_en_name, g.th_name AS grade_th_name, 
		c.price, 
		cur.en_name AS currency_en_name, cur.th_name AS currency_th_name, 
		c.quantity, 
		u.en_name AS uom_en, u.th_name AS uom_th, 
		u.description AS uom_description, 
		c.packing_id, 
		pck.en_name AS packing_en, pck.th_name AS packing_th, 
		dt.en_name AS delivery_term_en, dt.th_name AS delivery_term_th, 
		p.en_name AS province_en, p.th_name AS province_th, 
		d.en_name AS district_en, d.th_name AS district_th, 
		sub.en_name AS subdistrict_en, sub.th_name AS subdistrict_th, 
		scs_delivery.en_name AS delivery_status_en, scs_delivery.th_name AS delivery_status_th, 
		c.start_delivery_date, 
		c.finish_delivery_date, 
		pt.en_name AS payment_term_en, pt.th_name AS payment_term_th, 
		pt.description AS payment_term_description, 
		scs_payment.en_name AS payment_status_en, scs_payment.th_name AS payment_status_th, 
		c.seller_remark, 
		c.buyer_remark, 
		seller_status.en_name AS seller_confirmation_status_en, seller_status.th_name AS seller_confirmation_status_th, 
		buyer_status.en_name AS buyer_confirmation_status_en, buyer_status.th_name AS buyer_confirmation_status_th, 
		contract_status.en_name AS contract_status_en, contract_status.th_name AS contract_status_th,
		seller_pol.en_name AS seller_pol_en, seller_pol.th_name AS seller_pol_th,  
		seller_pod.en_name AS seller_pod_en, seller_pod.th_name AS seller_pod_th,  
		buyer_pol.en_name AS buyer_pol_en, buyer_pol.th_name AS buyer_pol_th,    
		buyer_pod.en_name AS buyer_pod_en, buyer_pod.th_name AS buyer_pod_th,
		seller_country.en_name AS seller_country_en, seller_country.th_name AS seller_country_th, 
		buyer_country.en_name AS buyer_country_en, buyer_country.th_name AS buyer_country_th,
		ct.en_name AS contract_type_en_name,   
		ct.th_name AS contract_type_th_name,
		marketspace.en_name AS marketspace_en_name, marketspace.th_name AS marketspace_th_name,  -- marketspace info
		market.en_name AS market_en_name, market.th_name AS market_th_name,  -- market info
		submarket.en_name AS submarket_en_name, submarket.th_name AS submarket_th_name  -- submarket info
	FROM contracts c
	LEFT JOIN matchings seller ON c.seller_matching_id = seller.id
	LEFT JOIN users seller_user ON seller.user_id = seller_user.id  
	LEFT JOIN matchings buyer ON c.buyer_matching_id = buyer.id
	LEFT JOIN users buyer_user ON buyer.user_id = buyer_user.id  
	LEFT JOIN products prod ON c.product_id = prod.id
	LEFT JOIN qualities q ON c.quality_id = q.id
	LEFT JOIN standards std ON q.standard_id = std.id
	LEFT JOIN grades g ON q.grade_id = g.id
	LEFT JOIN currencies cur ON c.currency_id = cur.id
	LEFT JOIN uoms u ON c.uom_id = u.id  
	LEFT JOIN delivery_terms dt ON c.delivery_term_id = dt.id
	LEFT JOIN provinces p ON c.place_of_delivery_province = p.id
	LEFT JOIN districts d ON c.place_of_delivery_district = d.id
	LEFT JOIN subdistricts sub ON c.place_of_delivery_subdistrict = sub.id
	LEFT JOIN packings pck ON c.packing_id = pck.id
	LEFT JOIN payment_terms pt ON c.payment_term_id = pt.id  
	LEFT JOIN status_categories_statuses scs_seller ON c.seller_confirmation_status_id = scs_seller.id
	LEFT JOIN statuses seller_status ON scs_seller.status_id = seller_status.id
	LEFT JOIN status_categories_statuses scs_buyer ON c.buyer_confirmation_status_id = scs_buyer.id
	LEFT JOIN statuses buyer_status ON scs_buyer.status_id = buyer_status.id
	LEFT JOIN status_categories_statuses scs_contract ON c.contract_status_id = scs_contract.id
	LEFT JOIN statuses contract_status ON scs_contract.status_id = contract_status.id
	LEFT JOIN status_categories_statuses scs_delivery_status ON c.delivery_status_id = scs_delivery_status.id
	LEFT JOIN statuses scs_delivery ON scs_delivery_status.status_id = scs_delivery.id
	LEFT JOIN status_categories_statuses scs_payment_status ON c.payment_status_id = scs_payment_status.id
	LEFT JOIN statuses scs_payment ON scs_payment_status.status_id = scs_payment.id
	LEFT JOIN ports seller_pol ON c.seller_port_of_loading_id = seller_pol.id  
	LEFT JOIN ports seller_pod ON c.seller_port_of_discharge_id = seller_pod.id  
	LEFT JOIN ports buyer_pol ON c.buyer_port_of_loading_id = buyer_pol.id  
	LEFT JOIN ports buyer_pod ON c.buyer_port_of_discharge_id = buyer_pod.id  
	LEFT JOIN countries seller_country ON c.seller_country_id = seller_country.id  
	LEFT JOIN countries buyer_country ON c.buyer_country_id = buyer_country.id  
	LEFT JOIN contract_types ct ON c.contract_type_id = ct.id
	LEFT JOIN marketspaces marketspace ON c.marketspace_id = marketspace.id  -- เพิ่มการ join กับ marketspaces
	LEFT JOIN markets market ON c.market_id = market.id  -- เพิ่มการ join กับ markets
	LEFT JOIN submarkets submarket ON c.submarket_id = submarket.id  -- เพิ่มการ join กับ submarkets
	WHERE c.contract_status_id IN (19,20,21,22,23,24)
	`

	rows, err := db.Query(query)
	if err != nil {
		log.Println("Error querying contracts:", err)
		return nil, err
	}
	defer rows.Close()

	var contracts []Contract
	for rows.Next() {
		var contract Contract
		err := rows.Scan(
			&contract.ID, &contract.ContractDate,
			&contract.SellerUserID, &contract.SellerFirstName, &contract.SellerLastName, &contract.SellerOrgName,
			&contract.BuyerUserID, &contract.BuyerFirstName, &contract.BuyerLastName, &contract.BuyerOrgName,
			&contract.ProductID, &contract.ProductEnName, &contract.ProductThName,
			&contract.StandardID, &contract.StandardEnName, &contract.StandardThName,
			&contract.GradeID, &contract.GradeEnName, &contract.GradeThName,
			&contract.Price, &contract.CurrencyEnName, &contract.CurrencyThName, &contract.Quantity,
			&contract.UomEn, &contract.UomTh, &contract.UomDescription,
			&contract.PackingID, &contract.PackingEn, &contract.PackingTh,
			&contract.DeliveryTermEn, &contract.DeliveryTermTh,
			&contract.PodProvinceEn, &contract.PodProvinceTh,
			&contract.PodDistrictEn, &contract.PodDistrictTh,
			&contract.PodSubdistrictEn, &contract.PodSubdistrictTh,
			&contract.DeliveryStatusEn, &contract.DeliveryStatusTh,
			&contract.StartDelivery, &contract.FinishDelivery,
			&contract.PaymentTermEn, &contract.PaymentTermTh, &contract.PaymentTermDescription,
			&contract.PaymentStatusEn, &contract.PaymentStatusTh,
			&contract.SellerRemark, &contract.BuyerRemark,
			&contract.SellerConfirmStatusEn, &contract.SellerConfirmStatusTh,
			&contract.BuyerConfirmStatusEn, &contract.BuyerConfirmStatusTh,
			&contract.ContractStatusEn, &contract.ContractStatusTh,
			&contract.SellerPolEn, &contract.SellerPolTh,
			&contract.SellerPodEn, &contract.SellerPodTh,
			&contract.BuyerPolEn, &contract.BuyerPolTh,
			&contract.BuyerPodEn, &contract.BuyerPodTh,
			&contract.SellerCountryEn, &contract.SellerCountryTh,
			&contract.BuyerCountryEn, &contract.BuyerCountryTh,
			&contract.ContractTypeEnName,
			&contract.ContractTypeThName,
			&contract.MarketspaceEnName, &contract.MarketspaceThName, // marketspace
			&contract.MarketEnName, &contract.MarketThName, // market
			&contract.SubmarketEnName, &contract.SubmarketThName, // submarket
		)
		if err != nil {
			log.Println("Error scanning contract:", err)
			return nil, err
		}
		contracts = append(contracts, contract)
	}
	return contracts, nil
}

func FetchContractUserDetails(db *sql.DB, contractID string) (ContractUserDetails, error) {
	query := `
        SELECT 
            c.id, c.contract_date,
            seller.first_name, seller.last_name, seller.organization_name, seller.id,  
            buyer.first_name, buyer.last_name, buyer.organization_name, buyer.id,  
            c.product_id,  -- เพิ่ม product_id
            p.en_name AS product_en_name, p.th_name AS product_th_name,  -- เพิ่มชื่อภาษาอังกฤษและไทยของสินค้า
            q.standard_id, std.en_name, std.th_name, 
            q.grade_id, g.en_name, g.th_name,
            c.price, cur.en_name, cur.th_name, c.quantity, 
            u.en_name, u.th_name, u.description,
            c.packing_id, pck.en_name, pck.th_name, 
            dt.en_name, dt.th_name, 
            prov.en_name, prov.th_name,
            d.en_name, d.th_name,
            sub.en_name, sub.th_name,
            scs_delivery.en_name, scs_delivery.th_name,
            c.start_delivery_date, c.finish_delivery_date, 
            pt.en_name, pt.th_name, pt.description, 
            scs_payment.en_name, scs_payment.th_name,
            c.seller_remark, c.buyer_remark,
            seller_status.en_name, seller_status.th_name, 
            buyer_status.en_name, buyer_status.th_name, 
            contract_status.en_name, contract_status.th_name,
            seller_pol.en_name, seller_pol.th_name,  
            seller_pod.en_name, seller_pod.th_name,  
            buyer_pol.en_name, buyer_pol.th_name,    
            buyer_pod.en_name, buyer_pod.th_name,    
            seller_country.en_name, seller_country.th_name, 
            buyer_country.en_name, buyer_country.th_name ,
            ct.en_name AS contract_type_en_name,   -- เพิ่มข้อมูลของ contract type ภาษาอังกฤษ
            ct.th_name AS contract_type_th_name,    -- เพิ่มข้อมูลของ contract type ภาษาไทย
            marketspace.en_name AS marketspace_en_name, marketspace.th_name AS marketspace_th_name,  -- marketspace info
		    market.en_name AS market_en_name, market.th_name AS market_th_name,  -- market info
		    submarket.en_name AS submarket_en_name, submarket.th_name AS submarket_th_name  -- submarket info
        FROM contracts c
        LEFT JOIN matchings seller_match ON c.seller_matching_id = seller_match.id
        LEFT JOIN matchings buyer_match ON c.buyer_matching_id = buyer_match.id
        LEFT JOIN users seller ON seller_match.user_id = seller.id
        LEFT JOIN users buyer ON buyer_match.user_id = buyer.id
        LEFT JOIN products p ON c.product_id = p.id  -- เชื่อมโยงกับตาราง products ด้วย product_id
        LEFT JOIN qualities q ON c.quality_id = q.id
        LEFT JOIN standards std ON q.standard_id = std.id
        LEFT JOIN grades g ON q.grade_id = g.id
        LEFT JOIN currencies cur ON c.currency_id = cur.id
        LEFT JOIN uoms u ON c.uom_id = u.id  
        LEFT JOIN delivery_terms dt ON c.delivery_term_id = dt.id
        LEFT JOIN provinces prov ON c.place_of_delivery_province = prov.id
        LEFT JOIN districts d ON c.place_of_delivery_district = d.id
        LEFT JOIN subdistricts sub ON c.place_of_delivery_subdistrict = sub.id
        LEFT JOIN packings pck ON c.packing_id = pck.id
        LEFT JOIN payment_terms pt ON c.payment_term_id = pt.id  
        LEFT JOIN status_categories_statuses scs_seller ON c.seller_confirmation_status_id = scs_seller.id
        LEFT JOIN statuses seller_status ON scs_seller.status_id = seller_status.id
        LEFT JOIN status_categories_statuses scs_buyer ON c.buyer_confirmation_status_id = scs_buyer.id
        LEFT JOIN statuses buyer_status ON scs_buyer.status_id = buyer_status.id
        LEFT JOIN status_categories_statuses scs_contract ON c.contract_status_id = scs_contract.id
        LEFT JOIN statuses contract_status ON scs_contract.status_id = contract_status.id
        LEFT JOIN status_categories_statuses scs_delivery_status ON c.delivery_status_id = scs_delivery_status.id
        LEFT JOIN statuses scs_delivery ON scs_delivery_status.status_id = scs_delivery.id
        LEFT JOIN status_categories_statuses scs_payment_status ON c.payment_status_id = scs_payment_status.id
        LEFT JOIN statuses scs_payment ON scs_payment_status.status_id = scs_payment.id
        LEFT JOIN ports seller_pol ON c.seller_port_of_loading_id = seller_pol.id  
        LEFT JOIN ports seller_pod ON c.seller_port_of_discharge_id = seller_pod.id  
        LEFT JOIN ports buyer_pol ON c.buyer_port_of_loading_id = buyer_pol.id  
        LEFT JOIN ports buyer_pod ON c.buyer_port_of_discharge_id = buyer_pod.id  
        LEFT JOIN countries seller_country ON c.seller_country_id = seller_country.id
        LEFT JOIN countries buyer_country ON c.buyer_country_id = buyer_country.id
        LEFT JOIN contract_types ct ON c.contract_type_id = ct.id
        LEFT JOIN marketspaces marketspace ON c.marketspace_id = marketspace.id  -- เพิ่มการ join กับ marketspaces
	    LEFT JOIN markets market ON c.market_id = market.id  -- เพิ่มการ join กับ markets
	    LEFT JOIN submarkets submarket ON c.submarket_id = submarket.id  -- เพิ่มการ join กับ submarkets
        WHERE c.id = $1
    `

	row := db.QueryRow(query, contractID)

	var details ContractUserDetails
	err := row.Scan(
		&details.ID, &details.ContractDate,
		&details.SellerFirstName, &details.SellerLastName, &details.SellerOrgName, &details.SellerUserID,
		&details.BuyerFirstName, &details.BuyerLastName, &details.BuyerOrgName, &details.BuyerUserID,
		&details.ProductID,                             // เพิ่ม ProductID
		&details.ProductEnName, &details.ProductThName, // เพิ่มชื่อภาษาอังกฤษและไทยของสินค้า
		&details.StandardID, &details.StandardEnName, &details.StandardThName,
		&details.GradeID, &details.GradeEnName, &details.GradeThName,
		&details.Price, &details.CurrencyEnName, &details.CurrencyThName, &details.Quantity,
		&details.UomEn, &details.UomTh, &details.UomDescription,
		&details.PackingID, &details.PackingEn, &details.PackingTh,
		&details.DeliveryTermEn, &details.DeliveryTermTh,
		&details.PodProvinceEn, &details.PodProvinceTh,
		&details.PodDistrictEn, &details.PodDistrictTh,
		&details.PodSubdistrictEn, &details.PodSubdistrictTh,
		&details.DeliveryStatusEn, &details.DeliveryStatusTh,
		&details.StartDelivery, &details.FinishDelivery,
		&details.PaymentTermEn, &details.PaymentTermTh, &details.PaymentTermDescription,
		&details.PaymentStatusEn, &details.PaymentStatusTh,
		&details.SellerRemark, &details.BuyerRemark,
		&details.SellerConfirmStatusEn, &details.SellerConfirmStatusTh,
		&details.BuyerConfirmStatusEn, &details.BuyerConfirmStatusTh,
		&details.ContractStatusEn, &details.ContractStatusTh,
		&details.SellerPolEn, &details.SellerPolTh,
		&details.SellerPodEn, &details.SellerPodTh,
		&details.BuyerPolEn, &details.BuyerPolTh,
		&details.BuyerPodEn, &details.BuyerPodTh,
		&details.SellerCountryEn, &details.SellerCountryTh,
		&details.BuyerCountryEn, &details.BuyerCountryTh,
		&details.ContractTypeEnName,                            // เพิ่มการดึงข้อมูล contract_type_en_name
		&details.ContractTypeThName,                            // เพิ่มการดึงข้อมูล contract_type_th_name
		&details.MarketspaceEnName, &details.MarketspaceThName, // marketspace
		&details.MarketEnName, &details.MarketThName, // market
		&details.SubmarketEnName, &details.SubmarketThName, // submarket

	)

	if err != nil {
		log.Println("Error fetching contract user details by ID:", err)
		return ContractUserDetails{}, err
	}

	return details, nil
}

func UpdateContractStatusHandler(w http.ResponseWriter, r *http.Request) {
	log.Println("[UpdateContractStatusHandler] 🔄 Handling contract update request")

	// ดึง user_id จาก token อัตโนมัติ
	userID, err := getUserIDFromToken(r)
	if err != nil {
		http.Error(w, "Unauthorized", http.StatusUnauthorized)
		return
	}

	// รองรับ HTMX (x-www-form-urlencoded) และ JSON
	var req UpdateContractRequest
	contentType := r.Header.Get("Content-Type")

	switch contentType {
	case "application/json":
		if err := json.NewDecoder(r.Body).Decode(&req); err != nil {
			http.Error(w, "Invalid JSON request", http.StatusBadRequest)
			return
		}
	case "application/x-www-form-urlencoded":
		if err := r.ParseForm(); err != nil {
			http.Error(w, "Invalid form request", http.StatusBadRequest)
			return
		}
		contractID, err := strconv.ParseInt(r.FormValue("contract_id"), 10, 64)
		if err != nil {
			http.Error(w, "Invalid contract ID", http.StatusBadRequest)
			return
		}
		req.ContractID = contractID
	default:
		http.Error(w, "Unsupported Content-Type", http.StatusBadRequest)
		return
	}

	req.UserID = int64(userID)

	// เริ่ม transaction
	db := database.GetDB()
	tx, err := db.Begin()
	if err != nil {
		http.Error(w, "Failed to start transaction", http.StatusInternalServerError)
		return
	}
	defer tx.Rollback()

	// ดึงข้อมูล contract และตรวจสอบสิทธิ์
	var sellerID, buyerID int64
	var sellerConfirm, buyerConfirm int
	query := `SELECT seller.id, buyer.id, c.seller_confirmation_status_id, c.buyer_confirmation_status_id 
    FROM contracts c
    LEFT JOIN matchings seller_match ON c.seller_matching_id = seller_match.id
    LEFT JOIN matchings buyer_match ON c.buyer_matching_id = buyer_match.id
    LEFT JOIN users seller ON seller_match.user_id = seller.id
    LEFT JOIN users buyer ON buyer_match.user_id = buyer.id
    WHERE c.id = $1`
	err = db.QueryRow(query, req.ContractID).Scan(&sellerID, &buyerID, &sellerConfirm, &buyerConfirm)
	if err != nil {
		log.Printf("Error executing query: %v", err)
		http.Error(w, "Contract not found", http.StatusNotFound)
		return
	}

	// ตรวจสอบสิทธิ์และกำหนดคอลัมน์ที่จะอัพเดท
	var columnToUpdate string
	switch req.UserID {
	case sellerID:
		columnToUpdate = "seller_confirmation_status_id"
	case buyerID:
		columnToUpdate = "buyer_confirmation_status_id"
	default:
		http.Error(w, "User not authorized", http.StatusForbidden)
		return
	}

	// อัพเดทสถานะการยืนยัน
	updateQuery := fmt.Sprintf("UPDATE contracts SET %s = $1 WHERE id = $2", columnToUpdate)
	result, err := tx.Exec(updateQuery, 20, req.ContractID)
	if err != nil {
		http.Error(w, "Failed to update confirmation status", http.StatusInternalServerError)
		return
	}

	rowsAffected, err := result.RowsAffected()
	if err != nil || rowsAffected == 0 {
		http.Error(w, "No rows updated", http.StatusInternalServerError)
		return
	}

	// กำหนดสถานะสัญญา
	contractStatusID := 21 // สถานะเริ่มต้น
	if (req.UserID == sellerID && buyerConfirm == 20) || (req.UserID == buyerID && sellerConfirm == 20) {
		contractStatusID = 20 // สถานะเมื่อทั้งสองฝ่ายยืนยัน
	}

	// อัพเดทสถานะสัญญา
	result, err = tx.Exec("UPDATE contracts SET contract_status_id = $1 WHERE id = $2",
		contractStatusID, req.ContractID)
	if err != nil {
		http.Error(w, "Failed to update contract status", http.StatusInternalServerError)
		return
	}

	rowsAffected, err = result.RowsAffected()
	if err != nil || rowsAffected == 0 {
		http.Error(w, "No rows updated", http.StatusInternalServerError)
		return
	}

	// ยืนยัน transaction
	if err := tx.Commit(); err != nil {
		http.Error(w, "Transaction commit failed", http.StatusInternalServerError)
		return
	}

	// ส่งการตอบกลับตามรูปแบบที่ร้องขอ
	switch {
	case r.Header.Get("HX-Request") == "true":
		{
			w.Header().Set("Content-Type", "text/html")
			fmt.Fprint(w, `
                <dialog id="status-dialog">
                    <p>You have successfully signed the contract</p>
                    <form method="dialog">
                        <button id="confirm-button" type="submit">confirm</button>
                    </form>
                </dialog>
                <script>
                    const dialog = document.getElementById('status-dialog');
                    dialog.showModal();
                    dialog.addEventListener('close', () => {
                        location.reload();
                    });
                </script>
            `)
			return
		}

	default:
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(map[string]interface{}{
			"contract_status": contractStatusID,
			"message":         "Contract status updated successfully",
		})
	}
}
func FetchUserAndLocationDetails(db *sql.DB, userID sql.NullInt64) (User, Address, error) {
	if !userID.Valid {
		log.Println("UserID is NULL, skipping fetch")
		return User{}, Address{}, nil
	}

	var user User
	var address Address

	log.Printf("Fetching user details for userID: %d", userID.Int64)

	query := "SELECT email, phone FROM users WHERE id = $1"
	log.Printf("Executing Query: %s with ID: %d", query, userID.Int64)

	row := db.QueryRow(query, userID.Int64)
	err := row.Scan(&user.Email, &user.Phone)
	if err != nil {
		log.Printf("Error fetching user details for userID %d: %v", userID.Int64, err)
		return User{}, Address{}, err
	}

	log.Println("Fetching address details")

	query = "SELECT address_type_id, branch_number, country_id, province_id, district_id, subdistrict_id, street, address, postal_code FROM addresses WHERE user_id = $1"
	log.Printf("Executing Query: %s with userID: %d", query, userID.Int64)

	row = db.QueryRow(query, userID.Int64)
	err = row.Scan(&address.AddressTypeID, &address.BranchNumber, &address.CountryID, &address.ProvinceID, &address.DistrictID, &address.SubdistrictID, &address.Street, &address.Address, &address.PostalCode)
	if err != nil {
		log.Printf("Error fetching address details for userID %d: %v", userID.Int64, err)
		return User{}, Address{}, err
	}

	log.Println("Fetching location details")

	if address.ProvinceID.Valid {
		log.Printf("Fetching Province Name for ID: %d", address.ProvinceID.Int64)
		err = db.QueryRow("SELECT en_name, th_name FROM provinces WHERE id = $1", address.ProvinceID.Int64).Scan(&address.ProvinceEN, &address.ProvinceTH)
		if err != nil {
			log.Printf("Error fetching province: %v", err)
		}
	}
	if address.DistrictID.Valid {
		log.Printf("Fetching District Name for ID: %d", address.DistrictID.Int64)
		err = db.QueryRow("SELECT en_name, th_name FROM districts WHERE id = $1", address.DistrictID.Int64).Scan(&address.DistrictEN, &address.DistrictTH)
		if err != nil {
			log.Printf("Error fetching district: %v", err)
		}
	}
	if address.SubdistrictID.Valid {
		log.Printf("Fetching Subdistrict Name for ID: %d", address.SubdistrictID.Int64)
		err = db.QueryRow("SELECT en_name, th_name FROM subdistricts WHERE id = $1", address.SubdistrictID.Int64).Scan(&address.SubdistrictEN, &address.SubdistrictTH)
		if err != nil {
			log.Printf("Error fetching subdistrict: %v", err)
		}
	}
	if address.CountryID.Valid {
		log.Printf("Fetching Country Name for ID: %d", address.CountryID.Int64)
		err = db.QueryRow("SELECT en_name, th_name FROM countries WHERE id = $1", address.CountryID.Int64).Scan(&address.CountryEN, &address.CountryTH)
		if err != nil {
			log.Printf("Error fetching country: %v", err)
		}
	}

	log.Printf("User and location details fetched for ID: %d", userID.Int64)
	return user, address, nil
}
