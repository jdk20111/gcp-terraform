#google provider config that specifies project and default region/zone
provider "google" {
  project = "ivory-team-416601"
  region  = "us-central1"
  zone    = "us-central1-c"
}

#build a random id resrouce that creates a random id
resource "random_id" "suffix" {
  byte_length = 2
}

locals {
  suffix = random_id.suffix.hex
}