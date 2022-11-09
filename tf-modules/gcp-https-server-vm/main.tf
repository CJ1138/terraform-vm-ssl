resource "google_compute_instance" "wp-server-vm" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  tags = ["http-server", "https-server", "allow-health-check"]

  boot_disk {
    initialize_params {
      size  = 10
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = var.subnet
    access_config {}
  }

  # Uncomment to add startup script from local file. Example:
  #metadata_startup_script = "${file("./scripts/install-wp.sh")}"

  service_account {
    email  = var.server_vm_account
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_instance_group" "webserver_group" {
  name        = "webserver-group"
  description = "Unmanaged instance group with one HTTP(S) server VM"
  zone        = var.zone
  instances = [
    google_compute_instance.wp-server-vm.id
  ]
  named_port {
    name = "http"
    port = "80"
  }
}