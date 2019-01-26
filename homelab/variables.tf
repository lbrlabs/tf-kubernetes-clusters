variable "master_hosts" {
  type = "list"
}

variable "worker_hosts" {
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

variable "kubernetes_version" {
  default = "v1.12.4-rancher1-1"
}
