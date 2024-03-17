resource "google_storage_bucket" "hw-bucket" {
  name     = "hw-bucket-${local.suffix}"
  location = "us-central1"
}
