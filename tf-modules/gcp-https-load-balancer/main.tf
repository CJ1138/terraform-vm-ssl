resource "google_compute_managed_ssl_certificate" "certificate" {
  name = "vm-ssl-cert"
  managed {
    domains = [var.domain]
  }
}

resource "google_compute_health_check" "default" {
  name = "tcp-health-check"

  timeout_sec        = 1
  check_interval_sec = 1

  tcp_health_check {
    port = "80"
  }
}

resource "google_compute_backend_service" "default" {
  name                  = "backend-service"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL"
  enable_cdn            = true
  health_checks         = [google_compute_health_check.default.id]
  backend {
    group           = var.backend_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

resource "google_compute_url_map" "https-url-map" {
  name            = "https-url-map"
  description     = "Load Balancer https URL map"
  default_service = google_compute_backend_service.default.id
}

resource "google_compute_target_https_proxy" "https-proxy" {
  name             = "https-proxy"
  url_map          = google_compute_url_map.https-url-map.id
  ssl_certificates = [google_compute_managed_ssl_certificate.certificate.id]
}

resource "google_compute_url_map" "http-redirect" {
  name = "http-redirect"

  default_url_redirect {
    redirect_response_code = "MOVED_PERMANENTLY_DEFAULT"
    strip_query            = false
    https_redirect         = true
  }
}

resource "google_compute_target_http_proxy" "http-redirect" {
  name    = "http-redirect"
  url_map = google_compute_url_map.http-redirect.self_link
}

resource "google_compute_global_forwarding_rule" "http-redirect" {
  name       = "http-redirect"
  target     = google_compute_target_http_proxy.http-redirect.self_link
  ip_address = var.ip_address
  port_range = "80"
}

resource "google_compute_global_forwarding_rule" "https" {
  name                  = "ssl-proxy-forwarding-rule"
  provider              = google
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL"
  port_range            = "443"
  target                = google_compute_target_https_proxy.https-proxy.id
  ip_address            = var.ip_address
}