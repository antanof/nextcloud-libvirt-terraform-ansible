variable "ansible_playbook_path" {
  type = string
  default = "/etc/ansible/playbooks/main.yml"
}
variable "global_ssh_public_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDQSCz5oVLPzzjJz1lJi4DuRsKPT5Puy1fAWdZtRWLfJKHwV5CVMPzYdxnaOSXJHMqIedNc3K1jCGsd5CYXGRjAIXdXhF4ayiI1eYxqa2XRaF1tINXDQ98Jn1sYS6y7wxUC/wZ7vFc7NIdLsv+Oy4xBdVzci1W7pZvViBSCCj6LVK8XoU0ET686GX0t/8Y9yq0aI2i/7k6KqOcNqwdIVtAL7gSnywPkScN+z3H8wwNxKo26Vz/3pYm99i20+dJTXxcDh4wZm10rn5GnMxoY0UdCLWaKyRQpLR9IFgRGMF9pPN7g8xKeHy1SF2/TNd5bO0oHAR4q15ugGJaYOh6UQxpyAH73yMpfyzSqpK4bRFXPejjcHaeAkd4e1Whi7pWBaEpJjDpWwOKNurCSQpLxGzlcwzx/zJQbw766xyepJIh80F5ekngDr8eKAVtbXjCoBVLzjZ4aKCq+SBGDSfVAp7NM2C+y0FxJNGRKgH254KO3A16wK4/xTanlu1pFFxw/sjM= matt@m4800.hme.fontcloud.eu.org"
}
variable "global_net" {
  description = "the name of the server network"
  type = string
  default = "ncnet"
}
