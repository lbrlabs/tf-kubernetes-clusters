variable "do_token" {}

variable "region" {
  default = "nyc1"
}

variable "name" {}

variable "node_size" {
  default = "s-1vcpu-2gb"
}

variable "node_count" {
  default = 1
}

variable "kubeconfig_path" {}
