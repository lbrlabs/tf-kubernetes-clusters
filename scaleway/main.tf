resource "scaleway_server" "master" {
  name      = "${var.instance_prefix}-${count.index+1}"
  count     = "${var.count}"
  image     = "${data.scaleway_image.ubuntu.id}"
  type      = "START1-S"
  public_ip = "${element(scaleway_ip.master-ip.*.ip, count.index)}"
  cloudinit = "${file("${path.module}/templates/user_data.tmpl")}"

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

resource "scaleway_ip" "master-ip" {
  count = "${var.count}"
}

locals {
  public_ips  = "${scaleway_server.master.*.public_ip}"
  private_ips = "${scaleway_server.master.*.private_ip}"
}
