# Creating firewall and it's rules, attaching firewall rules to servers
# terraform_modules directory contains code skeleton to reuse for creation of hetzner firewall and it's rules according to user specification

# Calling modules to include their resources into the configuration
module "hetzner_firewall" {
  source        = "../../../../terraform_modules/firewall" # path for terraform_modules directory
  hctoken       = var.hctoken
  firewall_name = var.firewall_name
  inbound       = var.inbound
  outbound      = var.outbound
  protocol_udp  = var.protocol_udp
  protocol_tcp  = var.protocol_tcp
  port_53       = var.port_53
  port_80       = var.port_80
  port_22       = var.port_22
  port_161      = var.port_161
  port_162      = var.port_162
  port_88       = var.port_88
  ip_range      = var.ip_range
  server_ip     = var.server_ip
  server_name   = var.server_name
} 