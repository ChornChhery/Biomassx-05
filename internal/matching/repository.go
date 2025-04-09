package matching

import (
	"database/sql"
	"fmt"
	"time"
)

// เพิ่มฟังก์ชันสำหรับอัปเดตข้อมูลใน table matchings
func updateOrder(db *sql.DB, orderID int, quantity float64, statusID int) error {
	// เริ่ม Transaction
	tx, err := db.Begin()
	if err != nil {
		return fmt.Errorf("failed to begin transaction: %w", err)
	}

	// อัปเดต table matchings
	matchingQuery := `
		UPDATE matchings
		SET quantity = $1, status_id = $2, updated_at = NOW()
		WHERE id = $3
	`
	_, err = tx.Exec(matchingQuery, quantity, statusID, orderID)
	if err != nil {
		tx.Rollback() // ยกเลิกการเปลี่ยนแปลง
		return fmt.Errorf("failed to update matchings: %w", err)
	}

	// อัปเดต table orders
	orderQuery := `
		UPDATE orders
		SET status_id = $1, updated_at = NOW()
		WHERE id = $2
	`
	_, err = tx.Exec(orderQuery, statusID, orderID)
	if err != nil {
		tx.Rollback() // ยกเลิกการเปลี่ยนแปลง
		return fmt.Errorf("failed to update orders: %w", err)
	}

	// Commit การเปลี่ยนแปลง
	if err := tx.Commit(); err != nil {
		return fmt.Errorf("failed to commit transaction: %w", err)
	}

	return nil
}



func insertContract(db *sql.DB, sellerID, buyerID, qualityID int, price float64, currencyID, uomID, packingID, paymentTermID, deliveryTermID, sellerCountryID, buyerCountryID int, volume float64, buyer Order, seller Order) error {
	var provinceID, districtID, subDistrictID int
	var startDeliveryDate, finishDeliveryDate time.Time
	var sellerPOL, sellerPOD, buyerPOL, buyerPOD sql.NullInt64

	// เลือกค่าที่ใช้สำหรับ delivery
	switch deliveryTermID {
	case 5: // ใช้ข้อมูลจาก buyer
		provinceID = buyer.ProvinceID
		districtID = buyer.DistrictID
		subDistrictID = buyer.SubDistrictID
		startDeliveryDate = buyer.FirstDeliveryDate
		finishDeliveryDate = buyer.LastDeliveryDate
	case 8, 9: // ใช้ข้อมูลจาก seller
		provinceID = seller.ProvinceID
		districtID = seller.DistrictID
		subDistrictID = seller.SubDistrictID
		startDeliveryDate = seller.FirstDeliveryDate
		finishDeliveryDate = seller.LastDeliveryDate
	default:
		if seller.PortOfLoadingID > 0 {
			sellerPOL = sql.NullInt64{Int64: int64(seller.PortOfLoadingID), Valid: true}
		}
		if seller.PortOfDischargeID > 0 {
			sellerPOD = sql.NullInt64{Int64: int64(seller.PortOfDischargeID), Valid: true}
		}
		if buyer.PortOfLoadingID > 0 {
			buyerPOL = sql.NullInt64{Int64: int64(buyer.PortOfLoadingID), Valid: true}
		}
		if buyer.PortOfDischargeID > 0 {
			buyerPOD = sql.NullInt64{Int64: int64(buyer.PortOfDischargeID), Valid: true}
		}
	}

	query := `
	INSERT INTO contracts (
		contract_date, seller_matching_id, buyer_matching_id,
		marketspace_id, market_id, submarket_id, contract_type_id, product_id,
		quality_id, price, currency_id, uom_id, packing_id,
		payment_term_id, delivery_term_id, quantity,
		delivery_status_id, payment_status_id,
		seller_confirmation_status_id, buyer_confirmation_status_id,
		contract_status_id, place_of_delivery_province, place_of_delivery_district, place_of_delivery_subdistrict,
		start_delivery_date, finish_delivery_date,
		seller_port_of_loading_id, seller_port_of_discharge_id,
		buyer_port_of_loading_id, buyer_port_of_discharge_id,
		seller_country_id, buyer_country_id,
		seller_remark, buyer_remark
	) VALUES (
		NOW(), $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15,
		26, 28, 19, 19, 19, $16, $17, $18, $19, $20,
		$21, $22, $23, $24, $25, $26,
		$27, $28
	)
	`

	_, err := db.Exec(query, sellerID, buyerID,
		seller.MarketspaceID, seller.MarketID, seller.SubMarketID, seller.ContractTypeID, seller.ProductID,
		qualityID, price, currencyID, uomID, packingID,
		paymentTermID, deliveryTermID, volume,
		provinceID, districtID, subDistrictID, startDeliveryDate, finishDeliveryDate,
		sellerPOL, sellerPOD, buyerPOL, buyerPOD, sellerCountryID, buyerCountryID,
		seller.Remark, buyer.Remark,
	)
	if err != nil {
		return fmt.Errorf("failed to insert contract: %w", err)
	}

	return nil
}
