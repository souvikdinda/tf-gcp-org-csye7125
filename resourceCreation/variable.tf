variable "region" {
  default = "us-east1"
}

variable "project_id" {
  default = ""
}

data "google_compute_zones" "available_zones" {
  region     = var.region
  project    = var.project_id
}

variable "cidr_range" {
  default = "10.0.0.0/16"
}

variable "instance_image" {
  default = "debian-12-bookworm-v20231010"
}

variable "instance_type" {
  default = "e2-micro"
}

variable "node_count" {
  default = 1
}

variable "min_node_count" {
  default = 3
}

variable "max_node_count" {
  default = 6
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

variable "master_ipv4_cidr_block" {
  default = "10.10.0.0/28"
}

variable "node_disk_type" {
  default = "pd-standard"
}

variable "ssh_path" {
  default = ""
}

variable "bastion_username" {
  default = ""
}

# variable "github_repo" {
#   default = ""
# }

# variable "github_username" {
#   default = ""
# }

# variable "github_token" {
#   default = ""
# }

# variable "helm_chart_version" {
#   default = "1.1.0"
# }