terraform {
  required_providers {
   
    talos = {
      source  = "siderolabs/talos"
      version = ">=0.7.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
    linode = {
      source = "linode/linode"
      version = "2.31.1"
    }
  }
}

locals {
  create = var.create ? 1 : 0
}
resource "linode_instance" "this" {
  count = local.create

  label = var.name
  region = var.region
  type = var.instance_type
  private_ip = true
  disk_encryption = "disabled"
  tags = var.tags
  watchdog_enabled = true
  metadata {
    user_data = base64encode(var.metadata_options)
  }
  
}

resource "linode_instance_config" "this_config" {
  count = local.create

  linode_id = linode_instance.this[count.index].id
  booted = true
  label = "talos"
  kernel = "linode/direct-disk"
  root_device = "/dev/sda"
  helpers {
      distro             = false
      modules_dep        = false
      network            = false
      updatedb_disabled  = false
      devtmpfs_automount = false
    }
  
  device {
    device_name = "sda"
    disk_id = linode_instance_disk.this_disk_boot.id
  }

  device {
    device_name = "sdb"
    disk_id = linode_instance_disk.this_disk_swap.id
  }
  # interface {
  #   label = "talos"
  #   purpose = "public"
  # }
}

# resource "linode_rdns" "controlplane_rdns" {
#   depends_on = [ linode_instance.this ]
#   count = local.create

#   address = linode_instance.this[count.index].ip_address
#   rdns = "${replace(linode_instance.this[count.index].ip_address,".","-")}.ip.linodeusercontent.com"

#   }

resource "linode_instance_disk" "this_disk_boot" {
  linode_id = linode_instance.this[0].id
  label = "talos"
  filesystem = "raw"
  image=var.image
  size = 8000

}

resource "linode_instance_disk" "this_disk_swap" {

  linode_id = linode_instance.this[0].id
  label = "swap"
  filesystem = "swap"
  size = 512
}

