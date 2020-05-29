#cloud-config
# vim: syntax=yaml
#
# ***********************
# 	---- for more examples look at: ------
# ---> https://cloudinit.readthedocs.io/en/latest/topics/examples.html
# ******************************
#
# This is the configuration syntax that the write_files module
# will know how to understand. encoding can be given b64 or gzip or (gz+b64).
# The content will be decoded accordingly and then written to the path that is
# provided.
#
# Note: Content strings here are truncated for example purposes.
hostname: ${hostname}
fqdn: ${fqdn}
#package_upgrade: true
packages: ${first_packages}
ssh_pwauth: true
manage_etc_hosts: true
chpasswd:
  list: |
     root: StrongPassword
  expire: False
users:
  - name: ${user}
    ssh_authorized_keys:
      - ${ssh_public_key}
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    shell: /bin/bash
    groups: wheel
runcmd:
  - sudo systemctl start qemu-guest-agent.service
  - timedatectl set-timezone Europe/Paris
  - hostnamectl set-hostname ${fqdn}
growpart:
  mode: auto
  devices: ['/']
%{ if dd_enabled }
disk_setup:
  /dev/vdb:
    table_type: gpt
    layout: True
    overwrite: False
fs_setup:
  - label: DATA_XFS
    filesystem: xfs
    device: '/dev/vdb'
    partition: auto
    #cmd: mkfs -t %(filesystem)s -L %(label)s %(device)s
mounts:
  # [ /dev/vdx, /mountpoint, fstype ]
  - [ LABEL=DATA_XFS, /mnt/data, xfs ]
%{ endif }
output:
    init:
        output: "> /var/log/cloud-init.out"
        error: "> /var/log/cloud-init.err"
    config: "tee -a /var/log/cloud-config.log"
    final:
        - ">> /var/log/cloud-final.out"
        - "/var/log/cloud-final.err"
final_message: "The system is finall up, after $UPTIME seconds"
