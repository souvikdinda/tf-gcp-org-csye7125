resource "google_folder" "gke_cluster_folder" {
  display_name = "my-gke-cluster"
  parent       = "organizations/${var.organization_id}"

}

data "google_billing_account" "acct" {
  display_name = "My Billing Account"
  open         = true
}

resource "google_project" "gke-project" {
  name       = "csye7125-gke-cluster"
  project_id = "csye7125-gke-${substr(uuid(), 0, 8)}"
  folder_id  = google_folder.gke_cluster_folder.id

  billing_account = data.google_billing_account.acct.id

  lifecycle {
    ignore_changes = [project_id]
  }
}

resource "google_project_service" "compute" {
  project = google_project.gke-project.project_id
  service = "compute.googleapis.com"
}

resource "google_service_account" "my_service_account" {
  project      = google_project.gke-project.project_id
  account_id   = "my-service-account"
  display_name = "My Service Account"
}

resource "google_project_iam_member" "my_service_account_roles" {
  project = google_project.gke-project.project_id
  role    = "roles/compute.admin"
  member  = "serviceAccount:${google_service_account.my_service_account.email}"
}

resource "google_project_service" "kubernetes" {
  project = google_project.gke-project.project_id
  service = "container.googleapis.com"
}

resource "google_project_iam_member" "container_admin_roles" {
  project = google_project.gke-project.project_id
  role    = "roles/container.admin" # Or "roles/container.admin" for Kubernetes Engine Admin role
  member  = "serviceAccount:${google_service_account.my_service_account.email}"
}

resource "google_project_iam_member" "iap_access" {
  project = google_project.gke-project.project_id
  role    = "roles/iap.tunnelResourceAccessor"
  member  = "serviceAccount:${google_service_account.my_service_account.email}"
}
