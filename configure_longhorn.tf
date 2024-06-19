resource "null_resource" "configure_longhorn" {
  depends_on = [null_resource.create_service_connection]
  count      = length(local.master_server_ip)

  connection {
    host        = element(local.master_server_ip, count.index)
    type        = "ssh"
    private_key = file(var.private_key)
  }

  provisioner "remote-exec" {
    inline = [data.template_file.longhorn_deployment.rendered]
  }
}

data "template_file" "longhorn_deployment" {
  template = file("${path.module}/scripts/longhorn_configuration.sh")

  vars = {
    users                   = var.longhorn_users
    domain                  = var.longhorn_domain
    acr_password            = var.acr_password
    longhorn_admin_password = var.longhorn_admin_password
  }
}