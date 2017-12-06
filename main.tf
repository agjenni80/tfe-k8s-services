terraform {
  required_version = ">= 0.11.0"
}

provider "kubernetes" {
  host = "${var.k8s_endpoint}"
  client_certificate = "${base64decode(var.k8s_master_auth_client_certificate)}"
  client_key = "${base64decode(var.k8s_master_auth_client_key)}"
  cluster_ca_certificate = "${base64decode(var.k8s_master_auth_cluster_ca_certificate)}"
}

/*resource "kubernetes_namespace" "cats-and-dogs" {
  metadata {
    name = "cats-and-dogs"
  }
  depends_on = ["vault_generic_secret.role", "null_resource.auth_config" ]
}

resource "kubernetes_service_account" "cats-and-dogs" {
  metadata {
    name = "cats-and-dogs"
    namespace = "${kubernetes_namespace.cats-and-dogs.metadata.0.name}"
  }
}*/

resource "kubernetes_pod" "cats-and-dogs-backend" {
  metadata {
    name = "cats-and-dogs-backend"
    namespace = "cats-and-dogs"
    labels {
      App = "cats-and-dogs-backend"
    }
  }
  spec {
    service_account_name = "cats-and-dogs"
    container {
      image = "rberlind/redis-pwd-from-vault:latest"
      name  = "cats-and-dogs-backend"
      command = ["/app/start_redis.sh"]
      env = {
        name = "VAULT_K8S_BACKEND"
        value = "${var.vault_k8s_auth_backend}"
      }
      env = {
        name = "VAULT_USER"
        value = "${var.vault_user}"
      }
      env = {
        name = "K8S_TOKEN"
        value_from {
          secret_key_ref {
            name = "${var.token_name}"
            key = "token"
          }
        }
      }
      port {
        container_port = 6379
      }
    }
  }
}

resource "kubernetes_service" "cats-and-dogs-backend" {
  metadata {
    name = "cats-and-dogs-backend"
    namespace = "cats-and-dogs"
  }
  spec {
    selector {
      App = "${kubernetes_pod.cats-and-dogs-backend.metadata.0.labels.App}"
    }
    port {
      port = 6379
      target_port = 6379
    }
  }
}

resource "kubernetes_pod" "cats-and-dogs-frontend" {
  metadata {
    name = "cats-and-dogs-frontend"
    namespace = "cats-and-dogs"
    labels {
      App = "cats-and-dogs-frontend"
    }
  }
  spec {
    service_account_name = "cats-and-dogs"
    container {
      image = "rberlind/cats-and-dogs:latest"
      name  = "cats-and-dogs-frontend"
      env = {
        name = "REDIS"
        value = "cats-and-dogs-backend"
      }
      env = {
        name = "VAULT_K8S_BACKEND"
        value = "${var.vault_k8s_auth_backend}"
      }
      env = {
        name = "VAULT_USER"
        value = "${var.vault_user}"
      }
      env = {
        name = "K8S_TOKEN"
        value_from {
          secret_key_ref {
            name = "${var.token_name}"
            key = "token"
          }
        }
      }
      port {
        container_port = 80
      }
    }
  }

  depends_on = ["kubernetes_service.cats-and-dogs-backend"]
}

resource "kubernetes_service" "cats-and-dogs-frontend" {
  metadata {
    name = "cats-and-dogs-frontend"
    namespace = "cats-and-dogs"
  }
  spec {
    selector {
      App = "${kubernetes_pod.cats-and-dogs-frontend.metadata.0.labels.App}"
    }
    port {
      port = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}
