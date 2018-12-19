variable "tfe_organization" {}
variable "k8s_cluster_workspace" {}

data "terraform_remote_state" "test" {
  backend = "atlas"
  config {
    name = "${var.tfe_organization}/${var.k8s_cluster_workspace}"
  }
}

locals {
  host = "${data.terraform_remote_state.test.k8s_endpoint}"
}

output "host" {
  value = "${local.host}"
}
