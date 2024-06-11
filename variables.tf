# Variables
# Declare variables here with optional description.
# Variable values are stored in the terraform.tfvars file.
#

### VSphere Declarations

variable "vcenter" {
    description = "Name of VCenter"
    default = "10.0.0.39"
}

variable "user" {
    description = "Name of VS User"
    type = string
    sensitive = true
}

variable "password" {
    description = "Password of VS User"
    type = string
    sensitive = true
}

variable "datacenter" {
    description = "Name of Datacenter"
    default = "DC-PROD"
}

variable "cluster" {
    description = "Name of Cluster"
    default = "prod-a"
}

variable "datastore" {
    description = "Name of Datastore"
    default = "prod-a-ds"
}

variable "network" {
    description = "Name of Network"
    default = "prod-a-vm-vlan1"
}

### VM Declarations

variable "vmtemplate" {
    description = "VM Template"
}

variable "dns_servers" {
    description = "DNS Servers"
}

variable "domain" {
    description = "DNS domain"
}

variable "vmname" {
    description = "Name of VM"
}

variable "hostname" {
    description = "Hostname of VM"
}

variable "vmnotes" {
    description = "Notes of VM"
}

variable "guestID" {
    description = "Guest ID of VM"
}

variable "vcpus" {
    description = "Number of VM vCPUs"
}

variable "memory" {
    description = "Amount of VM Memory"
}

variable "gateway" {
    description = "Gateway of VM"
}

variable "ipaddr" {
    description = "IP of VM"
}

variable "mask" {
    description = "Netmask of VM"
}

variable "lastoctet" {
    description = "Last Octet of VM IP"
}
