resource "google_service_account" "server_vm_account" {
  account_id   = var.service_account_name
  display_name = "Server VM Service Account"
}