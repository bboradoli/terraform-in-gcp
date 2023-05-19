## Terraform in GCP(Google Cloud Platform)
  Shared VPC 기반의 Terraform Foundation
- VPC + Default Network Setting.

#### Host Project 초기세팅
```shell      
* 요약           
- 기본 입력 변수항목에 대해서는 "dev.auto.tfvars"를 활용하여 입력값 사용.
- DNS, Subnet에 대해서는 초기 고정항목으로 사용.
    - 항목 추가에 대해서는 DNS, Subnet 각 위치를 참고하여 추가함.
        - DNS    : ./01_network/05_dns/dns.tf > Resource항목에 고정된 형태로 항목 정의.
            > 해당 항목도 Subnet과 같이 상위 1단계 상향 필요(Resource를 변경하지 않는 형태로.)
        - Subnet : ./04_network_firewall.tf > Suite항목에 고정된 형태로 항목 정의.
        
```


#### **사전 필요 작업**
```
- terraform수행 계정에 필요한 권한 부여
    - Shared VPC 설정시 Folder레벨에 "Compute Shared VPC Admin" IAM권한 필요.
-  GCP Api ON
    1. Compute Engine API          / compute.googleapis.com
    2. Cloud Resource Manager API  / cloudresourcemanager.googleapis.com
    3. Service Networking API      / servicenetworking.googleapis.com
```

#### **Tree**
```
📦scouter-dev
 ┗ 📂01_network
 ┃ ┣ 📂modules                      --> Terraform Modules
 ┃ ┃ ┣ 📂00_vpc
 ┃ ┃ ┃ ┗ 📜vpc.tf
 ┃ ┃ ┣ 📂01_cloud_router
 ┃ ┃ ┃ ┗ 📜cloud-router.tf
 ┃ ┃ ┣ 📂02_routes
 ┃ ┃ ┃ ┗ 📜routes.tf
 ┃ ┃ ┣ 📂03_subnets
 ┃ ┃ ┃ ┗ 📜subnets.tf
 ┃ ┃ ┣ 📂04_nat
 ┃ ┃ ┃ ┗ 📜nat.tf
 ┃ ┃ ┣ 📂05_dns
 ┃ ┃ ┃ ┗ 📜dns.tf
 ┃ ┃ ┗ 📂06_firewall
 ┃ ┃ ┃ ┗ 📜firewall.tf
 ┃ ┣ 📜.terraform.lock.hcl
 ┃ ┣ 📜01_network_default.tf        --> VPC(Shared VPC) + Cloud Router + Cloud Routes
 ┃ ┣ 📜02_network_subnet_nat.tf     --> Subnet + NAT
 ┃ ┣ 📜03_network_dns.tf            --> DNS
 ┃ ┣ 📜04_network_firewall.tf       --> Firewall
 ┃ ┣ 📜backend.tf
 ┃ ┣ 📜dev.auto.tfvars              --> Project Parameter 통합
 ┃ ┗ 📜var.tf                       --> Terraform 변수정의 파일
 ```
