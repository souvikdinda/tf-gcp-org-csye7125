variable "region" {
  default = "us-east1"
}

data "google_compute_zones" "available_zones" {
  region     = var.region
  project    = google_project.gke-project.project_id
  depends_on = [google_project_service.compute]
}

variable "cidr_range" {
  default = "10.0.0.0/16"
}

variable "organization_id" {
  default = "348071969093"
}

variable "instance_image" {
  default = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "instance_type" {
  default = "e2-micro"
}