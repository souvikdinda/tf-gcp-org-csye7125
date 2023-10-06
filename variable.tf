variable "region" {
  default = "us-east1"
}

data "google_compute_zones" "available_zones" {
  region = var.region
}

variable "project_id" {
  default = "csye7125-gke-401204"
}