# resource "kubernetes_service_account" "my_k8_service_account" {
#   metadata {
#     name = "my-k8-service-account"
#     annotations = {
#       "iam.gke.io/gcp-service-account" = "my-service-account@${google_project.gke-project.project_id}.iam.gserviceaccount.com"
#     }
#   }
# }

# resource "google_project_iam_member" "bind_service_account" {
#   project = google_project.gke-project.project_id
#   role    = "roles/iam.workloadIdentityUser"
#   member  = "serviceAccount:${google_project.gke-project.project_id}.svc.id.goog[default/my-k8-service-account]"
# }
