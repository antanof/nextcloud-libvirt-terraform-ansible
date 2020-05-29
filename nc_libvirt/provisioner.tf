resource "null_resource" "ansible_rd_gp" {
    provisioner "local-exec" {
      command = "echo [${module.redis-cluster.output_data.ansiblegrp}] >> ${path.module}/ansible/hosts"
    }
    depends_on = [ module.redis-cluster ]
}
resource "null_resource" "ansible_rd_ips" {
  count = length(module.redis-cluster.output_data.hostnames)
  provisioner "local-exec" {
    command = "echo ${module.redis-cluster.output_data.hostnames[count.index]} ansible_host=${module.redis-cluster.output_data.addresses[count.index]} ansible_user=${module.redis-cluster.output_data.user} ansible_ssh_private_key_file=${module.redis-cluster.output_data.ssh_key_path} >> ${path.module}/ansible/hosts"
  }
  depends_on = [ null_resource.ansible_rd_gp ]
}

resource "null_resource" "ansible_rd_prep" {
  provisioner "local-exec" {
    command = "sed -i -e '/hosts:/ s/: .*/: ${module.redis-cluster.output_data.ansiblegrp}/' /etc/ansible/playbooks/${module.redis-cluster.output_data.machine_name}.yml"
  }
}

resource "null_resource" "ansible_db_gp" {
    provisioner "local-exec" {
      command = "echo [${module.mariadb-cluster.output_data.ansiblegrp}] >> ${path.module}/ansible/hosts"
    }
  depends_on = [ null_resource.ansible_rd_ips, module.mariadb-cluster ]
}

resource "null_resource" "ansible_db_ips" {
  count = length(module.mariadb-cluster.output_data.hostnames)
  provisioner "local-exec" {
    command = "echo ${module.mariadb-cluster.output_data.hostnames[count.index]} ansible_host=${module.mariadb-cluster.output_data.addresses[count.index]} ansible_user=${module.mariadb-cluster.output_data.user} ansible_ssh_private_key_file=${module.mariadb-cluster.output_data.ssh_key_path} >> ${path.module}/ansible/hosts"
  }
  depends_on = [ null_resource.ansible_db_gp ]
}

resource "null_resource" "ansible_db_prep" {
  provisioner "local-exec" {
    command = "sed -i -e '/hosts:/ s/: .*/: ${module.mariadb-cluster.output_data.ansiblegrp}/' /etc/ansible/playbooks/${module.mariadb-cluster.output_data.machine_name}.yml"
  }
}

resource "null_resource" "ansible_nc_gp" {
    provisioner "local-exec" {
      command = "echo [${module.nextcloud-cluster.output_data.ansiblegrp}] >> ${path.module}/ansible/hosts"
    }
    depends_on = [ null_resource.ansible_db_ips, null_resource.ansible_rd_ips, module.nextcloud-cluster ]
}

resource "null_resource" "ansible_nc_ips" {
  count = length(module.nextcloud-cluster.output_data.hostnames)
  provisioner "local-exec" {
    command = "echo ${module.nextcloud-cluster.output_data.hostnames[count.index]} ansible_host=${module.nextcloud-cluster.output_data.addresses[count.index]} ansible_user=${module.nextcloud-cluster.output_data.user} ansible_ssh_private_key_file=${module.nextcloud-cluster.output_data.ssh_key_path} >> ${path.module}/ansible/hosts"
  }
  depends_on = [ null_resource.ansible_nc_gp ]
}

resource "null_resource" "ansible_nc_play" {
  provisioner "local-exec" {
    command = "sed -i -e '/hosts:/ s/: .*/: ${module.nextcloud-cluster.output_data.ansiblegrp}/' /etc/ansible/playbooks/${module.nextcloud-cluster.output_data.machine_name}.yml"
  }
  provisioner "local-exec" {
    command = "/usr/bin/ansible-playbook -i ${path.module}/ansible/hosts ${var.ansible_playbook_path}"
  }
  depends_on = [ null_resource.ansible_nc_ips ]
}

resource "null_resource" "delete_hosts" {
    provisioner "local-exec" {
      command = "cat /dev/null > ${path.module}/ansible/hosts"
      when = destroy
    }
}
