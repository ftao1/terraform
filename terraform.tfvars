# terraform.tfvars
# This file defines values for the variables declared in the variables.tf file.
# The variables are then used in the main.tf file.
# DETAILS REDACTED

# Login Details
vcenter = "10.0.0.39"
#user = THIS IS NOW A TF_VAR_user
#password = THIS IS NOW A TF_VAR_password

# DC Details
datacenter = "DC-PROD"
cluster = "prod-a"
datastore = "prod-a-ds"
network = "prod-a-vm-vlan1"

# VM Details
vmtemplate = "RHEL85-Template"
vmname = "terraformRHEL85-test"
hostname = "terraformRHEL85-test"
vmnotes = "Deployed via Terraform\nOS - RHEL 8.5\nBy - FT\nDate - Mar 2022"
guestID = "rhel8_64Guest"
vcpus = "2"
memory = "4096"
dns_servers = ["8.8.8.8", "1.1.1.1"]
domain = "testlab.example.local"
gateway = "192.168.0.254"
ipaddr = "192.168.100"
mask = "24"
lastoctet = "105"
