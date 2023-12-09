# GKE Cluster and Node Pool
resource "google_container_cluster" "gke_cluster" {
  name                = "my-gke-cluster"
  location            = var.region
  project             = var.project_id
  network             = google_compute_network.gcp_vpc.name
  subnetwork          = google_compute_subnetwork.gcp_subnet.self_link
  deletion_protection = false
  network_policy {
    enabled = true
  }
  # Retrieve available zones for the specified region
  node_locations = data.google_compute_zones.available_zones.names

  private_cluster_config {
    enable_private_nodes    = false
    enable_private_endpoint = false
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "${google_compute_instance.bastion_instance.network_interface[0].network_ip}/32"
      display_name = "master-authorized-networks"
    }
    cidr_blocks {
    cidr_block   = var.jenkins_ip
    display_name = "jenkins-server"
  }
  }


  node_pool {
    name               = "node-pool"
    initial_node_count = var.node_count
    autoscaling {
      min_node_count = var.min_node_count
      max_node_count = var.max_node_count
    }
    management {
      auto_repair  = true
      auto_upgrade = true
    }
    node_config {
      machine_type = var.node_machine_type
      disk_size_gb = var.node_disk_size_gb
      image_type   = "COS_CONTAINERD"
      disk_type    = var.node_disk_type

    }

  }

  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "cpu"
      minimum       = 1
      maximum       = 8
    }
    resource_limits {
      resource_type = "memory"
      minimum       = 1
      maximum       = 8
    }
  }

  binary_authorization {
    evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}