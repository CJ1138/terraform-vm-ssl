# terraform-vm-ssl

Parameterised Terraform modules to create a single compute engine HTTPS server, with an SSL cert, behind a Global HTTP(S) Load Balancer following GCP best practices:

- `gcp-apis` - Enables the `compute.googleapis.com` service
- `gcp-https-load-balancer` - Creates a backend group, http health check and all the other moving parts for a Global HTTP(S) Load Balancer. Also provisions an SSL cert.
- `gcp-https-server-vm` - Provisions a single Compute Engine VM with an ephemeral external IP address, and a distinct service account. Adds the VM to an unmanaged instance group.
- `gcp-iam` - Creates the service account for the VM.
- `gcp-network` - Creates a new network / subnet, and all the required firewall rules.

# Example Usage

- Modify `CHANGEME.tfvars` to suit requirements. Example:

```
project              = "my-gcp-project"
vm_name              = "server-1"
machine_type         = "e2-small"
region               = "europe-west1"
zone                 = "europe-west1-b"
network              = "my-custom-network"
subnet               = "eu-custom-subnet"
cidr_range           = "10.0.0.0/24"
ip_name              = "blog-ipv4"
service_account_name = "server-1-vm"
domain               = "example.com"

```
- Run `$ terraform init` in project folder
- Run `$ terraform plan -var-file=CHANGEME.tfvars` to see resources expected to be created in GCP project
- Run `$ terraform apply -var-file=CHANGEME.tfvars` to provision resources
- Create A record in DNS setting, pointing to the external IPv4 address output by Terraform
# Notes

It sometimes seems to be necessary to manually enable the Compute Engine API in either the GCP console, or in gcloud with:

`$ gcloud services enable compute.googleapis.com`

Once DNS settings have propagated, SSL cert may take a short while to complete provisioning. You can check the status of this in the gcloud with:

`$ gcloud compute ssl-certificates describe CERTIFICATE_NAME --format="get(managed.domainStatus)`

Uncomment line 21 in `./tf-modules/gcp-https-server-vm/main.tf` to point to a local bash script for the VM to run at startup, to install any required packages. The provided example installs the [Cloud Monitoring Agent](https://cloud.google.com/monitoring/agent/monitoring) and nginx. 