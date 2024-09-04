resource "google_compute_address" "ingress_ip_address" {
  name = "nginx-controller"
}

module "nginx-controller" {
  source  = "terraform-iaac/nginx-controller/helm"
  version = "2.3.0"
  namespace  = "nginx-ingress"
  name       = "nginx-ingress"
  ingress_class_name = "nginx"
  create_namespace = true

  ip_address = google_compute_address.ingress_ip_address.address
}