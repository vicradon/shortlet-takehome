package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"time"
)

func currentTimeHandler(w http.ResponseWriter, r *http.Request) {
	response := map[string]string{
		"current_time": time.Now().Format("15:04:05"),
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(response)
}

func main() {
	http.HandleFunc("/", currentTimeHandler)

	fmt.Println("Server listening on port 4500")

	err := http.ListenAndServe(":4500", nil)

	if err != nil {
		fmt.Println("Error starting server:", err)
	}
}
