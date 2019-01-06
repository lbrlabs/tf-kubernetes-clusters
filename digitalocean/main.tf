module "kubernetes_cluster" {
  source                     = "github.com/jaxxstorm/terraform-do-kubernetes"
  do_token                   = "${var.do_token}"
  do_region                  = "${var.region}"
  cluster_name               = "${var.name}"
  cluster_default_node_size  = "${var.node_size}"
  cluster_default_node_count = "${var.node_count}"
  kubeconfig_path            = "${var.kubeconfig_path}"
}

resource "null_resource" "kubeconfig" {
  provisioner "local-exec" {
    command = "kubectl config rename-context do-${var.region}-${var.name} lbrlabs@do"
  }

  depends_on = ["module.kubernetes_cluster"]
}
