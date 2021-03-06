output "output_data" {
  value = {
    addresses    = values(libvirt_domain.loadbalancer_vms).*.network_interface.0.addresses.0
    hostnames    = keys(libvirt_domain.loadbalancer_vms)
    ansiblegrp   = local.ansible_grp
    user         = var.user
    ssh_key_path = var.ssh_key_path
    machine_name = var.machine_name
  }
}
