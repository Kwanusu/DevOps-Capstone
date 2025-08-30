terraform { 
    required_providers { 
        azurerm = { 
            source = "hashicorp/azurerm" 
            version = "~>4.0" 
        } 
        
        kubernetes = { 
            source = "hashicorp/kubernetes" 
            version = "~>2.20" 
        } 
    } 
} 
provider "azurerm" { 
    features = {} 
}

# ---------------------------
# Kubernetes Secret 
# ---------------------------
resource "kubernetes_secret" "flask_app_secret" {
  metadata {
    name = "flask-app-secret"
  }

  data = {
    DB_USER     = "flaskuser"
    DB_PASSWORD = var.db_password  
    DB_NAME     = "flaskdb"
  }

  type = "Opaque"
}

# ---------------------------
# Persistent Volume Claim (Dynamic provisioning)
# ---------------------------
resource "kubernetes_persistent_volume_claim" "flask_pvc" {
  metadata {
    name = "flask-pvc"
  }

  spec {
    access_modes = ["ReadWriteOnce"]

    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}

# ---------------------------
# Flask App Deployment 
# ---------------------------
resource "kubernetes_deployment" "flask_app" {
  metadata {
    name = "my-flask-app"
    labels = {
      app = "my-flask-app"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "my-flask-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "my-flask-app"
        }
      }

      spec {
        container {
          image = var.app_container_image
          name  = "flask-app-container"

          port {
            container_port = 80
          }

          # Flask gets DB password from K8s Secret (synced from AKV)
          env {
            name = "DB_PASSWORD"
            value_from {
              secret_key_ref {
                name = "db-pass-secret"
                key  = "db-password"
              }
            }
          }
        }

        # CSI driver still needs volume for syncing
        volume {
          name = "secrets-store"
          csi {
            driver = "secrets-store.csi.k8s.io"
            read_only = true
            volume_attributes = {
              secretProviderClass = "akv-secrets"
            }
          }
        }
      }
    }
  }
}


# ---------------------------
# Flask App Service
# ---------------------------
resource "kubernetes_service" "flask_app_service" {
  metadata {
    name = "my-flask-app-service"
  }

  spec {
    selector = {
      app = kubernetes_deployment.flask_app.metadata[0].labels.app
    }
    port {
      port        = 80
      target_port = 80
    }
    type = "ClusterIP"
  }
}
#----------------------------
# Ingress resource
#----------------------------

resource "kubernetes_ingress_v1" "flask_ingress" {
  metadata {
    name      = "flask-app-ingress"
    namespace = "default"
    annotations = {
      kubernetes.io/ingress.class                = "nginx"
      cert-manager.io/cluster-issuer             = "letsencrypt-prod"
      nginx.ingress.kubernetes.io/force-ssl-redirect = "true"
    }
  }

  spec {
    tls {
      hosts      = ["http://flaskapp-devsecops.eastus.cloudapp.azure.com"]   
      secret_name = "flaskapp-tls"            
    }

    rule {
      host = "http://flaskapp-devsecops.eastus.cloudapp.azure.com"
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = kubernetes_service.flask_app_service.metadata[0].name
              port {
                number = 80
              }
            }
          }
        }
      }
    }
  }
}

#-------------------------------------
# Cluster Issuer for TLS certificates
#-------------------------------------
resource "kubernetes_manifest" "letsencrypt_clusterissuer" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "letsencrypt-prod"
    }
    spec = {
      acme = {
        email  = "kwanusujoseph@gmail.com"   
        server = "https://acme-v02.api.letsencrypt.org/directory"
        privateKeySecretRef = {
          name = "letsencrypt-prod"
        }
        solvers = [{
          http01 = {
            ingress = {
              class = "nginx"
            }
          }
        }]
      }
    }
  }
}

