resource "libvirt_network" "nc-network" {
  name = var.global_net
  mode = "nat"
  domain = "nc.lan"
  autostart = true
  addresses = ["10.17.3.0/26"]
  dhcp {
    enabled = true
  }
  dns {
    enabled = true
    forwarders {
      address = "8.8.8.8"
    }
  }
}
