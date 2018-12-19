output "cats_and_dogs_ip" {
  value = "${kubernetes_service.cats-and-dogs-frontend.load_balancer_ingress.0.ip}"
}

output "host_from_module" {
  value = "${module.test.host}"
}
