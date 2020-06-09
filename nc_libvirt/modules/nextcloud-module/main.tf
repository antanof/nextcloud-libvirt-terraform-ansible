locals {
  servers = {
    for s in range(var.server_count) : "${var.server_name}-${var.machine_name}-${s}" => {
        dd     = var.disks_enabled["${s}"]
        ddsize = var.rootdiskBytes
        cpu    = var.cpu
        mem    = var.memoryMB
        name   = "${var.server_name}-${var.machine_name}-${s}"
        fqdn   = "${var.server_name}-${var.machine_name}-${s}.${var.tld}"
        osdisk = "${var.server_name}-${var.machine_name}-${s}-os.qcow2"
        pname  = var.server_name
        cinit  = "${var.server_name}-${var.machine_name}-${s}-commoninit.iso"
        sshkey  = var.ssh_key_path
        user = var.user
        index  = s
        }
  }
  ansible_grp = "${var.tld}_${var.machine_name}"
}

data "template_file" "user_data" {
  template = file("${path.root}/cloud_init.tpl")
  for_each = local.servers
  vars     = {
            hostname       = lookup(each.value, "name", "*")
            fqdn           = lookup(each.value, "fqdn", "*")
            user           = var.user
            first_packages = jsonencode(var.first_packages)
            ssh_public_key = var.ssh_public_key
            dd_enabled     = lookup(each.value, "dd", "*")
  }
}

data "template_file" "network_config" {
  for_each = local.servers
  template = file("${path.root}/network_config_dhcp.cfg")
}

resource "libvirt_cloudinit_disk" "commoninit" {
  for_each = local.servers
  name           = lookup(each.value, "cinit", "*")
  pool           = "default"
  user_data      = data.template_file.user_data[each.key].rendered
  network_config = data.template_file.network_config[each.key].rendered
}

resource "libvirt_volume" "server-os" {
  for_each = local.servers
  name     = lookup(each.value, "osdisk", "*")
  pool     = "default"
  source   = var.image_url
  format   = "qcow2"
}

resource "libvirt_domain" "nextcloud_vms" {
for_each = local.servers
  name       = each.key
  memory     = each.value["mem"]
  vcpu       = each.value["cpu"]
  qemu_agent = true
  network_interface {
    network_name   = var.net
    wait_for_lease = true
  }
#  cpu = {
#    mode = "host-passthrough"
#  }

  disk {
    volume_id = libvirt_volume.server-os[each.key].id
  }

  cloudinit = libvirt_cloudinit_disk.commoninit[each.key].id

  console {
  type        = "pty"
  target_type = "serial"
  target_port = "0"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
  depends_on = [ libvirt_volume.server-os ]
}

terraform {
  required_version = ">= 0.12"
}
