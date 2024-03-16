#builds a gcp compute instance
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance-${var.suffix}"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }
}
