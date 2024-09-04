resource "kubernetes_deployment" "timeapi" {
  metadata {
    name = "timeapi-deployment"
    namespace = kubernetes_namespace.timeapi_namespace.metadata[0].name
    labels = {
      app = "timeapi"
    }
  }

  timeouts {
    update = "5m"
    create = "5m"
    delete = "5m"
  }

  spec {
    replicas = 1

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
              cpu    = "100m"
              memory = "512Mi"
            }
            requests = {
              cpu    = "50m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
