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
       name                    = "${local.pre_fix}-host-sec-common-out-deny-all"
       description             = "[SEC-${var.project_name}-FW-Rule] - VPC의 VM들에서 외부로 나가는 Egress 트래픽 전부 차단(Deny ALL)"
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
       name                    = "${local.pre_fix}-host-sec-internal-out-allow"
       description             = "[SEC-${var.project_name}-FW-Rule] - VPC의 VM 간 및 GCP 내부 서비스 VM 간 Internal 통신을 위한 Egress 트래픽 허용"
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
       name                    = "${local.pre_fix}-host-sec-googleapi-out-allow"
       description             = "[SEC-${var.project_name}-FW-Rule] - VPC의 VM에서 Google Cloud API 호출을 위한 Egress IP 대역 허용"      
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
       name                    = "${local.pre_fix}-host-sec-healthcheck-in-allow"
       description             = "[SEC-${var.project_name}-FW-Rule] - k8s-pod-healthcheck"      
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
       name                    = "${local.pre_fix}-host-sec-ipa-out-allow"
       description             = "[SEC-${var.project_name}-FW-Rule] - IPA 연동을 위한 Egress 통신 허용"      
       network                 = "${local.network_path}"
       direction               = "EGRESS"
       priority                = "1000"
       target_tags             = ["${local.pre_fix}-net-ce-common"]
       source_tags             = null
       source_service_accounts = null
       target_service_accounts = null
       ranges                  = ["34.85.42.35/32", "35.200.48.194/32", "35.245.90.128/32", "35.234.106.238/32", "34.86.86.44/32", "34.107.77.241/32", "34.64.73.246/32", "35.190.24.74/32", "34.84.73.136/32"]
       allow                   = [
         {
           "protocol": "TCP",
           "ports": ["80", "88", "389", "443", "464", "636", "5044"]
         },
         {
           "protocol": "UDP",
           "ports": ["88", "123", "464"]
         }      
       ]
       deny       = []
       log_config = null
     },     

    {
       name                    = "${local.pre_fix}-host-sec-gw-in-allow-2022"
       description             = "[SEC-${var.project_name}-FW-Rule] - 사업장에서 Gateway VM SSH 접속 Ingress 통신허용"
       network                 = "${local.network_path}"
       direction               = "INGRESS"
       priority                = "1000"
       target_tags             = ["${local.pre_fix}-net-ce-gw-common"]
       source_tags             = null
       source_service_accounts = null
       target_service_accounts = null
       ranges                  = ["211.189.57.60/32", "210.94.41.89/32", "58.151.93.21/32", "35.190.238.77/32"]
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
       name                    = "${local.pre_fix}-host-sec-dbgw-in-allow-2022"
       description             = "[SEC-${var.project_name}-FW-Rule] - SBC 환경에서 Data Gateway VM SSH 접속 Ingress 통신 허용 (35.190.238.77/32 IPA Webshell)"
       network                 = "${local.network_path}"
       direction               = "INGRESS"
       priority                = "1000"
       target_tags             = ["${local.pre_fix}-net-ce-gw-data"]
       source_tags             = null
       source_service_accounts = null
       target_service_accounts = null
       ranges                  = ["211.189.57.60/32", "210.94.41.89/32", "58.151.93.21/32", "35.190.238.77/32"]
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
       name                    = "${local.pre_fix}-host-sec-ssh-out-allow-20022"
       description             = "[SEC-${var.project_name}-FW-Rule] - Data Gateway VM에서 VM 으로 SSH(20022) Engrss 통신 허용"
       network                 = "${local.network_path}"
       direction               = "EGRESS"
       priority                = "1000"
       target_tags             = ["${local.pre_fix}-net-ce-common"]
       source_tags             = []
       source_service_accounts = null
       target_service_accounts = null
       ranges                  = ["172.21.11.0/24"] ## cli subnet 변수값 받아오기 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
       allow                   = [
         {
           "protocol": "TCP",
           "ports": ["20022"]
         }
       ]
       deny       = []
       log_config = null
     },   

    {
       name                    = "${local.pre_fix}-host-sec-ssh-in-allow-20022"
       description             = "[SEC-${var.project_name}-FW-Rule] - VM 에서 Gateway 의 SSH 접근 Ingress 허용"
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

    {
       name                    = "${local.pre_fix}-host-sec-db-ssh-in-allow-20022"
       description             = "[SEC-${var.project_name}-FW-Rule] - CLI VM 에서 Data Gateway VM의 SSH(20022) Ingress 통신 허용"
       network                 = "${local.network_path}"
       direction               = "INGRESS"
       priority                = "1000"
       target_tags             = ["${local.pre_fix}-net-ce-data-cli"]
       source_tags             = ["${local.pre_fix}-net-ce-gw-data"]
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