variable "namespace" {
  default = "timeapi-namespace"
}

variable "domain" {
  default = "timeapi.osinachi.me"
  description = "Domain name for the ingress"
}

variable "certmanager_email" {
  description = "Email address used for ACME registration"
}
