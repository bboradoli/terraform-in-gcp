## Provider, Region Config
provider "google" {
}


## Backend GCS 사용시 사용

terraform {
 backend "gcs" {
   bucket  = "ksh-tf-state"
   prefix  = "dev"
 }
}
