# template to create azure kubernetes service endpoint

resource "null_resource" "create_service_connection" {
  depends_on = [null_resource.join_worker_nodes_to_cluster]
  count      = length(local.master_server_ip)

  connection {
    host        = element(local.master_server_ip, count.index)
    type        = "ssh"
    private_key = file(var.private_key)
  }

  provisioner "remote-exec" {
    inline = [data.template_file.service_connection.rendered]
  }
}

data "template_file" "service_connection" {
  template = file("${path.module}/scripts/service_connection.sh")

  vars = {
    project_id            = var.project_id
    service_endpoint_name = var.service_endpoint_name
    org_service_url       = var.org_service_url
    personal_access_token = var.personal_access_token
  }
}