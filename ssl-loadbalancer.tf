# resource "google_compute_target_https_proxy" "hw-ssl-proxy" {
#   name              = "hw-ssl-proxy-${local.suffix}"
#   url_map           = google_compute_url_map.hw-url-map.id
#   ssl_certificates  = [google_compute_ssl_certificate.hw-cert.id]
#   server_tls_policy = google_network_security_server_tls_policy.hw-tls-policy.id
# }

# resource "google_compute_ssl_certificate" "hw-cert" {
#   name        = "hw-cert-${local.suffix}"
#   private_key = file("./files/domain2.key")
#   certificate = file("./files/domain2.crt")
# }

# resource "google_compute_global_forwarding_rule" "hw-forwarding-rule-ssl" {
#   name                  = "hw-ssl-forwarding-${local.suffix}"
#   ip_protocol           = "TCP"
#   load_balancing_scheme = "EXTERNAL"
#   port_range            = "443"
#   target                = google_compute_target_https_proxy.hw-ssl-proxy.id
#   ip_address            = google_compute_global_address.hw-global-ip.id
# }

# #Used Windows Crypt LE to create cert:  le64 --key account.key --email "jdk201@yahoo.com" --csr domain.csr --csr-key domain.key --crt domain.crt --generate-missing --domains "gcp-test.btkills.com" --handle-as dns --live -legacy

# resource "google_certificate_manager_trust_config" "hw-trust-config" {
#   project     = var.project_id
#   provider    = google-beta
#   name        = "hw-trust-config-${local.suffix}"
#   description = "sample trust config description"
#   location    = "global"

#   trust_stores {
#     trust_anchors {
#       pem_certificate = file("./files/mtls_certs/root.cert")
#     }
#     intermediate_cas {
#       pem_certificate = file("./files/mtls_certs/int.cert")
#     }
#   }

#   labels = {
#     foo = "bar"
#   }
# }

# resource "google_network_security_server_tls_policy" "hw-tls-policy" {
#   provider    = google-beta
#   project     = var.project_id
#   name        = "hw-tls-policy-${local.suffix}"
#   location    = "global"
#   description = "TLS Policy for mTLS"
#   allow_open  = "false"

#   mtls_policy {
#     client_validation_trust_config = google_certificate_manager_trust_config.hw-trust-config.id
#     client_validation_mode         = "REJECT_INVALID"
#   }
# }
