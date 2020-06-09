# nextcloud-libvirt-terraform-ansible


## Requirement
Works with [Fedora Server cloud image](https://alt.fedoraproject.org/cloud/).
This code deploys :
- 2 Mariadb Master / Slave servers,
- 2 Redis Master / Slave servers,
- 2 vms in GlusterFS Cluster,
- Haproxy load-balancer,
- 2 Nextcloud servers with Nginx or Apache with php-fpm.

You must have installed [Terraform](https://www.terraform.io/), [Libvirt provider](https://github.com/dmacvicar/terraform-provider-libvirt) and [Ansible](https://www.ansible.com/).

## Copy
You must copy the repo and separate the Terraform part from the Ansible part.
Adapt the variables :
- variables.tf (terraform)
- vars (ansible)

## Virtual Infrastructure visualization
![Terraform Graph](https://github.com/antanof/nextcloud-libvirt-terraform-ansible/blob/master/graph.png)
![Schema](https://github.com/antanof/nextcloud-libvirt-terraform-ansible/blob/master/schema.png)
