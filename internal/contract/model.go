package contract


import (
	"database/sql"
	"time"
)

type Contract struct {
	// --- ข้อมูลภาษาอังกฤษ ---
	StandardEnName         sql.NullString
	GradeEnName            sql.NullString
	UomEn                  sql.NullString
	PackingEn              sql.NullString
	DeliveryTermEn         sql.NullString
	PodProvinceEn          sql.NullString
	PodDistrictEn          sql.NullString
	PodSubdistrictEn       sql.NullString
	DeliveryStatusEn       sql.NullString
	PaymentTermEn          sql.NullString
	PaymentStatusEn        sql.NullString
	SellerConfirmStatusEn  sql.NullString
	BuyerConfirmStatusEn   sql.NullString
	ContractStatusEn       sql.NullString
	SellerPolEn            sql.NullString
	SellerPodEn            sql.NullString
	BuyerPolEn             sql.NullString
	BuyerPodEn             sql.NullString
	SellerCountryEn        sql.NullString
	BuyerCountryEn         sql.NullString

	// --- ข้อมูลภาษาไทย ---
	StandardThName         sql.NullString
	GradeThName            sql.NullString
	UomTh                  sql.NullString
	PackingTh              sql.NullString
	DeliveryTermTh         sql.NullString
	PodProvinceTh          sql.NullString
	PodDistrictTh          sql.NullString
	PodSubdistrictTh       sql.NullString
	DeliveryStatusTh       sql.NullString
	PaymentTermTh          sql.NullString
	PaymentStatusTh        sql.NullString
	SellerConfirmStatusTh  sql.NullString
	BuyerConfirmStatusTh   sql.NullString
	ContractStatusTh       sql.NullString
	SellerPolTh            sql.NullString
	SellerPodTh            sql.NullString
	BuyerPolTh             sql.NullString
	BuyerPodTh             sql.NullString
	SellerCountryTh        sql.NullString
	BuyerCountryTh         sql.NullString

	// --- ข้อมูลอื่น ๆ ---
	ID                     int64
	ContractDate           time.Time
	Price                  float64
	Quantity               float64
	UomDescription         sql.NullString
	PackingID              sql.NullInt64
	StartDelivery          sql.NullTime
	FinishDelivery         sql.NullTime
	PaymentTermDescription sql.NullString
	SellerRemark           sql.NullString
	BuyerRemark            sql.NullString
	SellerFirstName        sql.NullString
	SellerLastName         sql.NullString
	SellerOrgName          sql.NullString
	SellerUserID           sql.NullString
	BuyerFirstName         sql.NullString
	BuyerLastName          sql.NullString
	BuyerOrgName           sql.NullString
	BuyerUserID            sql.NullString
	StandardID             sql.NullInt64
	GradeID                sql.NullInt64

	ProductID      int
	ProductEnName sql.NullString
	ProductThName sql.NullString

	ContractTypeID     int
	ContractTypeEnName sql.NullString
	ContractTypeThName sql.NullString
	
	MarketspaceEnName         sql.NullString
MarketspaceThName         sql.NullString
MarketEnName              sql.NullString
MarketThName              sql.NullString
SubmarketEnName           sql.NullString
SubmarketThName           sql.NullString

CurrencyEnName 			  sql.NullString
CurrencyThName 			  sql.NullString

}


type ContractUserDetails struct {
	// --- ข้อมูลภาษาอังกฤษ ---
	StandardEnName         sql.NullString
	GradeEnName            sql.NullString
	UomEn                  sql.NullString
	PackingEn              sql.NullString
	DeliveryTermEn         sql.NullString
	PodProvinceEn          sql.NullString
	PodDistrictEn          sql.NullString
	PodSubdistrictEn       sql.NullString
	DeliveryStatusEn       sql.NullString
	PaymentTermEn          sql.NullString
	PaymentStatusEn        sql.NullString
	SellerConfirmStatusEn  sql.NullString
	BuyerConfirmStatusEn   sql.NullString
	ContractStatusEn       sql.NullString
	SellerPolEn            sql.NullString
	SellerPodEn            sql.NullString
	BuyerPolEn             sql.NullString
	BuyerPodEn             sql.NullString
	SellerCountryEn        sql.NullString
	BuyerCountryEn         sql.NullString

	// --- ข้อมูลภาษาไทย ---
	StandardThName         sql.NullString
	GradeThName            sql.NullString
	UomTh                  sql.NullString
	PackingTh              sql.NullString
	DeliveryTermTh         sql.NullString
	PodProvinceTh          sql.NullString
	PodDistrictTh          sql.NullString
	PodSubdistrictTh       sql.NullString
	DeliveryStatusTh       sql.NullString
	PaymentTermTh          sql.NullString
	PaymentStatusTh        sql.NullString
	SellerConfirmStatusTh  sql.NullString
	BuyerConfirmStatusTh   sql.NullString
	ContractStatusTh       sql.NullString
	SellerPolTh            sql.NullString
	SellerPodTh            sql.NullString
	BuyerPolTh             sql.NullString
	BuyerPodTh             sql.NullString
	SellerCountryTh        sql.NullString
	BuyerCountryTh         sql.NullString
	
	// --- ข้อมูลอื่น ๆ ---
	ID                     int64
	ContractDate           time.Time
	Price                  float64
	Quantity               float64
	UomDescription         sql.NullString
	PackingID              sql.NullInt64
	StartDelivery          sql.NullTime
	FinishDelivery         sql.NullTime
	PaymentTermDescription sql.NullString
	SellerRemark           sql.NullString
	BuyerRemark            sql.NullString
	SellerFirstName        sql.NullString
	SellerLastName         sql.NullString
	SellerOrgName          sql.NullString
	SellerUserID           sql.NullInt64
	BuyerFirstName         sql.NullString
	BuyerLastName          sql.NullString
	BuyerOrgName           sql.NullString
	BuyerUserID            sql.NullInt64
	StandardID             sql.NullInt64
	GradeID                sql.NullInt64

	ProductID      int
ProductEnName sql.NullString
ProductThName sql.NullString

ContractTypeID     int
ContractTypeEnName sql.NullString
ContractTypeThName sql.NullString

MarketspaceEnName         sql.NullString
MarketspaceThName         sql.NullString
MarketEnName              sql.NullString
MarketThName              sql.NullString
SubmarketEnName           sql.NullString
SubmarketThName           sql.NullString

CurrencyEnName 			  sql.NullString
CurrencyThName 			  sql.NullString

}


type UpdateContractRequest struct {
    ContractID int64 `json:"contract_id"`
    UserID     int64 `json:"user_id"`
}


type User struct {
    Email sql.NullString
    Phone sql.NullString
}

type Address struct {
    AddressTypeID sql.NullInt64
    BranchNumber  sql.NullString
    CountryID     sql.NullInt64
    ProvinceID    sql.NullInt64
    DistrictID    sql.NullInt64
    SubdistrictID sql.NullInt64
    Street        sql.NullString
    Address       sql.NullString
    PostalCode    sql.NullString
    ProvinceEN    sql.NullString
    ProvinceTH    sql.NullString
    DistrictEN    sql.NullString
    DistrictTH    sql.NullString
    SubdistrictEN sql.NullString
    SubdistrictTH sql.NullString
    CountryEN     sql.NullString
    CountryTH     sql.NullString
}