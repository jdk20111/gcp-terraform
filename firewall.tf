resource "google_compute_firewall" "hw-allow_http" {
  name    = "hw-allow-http-${local.suffix}"
  network = "default" # Update this with your network name if it's not the default network

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = [
    "73.3.152.67/32",
    "130.211.0.0/22", # Google Cloud HTTP/HTTPS Load Balancer IP range
    "35.191.0.0/16",  # Google Cloud Armor IP range
  ]
  target_tags = ["hw-http-server"] # Tag applied to your instances
}
