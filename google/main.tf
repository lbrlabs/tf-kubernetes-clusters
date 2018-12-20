resource "google_container_cluster" "primary" {
  name               = "${var.name}"
  zone               = "${var.region}-a"
  project            = "${var.project_id}"
  min_master_version = "${var.version}"

  addons_config {
    kubernetes_dashboard {
      disabled = true
    }
  }

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }

  lifecycle {
    ignore_changes = ["node_pool"]
  }

  node_pool {
    name = "default-pool"
  }
}

resource "google_container_node_pool" "default" {
  name               = "default"
  project            = "${var.project_id}"
  zone               = "${var.region}-a"
  cluster            = "${google_container_cluster.primary.name}"
  initial_node_count = "${var.node_count}"

  autoscaling {
    min_node_count = "${var.node_pool_min_size}"
    max_node_count = "${var.node_pool_max_size}"
  }

  management {
    auto_repair  = "${var.node_auto_repair}"
    auto_upgrade = "${var.node_auto_upgrade}"
  }

  lifecycle {
    ignore_changes = ["initial_node_count"]
  }

  node_config {
    machine_type = "${var.node_machine_type}"

    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  depends_on = ["google_container_cluster.primary"]
}

resource "null_resource" "kubeconfig" {
  provisioner "local-exec" {
    command = "gcloud container clusters get-credentials ${var.name}"
  }

  depends_on = ["google_container_node_pool.default"]
}

output "master_version" {
  value = "${google_container_cluster.primary.master_version}"
}
