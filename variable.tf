variable "region" {
  default = "us-east1"
}

# data "google_compute_zones" "available_zones" {
#   region = var.region
#   project = google_project.gke-project.id
# }
