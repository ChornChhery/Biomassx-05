package user

import "database/sql"

type User struct {
	ID               int
	FirstName        string `htmx:"firstName" json:"firstName" db:"first_name"`
	LastName         string `htmx:"lastName" json:"lastName" db:"last_name"`
	OrganizationName string `htmx:"organizationName" json:"organizationName" db:"organization_name"`
	Username         string `htmx:"username" json:"username" db:"username"`
	Password         string `htmx:"password" json:"password" db:"password"`
	Phone            string `htmx:"phone" json:"phone" db:"phone"`
	Email            string `htmx:"email" json:"email" db:"email"`
}

type UserDetail struct {
    ID           int            `json:"id"`
    FirstName    sql.NullString `json:"first_name"`
    LastName     sql.NullString `json:"last_name"`
    Organization sql.NullString `json:"organization_name"`
    Username     sql.NullString `json:"username"`
    Phone        sql.NullString `json:"phone"`
    Email        sql.NullString `json:"email"`
    Addresses    []Address      `json:"addresses"`
}

type Location struct {
    ID     sql.NullInt64  `json:"id"`
    EnName sql.NullString `json:"en_name"`
    ThName sql.NullString `json:"th_name"`
}

type Address struct {
    ID            sql.NullInt64  `json:"id"`
    AddressTypeID sql.NullInt64  `json:"address_type_id"`
    AddressType   Location       `json:"address_type"`
    BranchNumber  sql.NullString `json:"branch_number"`
    Street        sql.NullString `json:"street"`
    Taxnumber     sql.NullString `json:"tax_number"`
    Address       sql.NullString `json:"address"`
    PostalCode    sql.NullString `json:"postal_code"`
    Country       Location       `json:"country"`
    Province      Location       `json:"province"`
    District      Location       `json:"district"`
    Subdistrict   Location       `json:"subdistrict"`
    CreatedAt     sql.NullTime   `json:"created_at"`
}

var requestBody struct {
    AddressID int `json:"addressId"`
}

type UpdateProfileRequest struct {
	FirstName        string `json:"firstName,omitempty"`
	LastName         string `json:"lastName,omitempty"`
	OrganizationName string `json:"organizationName,omitempty"`
	Username         string `json:"username,omitempty"`
	Password         string `json:"password,omitempty"`
	Phone            string `json:"phone,omitempty"`
	Email            string `json:"email,omitempty"`
}

// UpdateProfileResponse defines the structure for the response
type UpdateProfileResponse struct {
	Success bool   `json:"success"`
	Message string `json:"message,omitempty"`
}
