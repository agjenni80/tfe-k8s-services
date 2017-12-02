output "cats_and_dogs_ip" {
  value = "${kubernetes_service.cats-and-dogs-frontend.load_balancer_ingress.0.ip}"
}

output "cats_and_dogs_hostname" {
  value = "${kubernetes_service.cats-and-dogs-frontend.load_balancer_ingress.0.hostname}"
}
