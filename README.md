# nextcloud-libvirt-terraform-ansible
=====================================

## Requirement
Works with Fedora Server cloud image.
This code deploys 2 Mariadb Master / Slave servers, 2 Redis Master / Slave servers and a Nextcloud server with Nginx or Apache with php-fpm.
You must have installed [Terraform](https://www.terraform.io/), [Libvirt provider](https://github.com/dmacvicar/terraform-provider-libvirt) and [Ansible](https://www.ansible.com/).

## Copy
You must copy the repo and separate the Terraform part from the Ansible part.
Adapt the variables :
- variables.tf (terraform)
- vars (ansible)
