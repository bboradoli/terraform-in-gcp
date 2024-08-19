###############################################################################
##        Network 기본 구성                                                  ##
##        - Firwall                                                          ##
##  현재 위치에서 Firewall 항목 작성                                         ##
###############################################################################

# Firewall-Rules
module "firewall_rules" {
  source          = "./modules/06_firewall"
  host_project_id = var.host_project_id
  network_name    = local.network_path

  # Firewall init Fixed
  rules = [
    {
       name                    = "${local.pre_fix}-fw-common-out-deny-all"
       description             = "[${var.project_name}-FW-Rule] - VPC의 VM들에서 외부로 나가는 Egress 트래픽 전부 차단(Deny ALL)"
       network                 = "${local.network_path}"
       direction               = "EGRESS"
       priority                = "65534"
       target_tags             = []
       source_tags             = null
       source_service_accounts = null
       target_service_accounts = null
       ranges                  = ["0.0.0.0/0"]
       allow                   = []
       deny       = [
         {
           protocol = "all"
           ports    = []
         }        
       ]
       log_config = null
     },

    {
       name                    = "${local.pre_fix}-fw-internal-out-allow"
       description             = "[${var.project_name}-FW-Rule] - VPC의 VM 간 및 GCP 내부 서비스 VM 간 Internal 통신을 위한 Egress 트래픽 허용"
       network                 = "${local.network_path}"
       direction               = "EGRESS"
       priority                = "60000"
       target_tags             = []
       source_tags             = null
       source_service_accounts = null
       target_service_accounts = null
       ranges                  = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16", "224.0.0.252/32", "72.16.65.0/26"]
       allow                   = [
         {
           "protocol": "TCP",
           "ports": ["1-65535"]
         },
         {
           "protocol": "UDP",
           "ports": ["1-65535"]
         }  
       ]
       deny       = []       
       log_config = null
     },

    {
       name                    = "${local.pre_fix}-fw-googleapi-out-allow"
       description             = "[${var.project_name}-FW-Rule] - VPC의 VM에서 Google Cloud API 호출을 위한 Egress IP 대역 허용"      
       network                 = "${local.network_path}"
       direction               = "EGRESS"
       priority                = "1000"
       target_tags             = []
       source_tags             = null
       source_service_accounts = null
       target_service_accounts = null
       ranges                  = ["199.36.153.8/30"]
       allow                   = [
         {
           protocol = "tcp"
           ports    = ["443", "80"]
         }
       ]
       deny       = []
       log_config = null
     },

    {
       name                    = "${local.pre_fix}-fw-healthcheck-in-allow"
       description             = "[${var.project_name}-FW-Rule] - k8s-pod-healthcheck"      
       network                 = "${local.network_path}"
       direction               = "INGRESS"
       priority                = "1000"
       target_tags             = ["${local.pre_fix}-net-data-composer", "${local.pre_fix}-net-service-gke", "${local.pre_fix}-net-ce-deploy"]
       source_tags             = null
       source_service_accounts = null
       target_service_accounts = null
       ranges                  = ["35.191.0.0/16", "209.85.204.0/22", "209.85.152.0/22", "130.211.0.0/22"]
       allow                   = [
         {
           protocol = "tcp"
           ports    = ["80", "443", "3001", "8080", "10080", "10443"]
         }
       ]
       deny       = []
       log_config = null
     }, 

    {
       name                    = "${local.pre_fix}-fw-gw-in-allow-2022"
       description             = "[${var.project_name}-FW-Rule] - Bastion VM SSH 접속 Ingress 통신허용"
       network                 = "${local.network_path}"
       direction               = "INGRESS"
       priority                = "1000"
       target_tags             = ["${local.pre_fix}-net-ce-gw-common"]
       source_tags             = null
       source_service_accounts = null
       target_service_accounts = null
       ranges                  = ["211.109.75.122/32", "125.129.85.172/32"]
       allow                   = [
         {
           "protocol": "TCP",
           "ports": ["2022"]
         }
       ]
       deny       = []
       log_config = null
     },   

    {
       name                    = "${local.pre_fix}-fw-ssh-in-allow-20022"
       description             = "[${var.project_name}-FW-Rule] - VM 에서 Gateway 의 SSH 접근 Ingress 허용"
       network                 = "${local.network_path}"
       direction               = "INGRESS"
       priority                = "1000"
       target_tags             = ["${local.pre_fix}-net-ce-common-cli", "${local.pre_fix}-net-ce-deploy"]
       source_tags             = ["${local.pre_fix}-net-ce-gw-common"]
       source_service_accounts = null
       target_service_accounts = null
       ranges                  = []
       allow                   = [
         {
           "protocol": "TCP",
           "ports": ["20022"]
         }
       ]
       deny       = []
       log_config = null
     },   

  ]
  depends_on = [module.dns]
}  