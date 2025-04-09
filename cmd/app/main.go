package main

import (
	"context"
	"log"
	"net/http"
	"os"
	"os/signal"
	"time"

	"github.com/gorilla/mux"
	"github.com/thongsoi/biomassx-05/database"
	"github.com/thongsoi/biomassx-05/internal/contract"
	"github.com/thongsoi/biomassx-05/internal/middleware"
	"github.com/thongsoi/biomassx-05/internal/order"
	"github.com/thongsoi/biomassx-05/internal/user"
)

func main() {
	// Initialize the database
	if err := database.InitDB(); err != nil {
		log.Fatal("Failed to initialize database:", err)
	}
	defer func() {
		if err := database.CloseDB(); err != nil {
			log.Println("Failed to close the database:", err)
		}
	}()

	r := mux.NewRouter()

	// Middleware to log requests
	r.Use(loggingMiddleware)

	// Static files
	r.PathPrefix("/static/").Handler(http.StripPrefix("/static/", http.FileServer(http.Dir("static"))))

	// Auth routes
	r.HandleFunc("/", middleware.IndexHandler).Methods("GET")
	r.HandleFunc("/about", middleware.AboutHandler).Methods("GET")
	r.HandleFunc("/faqs", middleware.FaqsHandler).Methods("GET")
	r.HandleFunc("/services", middleware.ServiceHandler).Methods("GET")
	r.HandleFunc("/productspage", middleware.ProductHandler).Methods("GET")
	r.HandleFunc("/markets", middleware.MarketHandler).Methods("GET")
	r.HandleFunc("/contact", middleware.ContactHandler).Methods("GET")
	r.HandleFunc("/login", middleware.LoginHandler).Methods("GET", "POST")
	r.HandleFunc("/logout", middleware.LogoutHandler).Methods("GET", "POST")
	r.HandleFunc("/register", user.RegisterHandler).Methods("GET", "POST")

	r.HandleFunc("/api/delete-address", user.HandleDeleteAddress).Methods("GET", "POST")
	db := database.GetDB()
	r.HandleFunc("/api/update-profile", user.UpdateProfileHandler(db)).Methods("POST")
	// Register address-related routes

	//profile
	r.HandleFunc("/api/add-address", user.AddAddressHandler).Methods("GET", "POST")
	r.HandleFunc("/api/address-types", user.GetAddressTypesHandler).Methods("GET", "POST")
	r.HandleFunc("/api/countries", user.GetCountriesHandler).Methods("GET", "POST")
	r.HandleFunc("/api/provinces", user.GetProvincesHandler).Methods("GET", "POST")
	r.HandleFunc("/api/districts", user.GetDistrictsHandler).Methods("GET", "POST")
	r.HandleFunc("/api/subdistricts", user.GetSubdistrictsHandler).Methods("GET", "POST")

	//api orderpage handler
	r.HandleFunc("/submarkets", order.SubmarketHandler).Methods("GET")
	r.HandleFunc("/products", order.ProductHandler).Methods("GET")
	r.HandleFunc("/qualities", order.QualityHandler).Methods("GET")
	r.HandleFunc("/district", order.DistrictHandler).Methods("GET")
	r.HandleFunc("/subdistrict", order.SubdistrictHandler).Methods("GET")
	r.HandleFunc("/payment", order.PaymentTermHandler).Methods("GET")
	r.HandleFunc("/delivery", order.DeliveryHandler).Methods("GET")

	//api contract
	r.HandleFunc("/download-pdfEn/{id}", contract.DownloadContractPDFHandlerEn).Methods("GET")
	r.HandleFunc("/download-pdfTh/{id}", contract.DownloadContractPDFHandlerTh).Methods("GET")

	r.HandleFunc("/api/update-address", user.UpdateAddressHandler).Methods("GET", "POST")
	r.HandleFunc("/api/get-address", user.GetAddressHandler).Methods("GET", "POST")

	// Protected routes
	r.Handle("/dashboard", middleware.AuthMiddleware(http.HandlerFunc(middleware.DashboardHandler))).Methods("GET")
	r.Handle("/order", middleware.AuthMiddleware(http.HandlerFunc(order.OrderHandler))).Methods("GET", "POST")
	r.Handle("/contract", middleware.AuthMiddleware(http.HandlerFunc(contract.ContractHandler))).Methods("GET")
	r.Handle("/contract/{id:[0-9]+}", middleware.AuthMiddleware(http.HandlerFunc(contract.ContractDetailHandler))).Methods("GET")
	r.Handle("/sign", middleware.AuthMiddleware(http.HandlerFunc(contract.UpdateContractStatusHandler))).Methods("POST")
	r.Handle("/profile", middleware.AuthMiddleware(http.HandlerFunc(user.ProfileHandler))).Methods("GET", "POST")
	r.Handle("/assets", middleware.AuthMiddleware(http.HandlerFunc(middleware.AssetsHandler))).Methods("GET")

	// HTTP Server configuration
	srv := &http.Server{
		Handler:      r,
		Addr:         ":8000",
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
		IdleTimeout:  60 * time.Second,
	}

	// Channel for interrupt signal
	idleConnsClosed := make(chan struct{})

	// Graceful shutdown
	go func() {
		sigint := make(chan os.Signal, 1)
		signal.Notify(sigint, os.Interrupt)
		<-sigint

		// Gracefully shutdown the server
		if err := srv.Shutdown(context.Background()); err != nil {
			log.Printf("HTTP server Shutdown: %v", err)
		}
		close(idleConnsClosed)
	}()

	log.Println("Server started on :8000")
	if err := srv.ListenAndServe(); err != http.ErrServerClosed {
		log.Fatalf("ListenAndServe(): %v", err)
	}

	<-idleConnsClosed
	log.Println("Server shutdown completed")
}

// Simple logging middleware
func loggingMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		log.Printf("%s %s %s", r.Method, r.RequestURI, r.RemoteAddr)
		next.ServeHTTP(w, r)
	})
}
