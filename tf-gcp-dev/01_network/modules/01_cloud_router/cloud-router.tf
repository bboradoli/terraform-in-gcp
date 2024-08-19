# Variables
variable "router_name" {}
variable "network_path" {}
variable "region" {}
variable "host_project_id" {}

# Resource
resource "google_compute_router" "cloud_rou_internet" {
  name    = var.router_name
  network = var.network_path
  region  = var.region
  project = var.host_project_id
}