resource "google_container_cluster" "primary" {
  name               = "lbr"
  zone               = "${var.region}-a"
  initial_node_count = "${var.node_count}"
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
}

output "master_version" {
  value = "${google_container_cluster.primary.master_version}"
}
