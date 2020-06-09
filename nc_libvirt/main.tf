module "gluster-cluster" {
   source         = "./modules/gluster-module/"
   machine_name   = "gl"
   server_count   = "2"
   disks_enabled  = ["true", "true"]
   net            = var.global_net
   ssh_public_key = var.global_ssh_public_key
}

module "redis-cluster" {
   # load the module
   source         = "./modules/redis-module/"
   # set the variables
   machine_name   = "rd"
   server_count   = "2"
   disks_enabled  = ["false", "false"]
   net            = var.global_net
   ssh_public_key = var.global_ssh_public_key
}

module "mariadb-cluster" {
   source         = "./modules/mariadb-module/"
   machine_name   = "db"
   server_count   = "2"
   disks_enabled  = ["false", "false"]
   net            = var.global_net
   ssh_public_key = var.global_ssh_public_key
}

module "nextcloud-cluster" {
   source         = "./modules/nextcloud-module/"
   machine_name   = "nc"
   server_count   = "2"
   disks_enabled  = ["false", "false"]
   net            = var.global_net
   ssh_public_key = var.global_ssh_public_key
}

module "loadbalancer-cluster" {
   source         = "./modules/loadbalancer-module/"
   machine_name   = "lb"
   server_count   = "1"
   disks_enabled  = ["false"]
   net            = var.global_net
   ssh_public_key = var.global_ssh_public_key
}
