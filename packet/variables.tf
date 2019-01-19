variable "token" {}
variable "region" {}
variable "master_count" {
  default = 1
}

variable "node_count" {
  default = 1
}

variable "node_type" {
  default = "x1.small.x86"
}

variable "instance_prefix" {
  default = "kmaster"
}

variable "ssh_key" {}

variable "ssh_private_key_path" {}

variable "kube_config_path" {}
