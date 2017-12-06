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

variable "vault_k8s_auth_backend" {
  description = "vault_k8s_auth_backend"
}

variable "token_name" {
  description = "name of kubernetes token for cats-and-dogs service account"
}

variable "vault_user" {
  description = "vault user (affects path to secret)"
  default = "roger"
}
