variable "vm_name" {
  description = "The name of the VM"
  type        = string
}

variable "machine_type" {
  description = "Google Compute Engine machine type"
  type        = string
}

variable "zone" {
  description = "Geographical zone in which to create the VM (dependent on subnet zone)."
  type        = string
}

variable "subnet" {
  description = "Subnet in which to create the VM (dependent on geographical zone)."
  type        = string
}

variable "server_vm_account" {
  description = "Service account to be used by the VM"
  type        = string
}