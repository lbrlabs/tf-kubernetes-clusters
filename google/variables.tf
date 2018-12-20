variable "region" {
  default = "us-west1"
}

variable "version" {
  default = "1.11.5-gke.4"
}

variable "node_count" {
  default = 1
}

variable "node_pool_min_size" {
  default = 0
}

variable "node_pool_max_size" {
  default = 5
}

variable "node_auto_repair" {
  default = true
}

variable "node_auto_upgrade" {
  default = true
}

variable "node_machine_type" {
  default = "n1-standard-1"
}

variable "project_id" {}

variable "name" {}
