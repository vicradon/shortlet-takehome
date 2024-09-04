module "kubernetes" {
  source = "./kubernetes"

  certmanager_email = var.certmanager_email
}
