A modular Terraform config to:

- Create a new Compute Engine VM
- Create and assign a service account to the VM (with essentially zero permissions)
- Create a new network with one custom mode subnet
- Reserve a static IPv4 address
- Provision an SSL cert
- Create an external 