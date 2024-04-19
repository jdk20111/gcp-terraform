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
  labels = {
    goog-ops-agent-policy = "v2-x86-template-1-2-0"
  }
  metadata = {
    enable-guest-attributes = "TRUE"
    enable-osconfig         = "TRUE"
  }
  service_account {
    email  = google_service_account.test_service_account.email
    scopes = ["cloud-platform"]
  }
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

# resource "google_compute_instance_group" "hw-instance-group" {
#   name        = "hw-instance-group-${local.suffix}"
#   description = "Terraform test instance group"
#   instances = [
#     google_compute_instance.vm_instance.id,
#     google_compute_instance.vm_instance2.id
#   ]
#   named_port {
#     name = "http"
#     port = "80"
#   }
#   zone = "us-central1-c"
# }

resource "google_service_account" "test_service_account" {
  account_id   = "test-service-account-id-${local.suffix}"
  display_name = "Test Service Account"
}

#builds a gcp compute instance
resource "google_compute_instance" "vm_instance2" {
  name         = "terraform-instance2-${local.suffix}"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  tags = ["hw-http-server"]
  labels = {
    goog-ops-agent-policy = "v2-x86-template-1-2-0"
  }
  metadata = {
    enable-guest-attributes = "TRUE"
    enable-osconfig         = "TRUE"
  }
  service_account {
    email  = google_service_account.test_service_account.email
    scopes = ["cloud-platform"]
  }
  #
  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }
}