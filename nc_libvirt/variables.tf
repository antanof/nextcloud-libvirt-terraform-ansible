variable "ansible_playbook_path" {
  type = string
  default = "/etc/ansible/playbooks/main.yml"
}
variable "global_ssh_public_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EA"
}
variable "global_net" {
  type = string
  default = "network"
}
