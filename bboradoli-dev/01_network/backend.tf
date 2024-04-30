## Provider, Region Config
# provider "google" {
# }

provider "google" {
  # credentials = "${file("ko-dev-prj-terraform.json")}"
  # project     = "ko-dev-prj"
  # region      = "asia-northeast3"
}

## Backend GCS 사용시 사용

#terraform {
# backend "gcs" {
#   bucket  = "gcs-dep-dev"
#   prefix  = "terraform"
# }
#}
