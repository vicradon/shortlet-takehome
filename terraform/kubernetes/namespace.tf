resource "kubernetes_namespace" "timeapi_namespace" {
  metadata {
    name = "timeapi-namespace"
  }
}
