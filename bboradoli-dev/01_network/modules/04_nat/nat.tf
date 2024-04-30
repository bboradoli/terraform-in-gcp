/*************************************************
	!!! nat mapping subnet >> 현재 static 보완필요
 ************************************************/

variable "host_project_id" {}
variable "region" {}
variable "router_name" {}
variable "nat_id" {}
variable "nat_ip_id" {}
variable "nat_subnet" {}


resource "google_compute_address" "nat-ip" {
  name         = var.nat_ip_id
  address_type = "EXTERNAL"
  region       = var.region
  project      = var.host_project_id
}

resource "google_compute_router_nat" "nat" {
  name                   = var.nat_id
  router                 = var.router_name
  region                 = var.region
  nat_ip_allocate_option = "MANUAL_ONLY"
  nat_ips                = google_compute_address.nat-ip.*.self_link
  min_ports_per_vm       = "32"
  enable_endpoint_independent_mapping = false
  project = var.host_project_id

  #  enable_dynamic_port_allocation = true  # not support
  #  max_ports_per_vm = "65535"             # not support

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
 
 # hardcoding 변수화 필요
  subnetwork {
    name                    = "adw-d-sub-data-an3-001"
    source_ip_ranges_to_nat = ["172.21.80.0/24"]
  }
  

}