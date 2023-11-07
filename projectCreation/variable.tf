variable "region" {
  default = "us-east1"
}

variable "organization_id" {
  default = "561135202163"
}

output "project_id" {
  value       = google_project.gke-project.project_id
  depends_on  = [google_project.gke-project]
}