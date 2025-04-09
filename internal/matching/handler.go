package matching

import (
	"container/heap"
	"database/sql"
	"fmt"
)

func MatchOrders(db *sql.DB) error {
	// ดึงคำสั่งล่าสุดที่เพิ่ง insert และมี status = 1
	query := `
	SELECT id, user_id, marketspace_id, market_id, submarket_id, order_type_id, matching_type_id, contract_type_id,
	product_id, quality_id, price, currency_id, quantity, uom_id, packing_id, payment_term_id, delivery_term_id,
	country_id, port_of_loading_id, port_of_discharge_id,
	province_id, district_id, subdistrict_id, first_delivery_date, last_delivery_date, created_at, updated_at, remark
	FROM matchings
	WHERE status_id IN (13, 14)
	ORDER BY id DESC
	LIMIT 1
	`

	row := db.QueryRow(query)
	var newOrder Order
	err := row.Scan(
		&newOrder.ID, &newOrder.UserID, &newOrder.MarketspaceID, &newOrder.MarketID, &newOrder.SubMarketID, &newOrder.OrderTypeID,
		&newOrder.MatchingTypeID, &newOrder.ContractTypeID, &newOrder.ProductID, &newOrder.QualityID, &newOrder.Price,
		&newOrder.Currencies, &newOrder.Quantity, &newOrder.UOMID, &newOrder.PackingID, &newOrder.PaymentTermID, &newOrder.DeliveryTermID,
		&newOrder.CountryID, &newOrder.PortOfLoadingID, &newOrder.PortOfDischargeID,
		&newOrder.ProvinceID, &newOrder.DistrictID, &newOrder.SubDistrictID, &newOrder.FirstDeliveryDate, &newOrder.LastDeliveryDate,
		&newOrder.CreatedAt, &newOrder.UpdatedAt, &newOrder.Remark,
	)
	if err != nil {
		if err == sql.ErrNoRows {
			return fmt.Errorf("no orders found with status_id IN (13, 14)")
		}
		return fmt.Errorf("failed to fetch the latest order: %w", err)
	}

	buyHeap := &MaxHeap{}
	sellHeap := &MinHeap{}
	heap.Init(buyHeap)
	heap.Init(sellHeap)

	for {
		// ดึงคำสั่งที่เกี่ยวข้อง
		var relatedOrders []Order
		if newOrder.OrderTypeID == 1 {
			query = `
				SELECT id, user_id, marketspace_id, market_id, submarket_id, order_type_id, matching_type_id,
				product_id, quality_id, contract_type_id, price, quantity, currency_id, uom_id, packing_id, payment_term_id, delivery_term_id, country_id,
				port_of_loading_id, port_of_discharge_id, province_id, district_id, subdistrict_id, first_delivery_date, last_delivery_date, created_at, updated_at, remark
				FROM matchings
				WHERE order_type_id = 2
				  AND price <= $1
					AND status_id IN (13, 14)
					AND market_id = $2
					AND submarket_id = $3
					AND marketspace_id = $4
					AND contract_type_id = $5
					AND product_id = $6
					AND quality_id = $7
					AND currency_id = $8
					AND uom_id = $9
					AND packing_id = $10
				  AND payment_term_id = $11
				  AND delivery_term_id = $12
				  AND first_delivery_date <= $13
				  AND last_delivery_date >= $14
				  AND user_id != $15
				ORDER BY price ASC, created_at ASC
			`
		} else if newOrder.OrderTypeID == 2 {
			query = `
				SELECT id, user_id, marketspace_id, market_id, submarket_id, order_type_id, matching_type_id,
				product_id, quality_id, contract_type_id, price, quantity, currency_id, uom_id, packing_id, payment_term_id, delivery_term_id, country_id,
				port_of_loading_id, port_of_discharge_id, province_id, district_id, subdistrict_id, first_delivery_date, last_delivery_date, created_at, updated_at, remark
				FROM matchings
				WHERE order_type_id = 1
				  AND price >= $1
				  AND status_id IN (13, 14)
				  AND market_id = $2
				  AND submarket_id = $3
				  AND marketspace_id = $4
				  AND contract_type_id = $5
				  AND product_id = $6
				  AND quality_id = $7
				  AND currency_id = $8
				  AND uom_id = $9
				  AND packing_id = $10
				  AND payment_term_id = $11
				  AND delivery_term_id = $12
				  AND first_delivery_date <= $13
				  AND last_delivery_date >= $14
				  AND user_id != $15
				ORDER BY price DESC, created_at ASC
			`
		}

		rows, err := db.Query(query,
			newOrder.Price, newOrder.MarketID, newOrder.SubMarketID,
			newOrder.MarketspaceID, newOrder.ContractTypeID, newOrder.ProductID,
			newOrder.QualityID, newOrder.Currencies, newOrder.UOMID,
			newOrder.PackingID, newOrder.PaymentTermID, newOrder.DeliveryTermID, 
			newOrder.FirstDeliveryDate, newOrder.LastDeliveryDate, newOrder.UserID,
		)

		if err != nil {
			return fmt.Errorf("failed to fetch related orders: %w", err)
		}
		defer rows.Close()

		for rows.Next() {
			var order Order
			err := rows.Scan(
				&order.ID, &order.UserID, &order.MarketspaceID, &order.MarketID, &order.SubMarketID, &order.OrderTypeID,
				&order.MatchingTypeID, &order.ProductID, &order.QualityID, &order.ContractTypeID,
				&order.Price, &order.Quantity, &order.Currencies, &order.UOMID, &order.PackingID,
				&order.PaymentTermID, &order.DeliveryTermID, &order.CountryID, &order.PortOfLoadingID, &order.PortOfDischargeID, 
				&order.ProvinceID, &order.DistrictID, &order.SubDistrictID, &order.FirstDeliveryDate, &order.LastDeliveryDate,
				&order.CreatedAt, &order.UpdatedAt, &order.Remark,
			)
			if err != nil {
				return fmt.Errorf("failed to scan related orders: %w", err)
			}
			relatedOrders = append(relatedOrders, order)
		}

		// ใส่คำสั่งที่เกี่ยวข้องลงใน Heap
		for _, order := range relatedOrders {
			if order.OrderTypeID == 1 {
				heap.Push(buyHeap, &order)
			} else if order.OrderTypeID == 2 {
				heap.Push(sellHeap, &order)
			}
		}

		if newOrder.OrderTypeID == 1 {
			heap.Push(buyHeap, &newOrder)
		} else if newOrder.OrderTypeID == 2 {
			heap.Push(sellHeap, &newOrder)
		}

		matched := false
		for buyHeap.Len() > 0 && sellHeap.Len() > 0 {
			buyOrder := heap.Pop(buyHeap).(*Order)
			sellOrder := heap.Pop(sellHeap).(*Order)

			if buyOrder.Quantity > 0 && sellOrder.Quantity > 0 {
				matchQuantity := min(buyOrder.Quantity, sellOrder.Quantity)

				fmt.Printf("Matched: Buyer %d and Seller %d, Price: %.2f, Quantity: %.2f\n",
					buyOrder.ID, sellOrder.ID, sellOrder.Price, matchQuantity)

				err = insertContract(db, sellOrder.ID, buyOrder.ID, buyOrder.QualityID, sellOrder.Price, buyOrder.Currencies,
					buyOrder.UOMID, buyOrder.PackingID, buyOrder.PaymentTermID, buyOrder.DeliveryTermID,
					sellOrder.CountryID, buyOrder.CountryID,
					matchQuantity, *buyOrder, *sellOrder)
				if err != nil {
					return fmt.Errorf("failed to insert contract: %w", err)
				}

				buyOrder.Quantity -= matchQuantity
				sellOrder.Quantity -= matchQuantity

				if buyOrder.Quantity > 0 {
					updateOrder(db, buyOrder.ID, buyOrder.Quantity, 14)
					heap.Push(buyHeap, buyOrder)
				} else {
					updateOrder(db, buyOrder.ID, 0, 15)
				}
				if sellOrder.Quantity > 0 {
					updateOrder(db, sellOrder.ID, sellOrder.Quantity, 14)
					heap.Push(sellHeap, sellOrder)
				} else {
					updateOrder(db, sellOrder.ID, 0, 15)
				}

				matched = true
			} else {
				heap.Push(buyHeap, buyOrder)
				heap.Push(sellHeap, sellOrder)
				break
			}
		}

		if !matched {
			break
		}

		if newOrder.Quantity > 0 {
			updateOrder(db, newOrder.ID, newOrder.Quantity, 14) 
		} else {
			updateOrder(db, newOrder.ID, 0, 15) 
			break
		}
	}

	return nil
}


// Helper function
func min(a, b float64) float64 {
	if a < b {
		return a
	}
	return b
}

