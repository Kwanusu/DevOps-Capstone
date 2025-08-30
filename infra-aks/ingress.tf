provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

# NGINX Ingress Controller
resource "helm_release" "nginx_ingress" {
  name       = "ingress-nginx"
  namespace  = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.11.0"

  create_namespace = true

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }
}
