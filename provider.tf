terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.0.0"
    }
  }
}


provider "google" {
  credentials = file("~/.ssh/csye7125-gke-401204-ad73564f15f8.json")
  project     = var.project_id
  region      = var.region
}