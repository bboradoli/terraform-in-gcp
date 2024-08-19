###############################################################################
##        Network 기본 구성                                                  ##
##        - Subnet                                                           ##
##  *.auto.tfvars 변수파일에서 사용 할 Subnet작성                            ##
###############################################################################

# Subnets
module "subnets" {
  source          = "./modules/03_subnets"
  host_project_id = var.host_project_id
  network_path    = local.network_path

  subnets = var.subnet_data
  secondary_ranges = var.subnet_data_secondary

  depends_on = [module.routes]
}

# Nat
module "nat" {
  source          = "./modules/04_nat"
  host_project_id = var.host_project_id
  region          = var.region
  router_name     = "${local.pre_fix}-host-rou-internet"     # 임시 Router Name 수기 입력 > 상위 Cloud Router output 변수로 변경 필요
  #nat_id          = "${local.pre_fix}-host-eip-nat-an3"
  nat_id          = var.nat_id
  nat_ip_id       = var.nat_ip_id
  nat_subnet      = var.nat_subnet
  
  depends_on = [module.subnets]
}