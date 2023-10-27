# 

# GKE Cluster and Node Pool
resource "google_container_cluster" "gke_cluster" {
  name     = "my-gke-cluster"
  location = var.region
  project  = google_project.gke-project.project_id
  network  = google_compute_network.gcp_vpc.name
  subnetwork = google_compute_subnetwork.private_gcp_subnet.self_link
  deletion_protection = false

  # Retrieve available zones for the specified region
  node_locations = data.google_compute_zones.available_zones.names

  private_cluster_config {
    enable_private_nodes = true
    master_ipv4_cidr_block = var.master_ipv4_cidr_block
  }

  node_pool {
    name       = "my-node-pool"
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
      image_type   =  "COS_CONTAINERD"
      disk_type =  var.node_disk_type
      //service_account = 
      
    }

  }

  binary_authorization {
    evaluation_mode = "PROJECT_SINGLETON_POLICY_ENFORCE"
  }

  workload_identity_config {
    workload_pool = "${google_project.gke-project.project_id}.svc.id.goog"
  }
  depends_on = [google_project.gke-project]
}



 