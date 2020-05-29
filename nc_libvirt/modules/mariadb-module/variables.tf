variable "machine_name" {
}
variable "image_url" {
  type = string
  default = "https://download.fedoraproject.org/pub/fedora/linux/releases/31/Cloud/x86_64/images/Fedora-Cloud-Base-31-1.9.x86_64.qcow2"
}
variable "tld" {
  type = string
  default = "lan"
}
variable "net" {
}
variable "ansible_grp" {
  type = string
  default = "lan_db"
}
variable "user" {
  type = string
  default = "matt"
}
variable "ssh_key_path" {
  type = string
  default = "/home/matt/.ssh/id_rsa"
}
variable "ssh_public_key" {
}
variable "server_count" {
}
variable "server_name" {
  type = string
  default = "fed"
}
variable "disks_enabled" {
  type = list
}
variable "memoryMB" {
  type = number
  default = 2048
}
variable "cpu" {
  type = number
  default = 2
}
variable "rootdiskBytes" {
  type = number
  default = 1024*1024*1024*16
}
variable "diskBytes" {
type = number
default = 1024*1024*1024*32
}
variable "first_packages" {
  type    = list
  default = ["python3-httplib2", "qemu-guest-agent"]
}
