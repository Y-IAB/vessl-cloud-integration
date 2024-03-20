resource "google_project_service" "google_container_api" {
  project            = var.gcp_project_id
  service            = "container.googleapis.com"
  disable_on_destroy = false
}

# -----------
# VPC Network
# -----------
module "gcp_vpc_network" {
  source = "github.com/vessl-ai/vessl-cloud-integration//modules/gcp-vpc-network?ref=0.1.1"

  gcp_project_id = var.gcp_project_id
  name           = var.network_name
  region         = var.region
}

# ---------------------------
# GKE Cluster (control plane)
# ---------------------------
module "gke_cluster" {
  depends_on = [google_project_service.google_container_api]
  source     = "../../modules/gke-cluster"

  gcp_project_id  = var.gcp_project_id
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  location         = var.region
  node_locations   = var.node_locations
  vpc_network_name = module.gcp_vpc_network.network_name
}

# ---------------------------
# GKE Node Pool (worker node)
# ---------------------------
module "gke_node_pool_cpu" {
  depends_on = [google_project_service.google_container_api]
  source     = "../../modules/gke-node-pool"

  gcp_project_id = var.gcp_project_id
  location       = var.region
  node_locations = var.node_locations

  name            = "node-pool-cpu"
  cluster_name    = module.gke_cluster.cluster_name
  cluster_version = var.cluster_version

  preemptible    = true
  machine_type   = "e2-medium"
  min_node_count = 1
  max_node_count = 5
  gpu = null
}

module "gke_node_pool_a100_40g_1" {
  depends_on = [google_project_service.google_container_api]
  source     = "../../modules/gke-node-pool"

  gcp_project_id = var.gcp_project_id
  location       = var.region
  node_locations = var.node_locations

  name            = "node-pool-a100-40g-1"
  cluster_name    = module.gke_cluster.cluster_name
  cluster_version = var.cluster_version

  preemptible    = true
  machine_type   = "a2-highgpu-1g"
  disk_size_gb   = 5000
  min_node_count = 0
  max_node_count = 5
  gpu = {
    type = "nvidia-tesla-a100"
    count = 1
  }
}

module "gke_node_pool_a100_40g_2" {
  depends_on = [google_project_service.google_container_api]
  source     = "../../modules/gke-node-pool"

  gcp_project_id = var.gcp_project_id
  location       = var.region
  node_locations = var.node_locations

  name            = "node-pool-a100-40g-2"
  cluster_name    = module.gke_cluster.cluster_name
  cluster_version = var.cluster_version

  preemptible    = true
  machine_type   = "a2-highgpu-2g"
  disk_size_gb   = 5000
  min_node_count = 0
  max_node_count = 5
  gpu = {
    type = "nvidia-tesla-a100"
    count = 2
  }
}

module "gke_node_pool_a100_40g_4" {
  depends_on = [google_project_service.google_container_api]
  source     = "../../modules/gke-node-pool"

  gcp_project_id = var.gcp_project_id
  location       = var.region
  node_locations = var.node_locations

  name            = "node-pool-a100-40g-4"
  cluster_name    = module.gke_cluster.cluster_name
  cluster_version = var.cluster_version

  preemptible    = true
  machine_type   = "a2-highgpu-4g"
  disk_size_gb   = 5000
  min_node_count = 0
  max_node_count = 5
  gpu = {
    type = "nvidia-tesla-a100"
    count = 4
  }
}

module "gke_node_pool_a100_40g_8" {
  depends_on = [google_project_service.google_container_api]
  source     = "../../modules/gke-node-pool"

  gcp_project_id = var.gcp_project_id
  location       = var.region
  node_locations = var.node_locations

  name            = "node-pool-a100-40g-8"
  cluster_name    = module.gke_cluster.cluster_name
  cluster_version = var.cluster_version

  preemptible    = true
  machine_type   = "a2-highgpu-8g"
  disk_size_gb   = 5000
  min_node_count = 0
  max_node_count = 5
  gpu = {
    type = "nvidia-tesla-a100"
    count = 8
  }
}

module "gke_node_pool_a100_40g_16" {
  depends_on = [google_project_service.google_container_api]
  source     = "../../modules/gke-node-pool"

