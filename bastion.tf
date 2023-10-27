# Bastion Host
resource "google_compute_instance" "bastion_instance" {
  name         = "bastion-host"
  machine_type = var.bastion_machine_type
  zone         = data.google_compute_zones.available_zones.names[0]
  project      = google_project.gke-project.project_id
  metadata = {
    ssh-keys = "${var.bastion_username}:${file(var.ssh_path)}"
  }


  boot_disk {
    initialize_params {
      image = var.bastion_image
    }
  }

  network_interface {
    network    = google_compute_network.gcp_vpc.name
    subnetwork = google_compute_subnetwork.gcp_subnet.self_link
    access_config {
      nat_ip = google_compute_address.bastion_external_ip.address
    }
  }

  # You may want to customize additional configuration like SSH keys, tags, and startup scripts.
}


