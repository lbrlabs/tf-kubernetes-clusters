data "rke_node_parameter" "masters" {
  count             = "${var.master_count}"
  address           = "${local.master_public_ips[count.index]}"
  internal_address  = "${local.master_private_ips[count.index]}"
  node_name         = "${var.instance_prefix}-${count.index+1}"
  hostname_override = "${var.instance_prefix}-${count.index+1}"
  user              = "root"
  role              = ["controlplane","etcd"]
  ssh_key           = "${file("${var.ssh_private_key_path}")}"
}

resource rke_cluster "cluster" {
  ignore_docker_version = true
  nodes_conf            = ["${data.rke_node_parameter.masters.*.json}"]

  ingress = {
    provider = "none"
  }

  authorization {
    mode = "rbac"
  }

  network {
    plugin = "flannel"
  }
}
