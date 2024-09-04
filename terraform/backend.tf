terraform {
    backend "gcs" {
        credentials = "terraform_credentials.json"
        bucket = "cluster-tf-state-101"
    }
}