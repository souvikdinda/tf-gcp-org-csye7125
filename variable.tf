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
  default = "561135202163"
}

variable "instance_image" {
  default = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "instance_type" {
  default = "e2-micro"
}

variable "node_count" {
  default = 3
}

variable "min_node_count" {
  default = 1
}

variable "max_node_count" {
  default = 5
}

variable "node_machine_type" {
  default = "e2-medium"
}


variable "node_disk_size_gb" {
  default = 50
}

variable "image_type" {
  default = "COS"
}
variable "bastion_machine_type" {
  default = "n1-standard-1"
}

variable "bastion_image" {
  default = "ubuntu-os-cloud/ubuntu-2204-lts"
}

variable "master_ipv4_cidr_block" {
  default = "10.1.0.0/28"
}

variable "bastion_username" {
  default = "vaishnavi"
}

variable "project_id" {
  default = "google_project.gke-project.project_id"
}

variable "billing_account" {
  default = "01DC80-2995F5-3FF285"
}
variable "node_disk_type" {
  default = "pd-standard"
}