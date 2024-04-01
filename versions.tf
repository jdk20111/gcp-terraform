terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.22.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "5.22.0"
    }
  }
}

# provider "google" {
#   # Configuration options
# }

# provider "random" {
#   # Configuration options
# }
