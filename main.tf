provider "google" {
  project = var.project
}

module "gcp-https-server-vm" {
  source            = "./tf-modules/gcp-https-server-vm"
  vm_name           = var.vm_name
  zone              = var.zone
  subnet            = module.gcp-network.subnet_id
  machine_type      = var.machine_type
  server_vm_account = module.gcp-iam.vm_service_account
}

module "gcp-apis" {
  source  = "./tf-modules/gcp-apis"
  project = var.project
}

module "gcp-network" {
  source     = "./tf-modules/gcp-network"
  project    = var.project
  network    = var.network
  subnet     = var.subnet
  cidr_range = var.cidr_range
  region     = var.region
  ip_name    = var.ip_name
}

module "gcp-iam" {
  source               = "./tf-modules/gcp-iam"
  service_account_name = var.service_account_name
}

module "gcp-https-load-balancer" {
  source        = "./tf-modules/gcp-https-load-balancer"
  domain        = var.domain
  backend_group = module.gcp-https-server-vm.instance_group_id
  ip_address    = module.gcp-network.ip_address
}