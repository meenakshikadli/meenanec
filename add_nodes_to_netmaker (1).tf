# Add servers to netmaker vnet

###################
# for Master Node #
###################
resource "null_resource" "add_master_nodes_to_netmaker" {
  depends_on = [module.create_cluster]
  count      = length(local.master_server_ip)

  connection {
    host        = element(local.master_server_ip, count.index)
    type        = "ssh"
    private_key = file(var.private_key)
  }

  provisioner "remote-exec" {
    inline = ["netclient join -t ${var.netmaker_access_token}", "sleep 30s"]
  }
}

###################
# for Worker Node #
###################
resource "null_resource" "add_worker_node1_to_netmaker" {
  depends_on = [null_resource.add_master_nodes_to_netmaker]

  connection {
    host        = local.worker_server_ip[0]
    type        = "ssh"
    private_key = file(var.private_key)
  }

  provisioner "remote-exec" {
    inline = ["netclient join -t ${var.netmaker_access_token}", "sleep 30s"]
  }
}

resource "null_resource" "add_worker_node2_to_netmaker" {
  depends_on = [null_resource.add_worker_node1_to_netmaker]

  connection {
    host        = local.worker_server_ip[1]
    type        = "ssh"
    private_key = file(var.private_key)
  }

  provisioner "remote-exec" {
    inline = ["netclient join -t ${var.netmaker_access_token}", "sleep 30s"]
  }
}

resource "null_resource" "add_worker_node3_to_netmaker" {
  depends_on = [null_resource.add_worker_node2_to_netmaker]

  connection {
    host        = local.worker_server_ip[2]
    type        = "ssh"
    private_key = file(var.private_key)
  }

  provisioner "remote-exec" {
    inline = ["netclient join -t ${var.netmaker_access_token}", "sleep 30s"]
  }
}