# Shortlet Takehome

Take home assessment for Shortlet Cloud Engineering role. Requirement is a simple dockerized web API that returns the current time in JSON format.

## Running the application

You can run the application directly on your local machine or using Docker.

### Running the application locally

1. Clone the repo
2. Run `go run main.go`
3. Open `http://localhost:4500/` in your browser

### Running via Docker

1. Clone the repo
2. Run `docker build -t shortlet-takehome .`
3. Run `docker run --rm -p 4500:4500 shortlet-takehome`
4. Open `http://localhost:4500/` in your browser

## Testing

The application has a single unit test that verifies that the API returns the current time in JSON format. You can run the tests by running `go test`

## Running without remote backend

1. Delete the terraform/backend.tf
2. Run terraform init
3.
