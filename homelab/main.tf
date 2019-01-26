data "rke_node_parameter" "masters" {
  count             = "${length(var.hosts)}"
  address           = "${var.hosts[count.index]}"
  internal_address  = "${var.hosts[count.index]}"
  user              = "${var.user}"
  role              = ["controlplane", "worker", "etcd"]
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

  authentication {
    strategy = "x509"

    sans = "${var.additional_urls}"
  }
}
