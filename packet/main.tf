resource "packet_device" "master" {
  count            = "${var.master_count}"
  hostname         = "${var.instance_prefix}-${count.index+1}"
  plan             = "${var.node_type}"
  operating_system = "${data.packet_operating_system.ubuntu.id}"
  billing_cycle    = "hourly"
  project_id       = "${packet_project.kubernetes.id}"
  facility         = "${var.region}"
  user_data        = "${file("${path.module}/templates/user_data.tmpl")}"

  provisioner "file" {
    source      = "${path.module}/scripts/check_docker.sh"
    destination = "/tmp/check_docker.sh"

    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file("${var.ssh_private_key_path}")}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/check_docker.sh",
      "/tmp/check_docker.sh",
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = "${file("${var.ssh_private_key_path}")}"
    }
  }
}

locals {
  master_public_ips  = "${packet_device.master.*.access_public_ipv4}"
  master_private_ips = "${packet_device.master.*.access_private_ipv4}"
}