  gcp_project_id = var.gcp_project_id
  location       = var.region
  node_locations = var.node_locations

  name            = "node-pool-a100-40g-16"
  cluster_name    = module.gke_cluster.cluster_name
  cluster_version = var.cluster_version

  preemptible    = true
  machine_type   = "a2-megagpu-16g"
  disk_size_gb   = 5000
  min_node_count = 0
  max_node_count = 5
  gpu = {
    type = "nvidia-tesla-a100"
    count = 16
  }
}

module "gke_node_pool_h100_80g_8" {
  depends_on = [google_project_service.google_container_api]
  source     = "../../modules/gke-node-pool"

  gcp_project_id = var.gcp_project_id
  location       = var.region
  node_locations = var.node_locations

  name            = "node-pool-h100-80g-8"
  cluster_name    = module.gke_cluster.cluster_name
  cluster_version = var.cluster_version

  preemptible    = true
  machine_type   = "a3-highgpu-8g"
  disk_size_gb   = 5000
  min_node_count = 0
  max_node_count = 5
  gpu = {
    type = "nvidia-h100-80gb"
    count = 8
  }
}

module "gke_node_pool_a100_80g_1" {
  depends_on = [google_project_service.google_container_api]
  source     = "../../modules/gke-node-pool"

  gcp_project_id = var.gcp_project_id
  location       = var.region
  node_locations = var.node_locations

  name            = "node-pool-a100-80g-1"
  cluster_name    = module.gke_cluster.cluster_name
  cluster_version = var.cluster_version

  preemptible    = true
  machine_type   = "a2-ultragpu-1g"
  disk_size_gb   = 5000
  min_node_count = 0
  max_node_count = 5
  gpu = {
    type = "nvidia-a100-80gb"
    count = 1
  }
}

module "gke_node_pool_a100_80g_2" {
  depends_on = [google_project_service.google_container_api]
  source     = "../../modules/gke-node-pool"

  gcp_project_id = var.gcp_project_id
  location       = var.region
  node_locations = var.node_locations

  name            = "node-pool-a100-80g-2"
  cluster_name    = module.gke_cluster.cluster_name
  cluster_version = var.cluster_version

  preemptible    = true
  machine_type   = "a2-ultragpu-2g"
  disk_size_gb   = 5000
  min_node_count = 0
  max_node_count = 5
  gpu = {
    type = "nvidia-a100-80gb"
    count = 2
  }
}


module "gke_node_pool_a100_80g_4" {
  depends_on = [google_project_service.google_container_api]
  source     = "../../modules/gke-node-pool"

  gcp_project_id = var.gcp_project_id
  location       = var.region
  node_locations = var.node_locations

  name            = "node-pool-a100-80g-4"
  cluster_name    = module.gke_cluster.cluster_name
  cluster_version = var.cluster_version

  preemptible    = true
  machine_type   = "a2-ultragpu-4g"
  disk_size_gb   = 5000
  min_node_count = 0
  max_node_count = 5
  gpu = {
    type = "nvidia-a100-80gb"
    count = 4
  }
}

module "gke_node_pool_a100_80g_8" {
  depends_on = [google_project_service.google_container_api]
  source     = "../../modules/gke-node-pool"

  gcp_project_id = var.gcp_project_id
  location       = var.region
  node_locations = var.node_locations

  name            = "node-pool-a100-80g-8"
  cluster_name    = module.gke_cluster.cluster_name
  cluster_version = var.cluster_version

  preemptible    = true
  machine_type   = "a2-ultragpu-8g"
  disk_size_gb   = 5000
  min_node_count = 0
  max_node_count = 5
  gpu = {
    type = "nvidia-a100-80gb"
    count = 8
  }
}


# ----------------------------------------------------
# Kubernetes addons
# e.g. alb controller, autoscaler, cluster agent, etc.
# ----------------------------------------------------
# module "addons_gcp_nvidia_driver_installer" {
#  source = "github.com/vessl-ai/vessl-cloud-integration//modules/kubernetes-addons/gcp-nvidia-driver-installer?ref=0.1.1"
# 
#   cluster_name = var.cluster_name
#   region       = var.region
# }
