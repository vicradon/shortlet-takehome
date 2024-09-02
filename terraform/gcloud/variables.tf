variable "project_id" {
  type    = string
  default = "shortlet-takehome"
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable secondary_range_1 {
  type        = string
  default     = "subnet-01-secondary-01"
}

variable secondary_range_2 {
  type        = string
  default     = "subnet-01-secondary-02"
}

variable cluster_name {
  type        = string
  default     = "shortlet-k8s-cluster"
}
