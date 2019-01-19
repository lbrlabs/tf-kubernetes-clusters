resource "local_file" "kube_cluster_yaml" {
  filename = "${var.kube_config_path}"
  content  = "${rke_cluster.cluster.kube_config_yaml}"
}

output "ips" {
  value = "${packet_device.master.*.access_public_ipv4}"
}
