# hcloud terraform block
terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.44.1"
    }
  }
}

# hcloud provider block
provider "hcloud" {
  token = var.hcloud_token
}

# Attaching firewall rules to Master servers
resource "hcloud_firewall_attachment" "firewall_attachment_on_master" {
  depends_on  = [null_resource.configure_longhorn]
  count       = var.master_node_count
  firewall_id = var.firewall_id
  server_ids  = [module.create_cluster.master_node_details[count.index].id]
}

# Attaching firewall rules to Worker servers
resource "hcloud_firewall_attachment" "firewall_attachment_on_worker" {
  depends_on  = [null_resource.configure_longhorn]
  count       = var.worker_node_count
  firewall_id = var.firewall_id
  server_ids  = [module.create_cluster.worker_node_details[count.index].id]
}