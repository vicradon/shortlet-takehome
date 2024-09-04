resource "kubernetes_service" "timeapi_service" {
  metadata {
    name = "timeapi-service"
    namespace = kubernetes_namespace.timeapi_namespace.metadata[0].name
  }
  spec {
    selector = {
      app = "timeapi"
    }
    port {
      port        = 80
      target_port = 4500
    }
    type = "ClusterIP"
  }
}

resource "kubernetes_ingress_v1" "timeapi_ingress" {
  wait_for_load_balancer = true
  metadata {
    name = "timeapi-ingress"
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      http {
        path {
          path = "/"
          backend {
            service {
              name = kubernetes_service.timeapi_service.metadata.0.name
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
