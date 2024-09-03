resource "kubernetes_service" "timeapi_service" {
  metadata {
    name = "timeapi-service"
  }
  spec {
    selector = {
      app = "timeapi"
    }
    port {
      port        = 80
      target_port = 4500
    }
    type = "LoadBalancer"
  }
}
