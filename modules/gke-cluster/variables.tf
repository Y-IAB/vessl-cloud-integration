variable "gcp_project_id" {
  type        = string
  description = "The GCP project ID"
}

variable "location" {
  type        = string
  description = "The location (region or zone) for the cluster"
}

variable "node_locations" {
  type        = list(string)
  description = "The locations (zones) for the nodes"
  default     = null
}

variable "vpc_network_name" {
  type        = string
  description = "The name of the VPC network"
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster"
}

variable "cluster_version" {
  type        = string
  description = "The version of the cluster"
  default     = "1.23"
}
