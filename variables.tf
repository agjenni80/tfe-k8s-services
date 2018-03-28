variable "tfe_organization" {
  description = "TFE organization"
  default = "RogerBerlind"
}

variable "k8s_cluster_workspace" {
  description = "workspace to use for the k8s cluster"
}

variable "vault_address" {
  description = "address of Vault server including protocol and port"
}
