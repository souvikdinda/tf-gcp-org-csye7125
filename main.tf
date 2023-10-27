# Main VPC for GKE Cluster
resource "google_compute_network" "gcp_vpc" {
  name                    = "gke-cluster-vpc"
  auto_create_subnetworks = false
  project                 = google_project.gke-project.project_id

  depends_on = [google_project_service.compute]
}

# Public Subnet
resource "google_compute_subnetwork" "gcp_subnet" {
  name                     = "gcp-subnet1"
  ip_cidr_range            = cidrsubnet(var.cidr_range, 8, 0)
  region                   = var.region
  network                  = google_compute_network.gcp_vpc.id
  private_ip_google_access = true
  project                  = google_project.gke-project.project_id
}

# Private Subnet
resource "google_compute_subnetwork" "private_gcp_subnet" {
  name                     = "private-gcp-subnet"
  ip_cidr_range            = cidrsubnet(var.cidr_range, 8, 1)
  region                   = var.region
  network                  = google_compute_network.gcp_vpc.id
  private_ip_google_access = true
  project                  = google_project.gke-project.project_id
}


# Firewall rules that allows traffic from anywhere for SSH, HTTP, HTTPs
resource "google_compute_firewall" "main_vpc_firewall" {
  name    = "main-vpc-firewall"
  network = google_compute_network.gcp_vpc.name
  project = google_project.gke-project.project_id

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]

}

# Assigning External IP Addr
resource "google_compute_address" "external_ip" {
  name       = "external-ip"
  region     = var.region
  project    = google_project.gke-project.project_id
  depends_on = [google_project_service.compute]
}

# # Create route for Route Table for above subnet
# # resource "google_compute_route" "default_route" {
# #   name             = "default-route"
# #   network          = google_compute_network.gcp_vpc.name
# #   dest_range       = "0.0.0.0/0"
# #   next_hop_gateway = google_compute_network.gcp_vpc.self_link
# # }

# Router for above subnet
resource "google_compute_router" "main_router" {
  name    = "main-router"
  network = google_compute_network.gcp_vpc.id
  project = google_project.gke-project.project_id
}

# Map above created router to the subnet
resource "google_compute_router_interface" "subnet_interface" {
  name       = "subnet-interface"
  router     = google_compute_router.main_router.name
  project    = google_project.gke-project.project_id
  region     = var.region
  subnetwork = google_compute_subnetwork.gcp_subnet.self_link
}


# # NAT Gateway for private subnets
# # resource "google_compute_router_nat" "nat_gateway" {
# #   name                               = "nat-gateway"
# #   router                             = google_compute_router.main_router.name
# #   region                             = var.region
# #   nat_ip_allocate_option             = "AUTO_ONLY"
# #   source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
# #   subnetwork {
# #     name                    = google_compute_subnetwork.gcp_subnet.name
# #     source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
# #   }
# #   nat_ips = [google_compute_address.external_ip.address]
# # }


# Assigning External IP Addr
resource "google_compute_address" "bastion_external_ip" {
  name       = "bastion-external-ip"
  region     = var.region
  project    = google_project.gke-project.project_id
  depends_on = [google_project_service.compute]
}