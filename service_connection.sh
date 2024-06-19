#!/bin/bash

# script to create kubernetes service connection in azure

master_node_public_ip=$(ip addr show | grep eth0 | grep -oP 'inet \K[\d.]+')
certificate_authority_data=$(grep -i 'certificate-authority-data' .kube/config | cut -d ':' -f2)
client_certificate_data=$(grep -i 'client-certificate-data' .kube/config | cut -d ':' -f2)
client_key_data=$(grep -i 'client-key-data' .kube/config | cut -d ':' -f2)
project_id=${project_id}
service_endpoint_name=${service_endpoint_name}
org_service_url=${org_service_url}
personal_access_token=${personal_access_token}

mkdir /root/service_connection/

cat <<EOF > /root/service_connection/main.tf

# terraform block for Azure DevOps
terraform {
  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = "0.9.1"
    }
  }
}

# provider block for Azure DevOps
provider "azuredevops" {
  org_service_url       = "$org_service_url"
  personal_access_token = "$personal_access_token"
}

# create kubernetes service connection 
resource "azuredevops_serviceendpoint_kubernetes" "kubernetes_service_endpoint" {
  project_id            = "$project_id"
  service_endpoint_name = "$service_endpoint_name"
  apiserver_url         = "https://$master_node_public_ip:6443"
  authorization_type    = "Kubeconfig"
  
  kubeconfig {
    kube_config         = <<EOT
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data:$certificate_authority_data
    server: https://$master_node_public_ip:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data:$client_certificate_data
    client-key-data:$client_key_data
EOT
accept_untrusted_certs = true
cluster_context        = "kubernetes-admin@kubernetes"
  }
}

EOF

#terraform execution commands
cd /root/service_connection/
terraform init
terraform plan -input=false -out=tfplan
terraform apply -auto-approve tfplan