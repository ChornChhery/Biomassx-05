package order

import "time"

type Marketspace struct {
	ID     int    // db: id
	EnName string // db: en_name
	ThName string // db: th_name

}

type Market struct {
	ID     int    // db: id
	EnName string // db: en_name
	ThName string // db: th_name

}
type Submarket struct {
	ID     int    // db: id
	EnName string // db: en_name
	ThName string // db: th_name

}

type OrderType struct {
	ID     int    // db: id
	EnName string // db: en_name
	ThName string // db: th_name
}

type MatchingType struct {
	ID     int    // db: id
	EnName string // db: en_name
	ThName string // db: th_name

}

type ContractType struct {
	ID     int    // db: id
	EnName string // db: en_name
	ThName string

}

type ProductId struct {
	ID     int    // db: id
	EnName string // db: en_name

}

type QualityId struct {
	ID     int    // db: id
	EnName string // db: en_name

}

type Currency struct {
	ID     int    // db: id
	Code string // db: en_name
}

type Price struct {
	ID     int    // db: id
	EnName string // db: en_name

}
type Uom_id struct {
	ID     int    // db: id
	EnName string // db: en_name
	ThName string

}

type PackingID struct {
	ID     int    // db: id
	EnName string // db: en_name
	ThName string
}

type Payment struct {
	ID     int    // db: id
	EnName string // db: en_name
	ThName string
}

type Country struct {
	ID     int    // db: id
	EnName string // db: en_name
	ThName string
}

type Delivery struct {
	ID     int    // db: id
	EnName string // db: en_name
	ThName string
}

type Portofloading struct {
	ID     int    // db: id
	EnName string // db: en_name
	ThName string
}


type Portofdischarge struct {
	ID     int    // db: id
	EnName string // db: en_name
	ThName string
}

type Province struct {
    ID     int
    EnName string
	ThName string
}

type District struct {
	ID     int    // db: id
	EnName string // db: en_name
	ThName string
}

type Subdistrict struct {
	ID     int    // db: id
	EnName string // db: en_name
	ThName string
}

type FirstDeliveryDate struct {
	ID     int    // db: id
	EnName string // db: en_name
}
type LastDeliveryDate struct {
	ID     int    // db: id
	EnName string // db: en_name
}

type Remark struct {
	ID     int    // db: id
	EnName string // db: en_name
}

type CreatedAt struct {
	ID     int    // db: id
	EnName string // db: en_name
}

type UpdatedAt struct {
	ID     int    // db: id
	EnName string // db: en_name
}

type StatusId struct {
	ID     int    // db: id
	EnName string // db: en_name
}



type Order struct {
	UserID             int       `json:"user_id"`
	MarketspaceID      int       `json:"marketspaceID"`
	MarketID           int       `json:"marketID"`
	SubmarketID        int       `json:"submarketID"`
	OrderTypeID        int       `json:"orderTypeID"`
	MatchingTypeID     int       `json:"matchingTypeID"`
	ContractTypeID     int       `json:"contractTypeID"`
	ProductID          int       `json:"productID"`
	QualityID          int       `json:"quality_id"`
	Price              float64   `json:"price"`
	Currencies         int       `json:"currency_id"`
	Quantity           float64   `json:"quantity"`
	UOMID              int       `json:"uom_id"`
	PackingID          int       `json:"packing_id"`
	PaymentTermID      int       `json:"payment_term_id"`
	DeliveryTermID     int       `json:"delivery_term_id"`
	CountryIDs          int      `json:"country_id"`
	PortofloadingID    int       `json:"port_of_loading_id"`
	PortofdischargeID  int       `json:"port_of_discharge_id"`
	ProvinceID         int       `json:"province_id"`
	DistrictID         int       `json:"district_id"`
	SubdistrictID      int       `json:"subdistrict_id"`
	FirstDeliveryDate  time.Time `json:"first_delivery_date"`
	LastDeliveryDate   time.Time `json:"last_delivery_date"`
	Remark             string    `json:"remark"`
	StatusID           int       `json:"status_id"`
}

type Product struct {
    ID     int
    EnName string
	ThName string
}

type Quality struct {
    ID         int
    StandardID string
    GradeID    string
}