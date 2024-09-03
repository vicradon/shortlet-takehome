output "region" {
  value       = var.region
  description = "GCloud Region"
}

output "project_id" {
  value       = var.project_id
  description = "GCloud Project ID"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "GKE Cluster Name"
}

output "kubectl_configuration_command" {
  value = "gcloud container clusters get-credentials ${google_container_cluster.primary.name} --zone ${var.region} --project ${var.project_id}"
  description = "The configuration command of gcloud run"
}