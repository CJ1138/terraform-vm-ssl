output "static_ip_address" {
  description = "Static external IP address reserved for the server."
  value       = module.gcp-network.ip_address
}

