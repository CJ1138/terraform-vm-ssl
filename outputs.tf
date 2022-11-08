output "subnet_id" {
  description = "Returned name of the created subnet."
  value       = module.gcp-network.subnet_id
}

output "static_ip_address" {
  description = "Static external IP address reserved for the server."
  value       = module.gcp-network.ip_address
}

