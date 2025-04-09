package matching

import (
	"database/sql"
	"time"
)


type Order struct {
	ID                int
	UserID            int
	MarketspaceID     int  
	MarketID          int
	SubMarketID       int
	OrderTypeID       int
	MatchingTypeID    int
	ContractTypeID    int
	ProductID         int
	QualityID         int
	Price             float64
	Currencies        int
	Quantity          float64
	UOMID             int  
	PackingID         int  
	PaymentTermID     int 
	DeliveryTermID    int
	CountryID 	   int
	PortOfLoadingID      int  
    PortOfDischargeID    int  
	ProvinceID        int
	DistrictID        int
	SubDistrictID     int
	FirstDeliveryDate time.Time
	LastDeliveryDate  time.Time
	CreatedAt         time.Time
	UpdatedAt         time.Time
	Remark            sql.NullString
}

type MaxHeap []*Order
type MinHeap []*Order

func (h MaxHeap) Len() int           { return len(h) }
func (h MinHeap) Len() int           { return len(h) }

// MaxHeap: จัดเรียงตามราคาสูงสุด และในกรณีที่ราคาเท่ากันจัดเรียงตามเวลาที่สร้าง (LIFO)
func (h MaxHeap) Less(i, j int) bool {
	if h[i].Price == h[j].Price {
		return h[i].CreatedAt.Before(h[j].CreatedAt) // จัดเรียงตามเวลา (เก่าก่อน)
	}
	return h[i].Price > h[j].Price
}

// MinHeap: จัดเรียงตามราคาต่ำสุด และในกรณีที่ราคาเท่ากันจัดเรียงตามเวลาที่สร้าง (FIFO)
func (h MinHeap) Less(i, j int) bool {
	if h[i].Price == h[j].Price {
		return h[i].CreatedAt.Before(h[j].CreatedAt) // จัดเรียงตามเวลา (เก่าก่อน)
	}
	return h[i].Price < h[j].Price
}

func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(*Order))
}
func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(*Order))
}

func (h *MaxHeap) Pop() interface{} {
	old := *h
	n := len(old)
	item := old[n-1]
	*h = old[0 : n-1]
	return item
}

func (h *MinHeap) Pop() interface{} {
	old := *h
	n := len(old)
	item := old[n-1]
	*h = old[0 : n-1]
	return item
}
