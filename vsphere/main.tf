# There is extensive use of variables prefixed with 'var.'
# The variables are defined in variables and terraform.tfvars files.

# Configure the VMware vSphere Provider
provider "vsphere" {
  vsphere_server       = var.vcenter
  user                 = var.user
  password             = var.password
  allow_unverified_ssl = true
}


# Data for Resources
data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_compute_cluster" "cluster" {
  name          = var.cluster
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vmtemplate
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Build a VM
resource "vsphere_virtual_machine" "vm" {
  count            = 1
  name             = "${var.vmname}-${count.index + 1}"
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  boot_delay       = 10000
  firmware         = "bios"
  annotation       = "${var.vmnotes}.\n\nTEMPLATE USED ==> ${var.vmtemplate}\n\nHOSTNAME ==> ${var.hostname}-${count.index + 1}"

  num_cpus                   = var.vcpus
  memory                     = var.memory
  guest_id                   = var.guestID
  wait_for_guest_net_timeout = "0"

  scsi_type = data.vsphere_virtual_machine.template.scsi_type

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }

  disk {
    label            = "disk0"
    size             = data.vsphere_virtual_machine.template.disks.0.size
    eagerly_scrub    = data.vsphere_virtual_machine.template.disks.0.eagerly_scrub
    thin_provisioned = data.vsphere_virtual_machine.template.disks.0.thin_provisioned
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "${var.hostname}-${count.index + 1}"
        domain    = var.domain
      }

      network_interface {
        ipv4_address = "${var.ipaddr}.${var.lastoctet + count.index}"
        ipv4_netmask = var.mask
      }

      ipv4_gateway    = var.gateway
      dns_server_list = var.dns_servers
    }
  }
}
