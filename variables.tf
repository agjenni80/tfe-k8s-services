variable "tfe_organization" {
  description = "TFE organization"
  default = "RogerBerlind"
}

variable "k8s_cluster_workspace" {
  description = "workspace to use for the k8s cluster"
}

variable "k8s_vault_config_workspace" {
  description = "workspace to use for the vault configuration"
}
