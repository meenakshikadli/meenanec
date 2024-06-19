# Variables used for firewall creation

variable "hctoken" {
  default     = "U286NWo1WRtuvsZck6I4fCNL6ZQE6buQGvZL3mLwuPE5Nl4cXtPHov2eCMhBa0If"
  type        = string
  description = "API token for connecting to hetzner"
}

variable "firewall_name" {
  default     = "firewall"
  type        = string
  description = "Name of the firewall"
}

variable "inbound" {
  default     = "in"
  type        = string
  description = "Inbound traffic originates from outside the network"
}

variable "outbound" {
  default     = "out"
  type        = string
  description = "Outbound traffic originates inside the network"
}

variable "protocol_udp" {
  default     = "udp"
  type        = string
  description = "UDP protocol for request-response communication"
}

variable "protocol_tcp" {
  default     = "tcp"
  type        = string
  description = "TCP protocol for connection-oriented reliable service"
}

variable "port_53" {
  default     = 53
  type        = number
  description = "Port 53"
}

variable "port_80" {
  default     = 80
  type        = number
  description = "Port 80"
}

variable "port_22" {
  default     = 22
  type        = number
  description = "Port 22"
}

variable "port_161" {
  default     = 161
  type        = number
  description = "Port 161"
}

variable "port_162" {
  default     = 162
  type        = number
  description = "Port 162"
}

variable "port_88" {
  default     = 88
  type        = number
  description = "Port 88"
}

variable "ip_range" {
  default     = ["0.0.0.0/0", "::/0"]
  type        = list(string)
  description = "Set of IP's allowed"
}

variable "server_ip" {
  default     = ["49.12.215.44/32"]
  type        = list(string)
  description = "Specific server IP allowed"
}

variable "server_name" {
  default     = "firewall-server"
  type        = string
  description = "Name of the server in hetzner cloud"
}