variable "k8s_endpoint" {
  description = "k8s_endpoint"
}

variable "k8s_master_auth_client_certificate" {
  description = "k8s_master_auth_client_certificate"
}

variable "k8s_master_auth_client_key" {
  description = "k8s_master_auth_client_key"
}

variable "k8s_master_auth_cluster_ca_certificate" {
  description = "k8s_master_auth_cluster_ca_certificate"
}

variable "vault-k8s-auth-backend" {
  description = "vault-k8s-auth-backend"
}

variable "token_name" {
  description = "name of kubernetes token for cats-and-dogs service account"
}

/*variable "token_value" {
  description = "value of kubernetes token for cats-and-dogs service account"
}*/
