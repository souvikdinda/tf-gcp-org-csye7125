# Main VPC for GKE Cluster
resource "google_compute_network" "gcp_vpc" {
  name                    = "gke-cluster-vpc"
  auto_create_subnetworks = false
  project                 = var.project_id
}

# Public Subnet
resource "google_compute_subnetwork" "gcp_subnet" {
  name                     = "public-subnet"
  ip_cidr_range            = cidrsubnet(var.cidr_range, 8, 1)
  region                   = var.region
  network                  = google_compute_network.gcp_vpc.id
  private_ip_google_access = true
  project                  = var.project_id
}


# Private Subnet
resource "google_compute_subnetwork" "private_gcp_subnet" {
  name                     = "private-subnet"
  ip_cidr_range            = cidrsubnet(var.cidr_range, 8, 2)
  region                   = var.region
  network                  = google_compute_network.gcp_vpc.id
  private_ip_google_access = true
  project                  = var.project_id
}


# Firewall rules that allows traffic from anywhere for SSH, HTTP, HTTPs
resource "google_compute_firewall" "main_vpc_firewall" {
  name    = "main-vpc-firewall"
  network = google_compute_network.gcp_vpc.name
  project = var.project_id

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
  project    = var.project_id
  # depends_on = [google_project_service.compute]
}

# Router for above subnet
resource "google_compute_router" "main_router" {
  name    = "main-router"
  network = google_compute_network.gcp_vpc.id
  project = var.project_id
  bgp {
    asn               = 64514
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
  }
}

# Map above created router to the subnet
resource "google_compute_router_interface" "subnet_interface" {
  name       = "pub-subnet-router-interface"
  router     = google_compute_router.main_router.name
  project    = var.project_id
  region     = var.region
  subnetwork = google_compute_subnetwork.gcp_subnet.self_link
}

resource "google_compute_router" "pvt_router" {
  name    = "pvt-router"
  network = google_compute_network.gcp_vpc.id
  project = var.project_id
}

# Map above created router to the subnet
resource "google_compute_router_interface" "pvt_subnet_interface" {
  name       = "pvt-subnet-router-interface"
  router     = google_compute_router.pvt_router.name
  project    = var.project_id
  region     = var.region
  subnetwork = google_compute_subnetwork.private_gcp_subnet.self_link
}


# NAT Gateway for private subnets
resource "google_compute_router_nat" "nat_gateway" {
  project                            = var.project_id
  name                               = "nat-gateway1"
  router                             = google_compute_router.pvt_router.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
    name                    = google_compute_subnetwork.private_gcp_subnet.name
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
}

