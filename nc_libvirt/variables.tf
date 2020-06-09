variable "ansible_playbook_path" {
  type = string
  default = "/etc/ansible/playbooks/main.yml"
}
variable "global_ssh_public_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1" # changeme
}
variable "global_net" {
  description = "the name of the server network"
  type = string
  default = "ncnet"
}
