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

#builds a gcp compute instance 
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  #
  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }
}
