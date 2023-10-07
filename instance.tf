# resource "google_compute_instance" "gcp_instance" {
#   name         = "gke-cluster-vm-instance"
#   machine_type = "e2-micro"
#   zone         = data.google_compute_zones.available_zones.names[0]

#   boot_disk {
#     initialize_params {
#       image = "ubuntu-os-cloud/ubuntu-2204-lts"
#     }
#   }

#   network_interface {
#     network    = google_compute_network.gcp_vpc.name
#     subnetwork = google_compute_subnetwork.gcp_subnet.name
#     access_config {
#       nat_ip = google_compute_address.external_ip.address
#     }
#   }
# }