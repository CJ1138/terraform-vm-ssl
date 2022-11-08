output "vm_service_account" {
  description = "Service account created for the VM"
  value       = google_service_account.server_vm_account.email
}