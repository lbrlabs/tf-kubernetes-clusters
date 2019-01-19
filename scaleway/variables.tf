variable "organization" {}
variable "token" {}
variable "region" {}
variable "count" {
  default = 1
}

variable "instance_prefix" {
  default = "kmaster"
}

variable "ssh_key" {}

variable "ssh_private_key_path" {}

variable "kube_config_path" {}
