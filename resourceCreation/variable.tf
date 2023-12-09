variable "region" {
  default = "us-east1"
}

variable "project_id" {
  default = "csye7125-gke-f8c10e6f"
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
  default = 1
}

variable "max_node_count" {
  default = 2
}

variable "node_machine_type" {
  default = "n2-standard-2"
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
  default = "~/.ssh/my-key.pem.pub"
}

variable "bastion_username" {
  default = "vaishnavi"
}

variable "bastion_host_ip" {
  default = "10.0.1.1/32"
}

variable "jenkins_ip" {
  default = "54.198.138.212/32"
}