##### 01_network_default <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
## Project
project_name        = "adw" # project_name == pre_fix
region              = "asia-northeast3"
zone_type           = "private"
host_project_id     = "ko-dev-prj" # vpc network project full name
host_project_number = "{}" # Example
env = "dev" # Environment : dev or stg or prd


## Network
# vpc : host vpc생성 및 Shared VPC설정
vpc_name = "adw-d-host-vpc"
routing_mode = "REGIONAL"
auto_create_subnetworks = "false"
mtu = 1460

# PRIVATE_SERVICE_CONNECTION
psc_name = "adw-d-psc-gcp"
psc_address = "10.28.112.0" 
psc_address_prefix = 24

##### 02_network_subnet_nat <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

# SubnetMask
subnet_data = [
    # vm용 Subnet
    {
        subnet_name           = "adw-d-sub-dmz-an3"
        subnet_ip             = "172.21.10.0/26"
        subnet_region         = "asia-northeast3"
        subnet_private_access = "true"
        subnet_flow_logs      = "false"
        description           = "Scouter DMZ(Gateway) subnet"  
    }    
    ,{
        subnet_name           = "adw-d-sub-cli-an3"
        subnet_ip             = "172.21.11.0/24"
        subnet_region         = "asia-northeast3"
        subnet_private_access = "true"
        subnet_flow_logs      = "false"
        description           = "Scouter cli subnet"  
    }
    # GKE용 Subnet
    ,{
        subnet_name           = "adw-d-sub-service-an3-001"
        subnet_ip             = "172.21.90.0/24"
        subnet_region         = "asia-northeast3"
        subnet_private_access = "true"
        subnet_flow_logs      = "false"
        description           = "Scouter Service Proejct GKE"        
    }
    ,{
        subnet_name           = "adw-d-sub-data-an3-001"
        subnet_ip             = "172.21.80.0/24"
        subnet_region         = "asia-northeast3"
        subnet_private_access = "true"
        subnet_flow_logs      = "false"
        description           = "Scouter Data Proejct Composer"
    }    
]

# GKE용 Subnet Secondary Ranges
subnet_data_secondary = {
        adw-d-sub-service-an3-001 = [
            {
                range_name    = "gke-pod"
                ip_cidr_range = "10.190.0.0/18"
            },
            {
                range_name    = "gke-service"     
                ip_cidr_range = "10.90.32.0/20"
            }   
        ],
        adw-d-sub-data-an3-001 = [
            {
                range_name    = "composer-pod"
                ip_cidr_range = "10.180.0.0/18"
            },
            {
                range_name    = "composer-service"     
                ip_cidr_range = "10.80.32.0/20"
            }   
        ],        
}

# Nat : NAT에 사용 할 서브넷 받아서 넘길 수 있도록 개선 필요*******
nat_id = "adw-d-host-nat-an3"
nat_ip_id = "adw-d-host-eip-nat-an3"


##### 03_network_dns <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# 자동Pass local.pre_fix  == "adw-d-" DNS항목은 DNS Module에 기본항목 정의


##### 04_network_firewall<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
# project_name 변수로 고정방화벽 생성