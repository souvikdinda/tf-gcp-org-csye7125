resource "google_compute_instance" "bastion_instance" {
  name         = "bastion-instance"
  machine_type = var.instance_type
  zone         = data.google_compute_zones.available_zones.names[0]
  project      = google_project.gke-project.project_id
  metadata = {
    ssh-keys = "${var.bastion_username}:${file(var.ssh_path)}"
  }
  boot_disk {
    initialize_params {
      image = var.instance_image
    }
  }
  network_interface {
    network    = google_compute_network.gcp_vpc.name
    subnetwork = google_compute_subnetwork.gcp_subnet.self_link
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    sudo apt-get update
    sudo apt-get install kubectl
    sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    EOF
}