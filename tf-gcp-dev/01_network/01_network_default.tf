###################################################################
##      Network 기본 구성                                        ##
##      - Router                                                 ##
##      - Routes                                                 ##
##      - Subnet > dmz or gateway 용 기본 1개                    ##
##      - NAT                                                    ##
###################################################################


# Host Project VPC create & Setup
module "shared_vpc" {
  source                  = "./modules/00_vpc"
  vpc_name                = var.vpc_name
  host_project_id         = var.host_project_id
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode
  mtu                     = var.mtu
  psc_name                = var.psc_name
  psc_address             = var.psc_address
  psc_address_prefix      = var.psc_address_prefix
}

# Cloud Router / GCP - Host_Project
module "cloud_router" {
  source          = "./modules/01_cloud_router"
  network_path    = local.network_path
  host_project_id = var.host_project_id
  region          = var.region
  router_name     = "${local.pre_fix}-host-rou-internet"

depends_on = [module.shared_vpc]
}

# Routes
module "routes" {
  source          = "./modules/02_routes"
  host_project_id = var.host_project_id
  network_path    = local.network_path
  routes_name     = "${local.pre_fix}-host-rou-private-googleapis"

  depends_on = [module.cloud_router]
}