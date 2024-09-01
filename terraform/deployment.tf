resource "kubernetes_deployment" "timeapi" {
  metadata {
    name = "timeapi-deployment"
    labels = {
      app = "timeapi"
    }
  }


  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "timeapi"
      }
    }

    template {
      metadata {
        labels = {
          app = "timeapi"
        }
      }

      spec {
        container {
          image = "vicradon/current-time:latest"
          name  = "timeapi"

          port {
            container_port = 4500
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
