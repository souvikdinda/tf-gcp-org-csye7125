resource "google_compute_instance" "bastion_instance" {
  name         = "gke-cluster-vm-instance"
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
    access_config {
      nat_ip = google_compute_address.external_ip.address
    }
  }
}