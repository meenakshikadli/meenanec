# creation of cluster

module "create_cluster" {
  source             = "../../../../terraform_modules/kubernetes-nodes-creation"
  hcloud_token       = var.hcloud_token
  master_node_count  = var.master_node_count
  worker_node_count  = var.worker_node_count
  ssh_key_name       = var.ssh_key_name
  load_balancer_name = var.load_balancer_name
  os_type            = var.os_type
  server_type        = var.server_type
  location           = var.location
  private_key        = var.private_key
  private_key_name   = var.private_key_name
  env_name           = var.env_name
  network_ip_range   = var.network_ip_range
  volume_size        = var.volume_size
  qualysActivationId = var.qualysActivationId
  qualysCustomerId   = var.qualysCustomerId
}

# values stored in locals to use globally in the templates

locals {
  master_server_ip = module.create_cluster.master_node_details.*.ipv4_address
  worker_server_ip = module.create_cluster.worker_node_details.*.ipv4_address
  network_id       = module.create_cluster.network_details.id
  master_server_id = module.create_cluster.master_node_details.*.id
  worker_server_id = module.create_cluster.worker_node_details.*.id
}