provider "kubernetes" {
  config_path    = "~/.kube/config"
  config_context = "arn:aws:eks:us-east-1:528862265991:cluster/my-cluster"
}

resource "kubernetes_namespace" "example" {
  metadata {
    name = "my-first-namespace"
  }
}


