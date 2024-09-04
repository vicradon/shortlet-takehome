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
    namespace = kubernetes_namespace.timeapi_namespace.metadata[0].name

    annotations = {
      "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true"
      "nginx.ingress.kubernetes.io/use-regex"          = "true"
      "cert-manager.io/cluster-issuer"                  = module.cert_manager.cluster_issuer_name
    }
  }

  spec {
    ingress_class_name = "nginx"
    rule {
      host = var.domain
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
    tls {
      hosts = [var.domain]
      secret_name = module.cert_manager.certificates["timeapi-cert"].secret_name
    }
  }
}
