#builds a gcp compute instance
resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance-${local.suffix}"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  tags = ["hw-http-server"]
  #
  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }
  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y apache2
    systemctl start apache2
    systemctl enable apache2
  EOF
}

resource "google_compute_instance_group" "hw-instance-group" {
  name        = "hw-instance-group-${local.suffix}"
  description = "Terraform test instance group"
  instances = [
    google_compute_instance.vm_instance.id
  ]
  named_port {
    name = "http"
    port = "80"
  }
  zone = "us-central1-c"
}
