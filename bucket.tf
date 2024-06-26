resource "google_storage_bucket" "hw-bucket" {
  name     = "hw-bucket-${local.suffix}"
  location = "us-central1"
}

resource "google_storage_bucket" "tf-backend-bucket" {
  name     = "tf-backend-bucket-${local.suffix}"
  location = var.region
}