[all:vars]
ansible_python_interpreter="/usr/bin/python3"
[${group_0}]
%{ for ip in split(",", ips) }
${ip} ansible_user=${user} ansible_ssh_private_key_file=${ssh_file}
%{ endfor }
[${group_1}]
%{ for ip in split(",", ips) }
${ip} ansible_user=${user} ansible_ssh_private_key_file=${ssh_file}
%{ endfor }
[${group_2}]
%{ for ip in split(",", ips) }
${ip} ansible_user=${user} ansible_ssh_private_key_file=${ssh_file}
%{ endfor }


for n in module.*
[${module.redis-cluster.output_data.ansiblegrp}]
