variable "gcp_project_id" {
  type        = string
  description = "The GCP project ID"
  default     = "special-tf-prod"
}

variable "region" {
  type        = string
  description = "The GCP region"
  default     = "us-central1"
}

variable "node_locations" {
  type        = list(string)
  description = "The locations of the nodes"
  default     = ["us-central1-a", "us-central1-c"]
}
 
variable "network_name" {
  type        = string
  description = "The name of the VPC network"
  default     = "puree-vessl-vpc"
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
  default     = "puree-vessl-cluster-us-central1"
}

variable "cluster_version" {
  type        = string
  description = "The version of the cluster"
  default     = "1.27"
}
