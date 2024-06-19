# Attach master/worker nodes to loadbalancer 

data "hcloud_load_balancer" "load_balancer" {
  name = var.load_balancer_name
}

# Attach master node  to loadbalancer 
resource "hcloud_load_balancer_target" "master_attachment_to_loadbalancer" {
  depends_on       = [hcloud_firewall_attachment.firewall_attachment_on_master]
  type             = "server"
  count            = length(local.master_server_id)
  load_balancer_id = data.hcloud_load_balancer.load_balancer.id
  server_id        = element(local.master_server_id, count.index)
}

# Attach worker node to loadbalancer 
resource "hcloud_load_balancer_target" "worker_attachment_to_loadbalancer" {
  depends_on       = [hcloud_firewall_attachment.firewall_attachment_on_worker]
  type             = "server"
  count            = length(local.worker_server_id)
  load_balancer_id = data.hcloud_load_balancer.load_balancer.id
  server_id        = element(local.worker_server_id, count.index)
}