###############################################################################
##        Network 기본 구성                                                  ##
##        - DNS                                                              ##
##  * DNS항목 Module Fix > 추후 앞단(현재위치)으로 설정 가능하도록 변경 필요 ##
###############################################################################

module "dns" {
  source = "./modules/05_dns"

  dns             = "${local.pre_fix}-host-private-dns-" # 입력필요
  zone_type       = var.zone_type     # Default "private"
  host_project_id = var.host_project_id
  network_url     = local.network_path

  depends_on = [module.nat]
}