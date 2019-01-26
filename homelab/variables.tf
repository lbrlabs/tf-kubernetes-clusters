variable "hosts" {
  type = "list"
}

variable "ssh_private_key_path" {

}

variable "user" {
  default = "root"
}

variable "additional_urls" {
  type = "list"
}

variable "kube_config_path" {
  default = "/tmp/baremetal.yml"
}
