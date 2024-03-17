resource "google_compute_target_http_proxy" "hw-proxy" {
  name    = "hello-world-test-${local.suffix}"
  url_map = google_compute_url_map.hw-url-map.id
}

data "google_storage_bucket_object" "cert" {
  name   = "cert.crt"
  bucket = google_storage_bucket.hw-bucket.id
}

data "google_storage_bucket_object" "key" {
  name   = "private.key"
  bucket = google_storage_bucket.hw-bucket.id
}

resource "google_compute_url_map" "hw-url-map" {
  name            = "hw-url-map-${local.suffix}"
  description     = "a description"
  default_service = google_compute_backend_service.hw-backend.id
}

resource "google_compute_backend_service" "hw-backend" {
  name          = "hw-backend-service-${local.suffix}"
  port_name     = "http"
  protocol      = "HTTP"
  timeout_sec   = 10
  health_checks = [google_compute_http_health_check.hw-healthcheck.id]
  backend {
    group = google_compute_instance_group.hw-instance-group.id
  }
}

resource "google_compute_http_health_check" "hw-healthcheck" {
  name               = "hw-http-health-check-${local.suffix}"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
}

resource "google_compute_global_address" "hw-global-ip" {
  name = "hw-global-ip-${local.suffix}"
}

resource "google_compute_global_forwarding_rule" "hw-forwarding-rule" {
  name                  = "hw-forwarding--${local.suffix}"
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "80"
  target                = google_compute_target_http_proxy.hw-proxy.id
  ip_address            = google_compute_global_address.hw-global-ip.id
}

