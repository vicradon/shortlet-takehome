package main

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"
	"time"
)

func TestCurrentTimeHandler(t *testing.T) {
	req, err := http.NewRequest("GET", "/", nil)
	if err != nil {
		t.Fatalf("Could not create request: %v", err)
	}

	rr := httptest.NewRecorder()

	currentTimeHandler(rr, req)

	if status := rr.Code; status != http.StatusOK {
		t.Errorf("handler returned wrong status code: got %v want %v",
			status, http.StatusOK)
	}

	if contentType := rr.Header().Get("Content-Type"); contentType != "application/json" {
		t.Errorf("handler returned wrong content type: got %v want %v",
			contentType, "application/json")
	}

	var response map[string]string
	err = json.NewDecoder(rr.Body).Decode(&response)
	if err != nil {
		t.Fatalf("Could not decode response: %v", err)
	}

	currentTime, ok := response["current_time"]
	if !ok {
		t.Fatalf("Response JSON does not contain 'current_time' key")
	}

	_, err = time.Parse("15:04:05", currentTime)
	if err != nil {
		t.Errorf("Time format is incorrect: got %v", currentTime)
	}
}
