data "rke_node_parameter" "masters" {
  count             = "${length(var.master_hosts)}"
  address           = "${var.master_hosts[count.index]}"
  internal_address  = "${var.master_hosts[count.index]}"
  user              = "${var.user}"
  role              = ["controlplane", "worker", "etcd"]
  ssh_key           = "${file("${var.ssh_private_key_path}")}"
}

data "rke_node_parameter" "nodes" {
  count             = "${length(var.worker_hosts)}"
  address           = "${var.worker_hosts[count.index]}"
  internal_address  = "${var.worker_hosts[count.index]}"
  user              = "${var.user}"
  role              = ["worker"]
  ssh_key           = "${file("${var.ssh_private_key_path}")}"
}

resource rke_cluster "cluster" {
  ignore_docker_version = true
  nodes_conf            = ["${data.rke_node_parameter.masters.*.json}", "${data.rke_node_parameter.nodes.*.json}"]

  ingress = {
    provider = "none"
  }

  authorization {
    mode = "rbac"
  }

  network {
    plugin = "flannel"
  }

  authentication {
    strategy = "x509"

    sans = "${var.additional_urls}"
  }
  kubernetes_version = "${var.kubernetes_version}"
}
