module "cert_manager" {
  source        = "terraform-iaac/cert-manager/kubernetes"

  cluster_issuer_email                   = var.certmanager_email
  cluster_issuer_name                    = "cert-manager-global"
  cluster_issuer_private_key_secret_name = "cert-manager-private-key"
  cluster_issuer_server                  = "https://acme-v02.api.letsencrypt.org/directory"
  create_namespace                       = true
  
  certificates = {
    "timeapi-cert" = {
      dns_names = ["timeapi.osinachi.me"]
    }
  }
}
