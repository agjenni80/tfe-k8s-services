output "cats_and_dogs_ip" {
  value = "${kubernetes_service.cats-and-dogs-frontend.load_balancer_ingress.0.ip}"
}

output "cats_and_dogs_token" {
  value = "${data.null_data_source.retrieve_token_from_file.outputs["cats_and_dogs_token"]}"
}
