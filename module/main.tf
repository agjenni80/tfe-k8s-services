variable "tfe_organization" {}
variable "test_workspace" {}

data "terraform_remote_state" "test" {
  backend = "atlas"
  config {
    name = "${var.tfe_organization}/${var.test_workspace}"
  }
}

locals {
  host = "${data.terraform_remote_state.test.k8s_endpoint}"
}

output "host" {
  value = "${local.host}"
}
