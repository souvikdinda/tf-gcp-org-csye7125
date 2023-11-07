terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.0.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.11.0"
    }
  }
}

provider "google" {
  region = var.region
}


provider "helm" {
  kubernetes {
    config_path = google_container_cluster.gke_cluster.master_auth[0].client_certificate
    host       = "https://${google_container_cluster.gke_cluster.endpoint}"
    token      = google_container_cluster.gke_cluster.master_auth[0].client_key
    cluster_ca_certificate = google_container_cluster.gke_cluster.master_auth[0].cluster_ca_certificate
  }

}