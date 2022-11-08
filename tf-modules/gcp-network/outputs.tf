output "subnet_id" {
  description = "ID for the created subnet."
  value       = google_compute_subnetwork.vpc_subnet.id
}

output "ip_address" {
  description = "Reserved static IP address"
  value       = google_compute_global_address.static_ip.address
}