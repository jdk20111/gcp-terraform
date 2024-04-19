terraform {
  backend "gcs" {
    bucket = "tf-backend-bucket-cff4"
    prefix = "terraform/state"
  }
}
