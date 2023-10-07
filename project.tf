resource "google_folder" "gke_cluster_folder" {
  display_name = "my-gke-cluster"
  parent       = "organizations/561135202163"
}

data "google_billing_account" "acct" {
  display_name = "My Billing Account"
  open         = true
}

resource "google_project" "gke-project" {
  name       = "csye7125-gke-cluster"
  project_id = "csye7125-gke-${uuid()}"
  folder_id  = google_folder.gke_cluster_folder.id

  billing_account = data.google_billing_account.acct.id
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

