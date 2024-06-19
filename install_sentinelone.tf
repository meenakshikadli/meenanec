# template to install sentinelone on kubernetes cluster

resource "null_resource" "install_sentinelone" {
  depends_on = [null_resource.create_service_connection]
  count      = length(local.master_server_ip)

  connection {
    host        = element(local.master_server_ip, count.index)
    type        = "ssh"
    private_key = file(var.private_key)
  }

  provisioner "remote-exec" {
    inline = [data.template_file.install_sentinelone.rendered]
  }
}

data "template_file" "install_sentinelone" {
  template = file("${path.module}/scripts/install_sentinelone.sh")

  vars = {
    agent_version   = var.agent_version
    group_token     = var.group_token
    agent_tag       = var.agent_tag
    docker_server   = var.docker_server
    docker_username = var.docker_username
    docker_password = var.docker_password
  }
}