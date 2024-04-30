variable "host_project_id" {}
variable "vpc_name" {}
variable "mtu" {}
variable "auto_create_subnetworks" {}
variable "routing_mode" {}
variable "psc_name" {}
variable "psc_address" {}
variable "psc_address_prefix" {}

# Host VPC 생성
resource "google_compute_network" "host_vpc_network" {
  name                            = var.vpc_name
  auto_create_subnetworks         = var.auto_create_subnetworks
  routing_mode                    = var.routing_mode
  project                         = var.host_project_id
  #delete_default_routes_on_create = var.delete_default_internet_gateway_routes
  mtu                             = var.mtu
  #description                     = var.description
}

# Host Project 설정 + Shared VPC
#resource "google_compute_shared_vpc_host_project" "host" {
#  project = var.host_project_id
#depends_on = [google_compute_network.host_vpc_network]
#}

# Create an IP address
resource "google_compute_global_address" "private_ip_alloc" {
  project = var.host_project_id
  name          = var.psc_name
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  address       = var.psc_address
  prefix_length = 20
  network       = google_compute_network.host_vpc_network.id
}

# Create a private connection
resource "google_service_networking_connection" "default" {
  network                 = google_compute_network.host_vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]
}

##resource "google_compute_global_address" "private_service_connection" {
##  project       = var.host_project_id
##  name          = var.psc_name
##  region         = "REGIONAL"
##  address_type  = "INTERNAL"
##  purpose       = "PRIVATE_SERVICE_CONNECT"
##  network       = google_compute_network.host_vpc_network.id
##  address       = var.psc_address
##  prefix_length = var.psc_address_prefix
##
##depends_on = [google_compute_shared_vpc_host_project.host]
##}

#variable "service_project_id" {}
#variable "data_project_id" {}

## Service Project 설정 : Data Project
#resource "google_compute_shared_vpc_service_project" "data" {
#  host_project    = google_compute_shared_vpc_host_project.host.project
#  service_project = var.data_project
#}
#
## Data Project 설정 : Data Project
#resource "google_compute_shared_vpc_service_project" "service" {
#  host_project    = google_compute_shared_vpc_host_project.host.project
#  service_project = var.service_project
#}
