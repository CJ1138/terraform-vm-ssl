variable "domain" {
  description = "Domain name to point to the load balancer's IP address"
  type        = string
}

variable "backend_group" {
  description = "Instance group for the backend service"
  type        = string
}

variable "ip_address" {
  description = "Static IP address for the load balancer"
  type        = string
}