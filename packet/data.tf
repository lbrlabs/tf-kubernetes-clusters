data "packet_operating_system" "ubuntu" {
  name             = "Ubuntu 18.04 LTS"
  distro           = "ubuntu"
  version          = "18.04"
  provisionable_on = "${var.node_type}"
}
