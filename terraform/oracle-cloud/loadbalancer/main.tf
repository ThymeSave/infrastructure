terraform {
  backend "s3" {
    bucket                      = "terraform-state"
    key                         = "oracle-cloud/loadbalancer/terraform.tfstate"
    region                      = "eu-frankfurt-1"
    shared_credentials_file     = "../../state_credentials.ini" # tfsec:ignore:general-secrets-sensitive-in-attribute
    endpoint                    = "https://frqliwzhrsmg.compat.objectstorage.eu-frankfurt-1.oraclecloud.com"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}

provider "oci" {
  region           = "eu-frankfurt-1"
  private_key_path = "../key.pem" # tfsec:ignore:general-secrets-sensitive-in-attribute
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  tenancy_ocid     = var.tenancy_ocid
}

data "oci_identity_availability_domains" "this" {
  compartment_id = var.compartment_id
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket                      = "terraform-state"
    key                         = "oracle-cloud/network/terraform.tfstate"
    region                      = "eu-frankfurt-1"
    shared_credentials_file     = "../../state_credentials.ini" # tfsec:ignore:general-secrets-sensitive-in-attribute
    endpoint                    = "https://frqliwzhrsmg.compat.objectstorage.eu-frankfurt-1.oraclecloud.com"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}

data "terraform_remote_state" "compute" {
  backend = "s3"
  config = {
    bucket                      = "terraform-state"
    key                         = "oracle-cloud/compute/terraform.tfstate"
    region                      = "eu-frankfurt-1"
    shared_credentials_file     = "../../state_credentials.ini" # tfsec:ignore:general-secrets-sensitive-in-attribute
    endpoint                    = "https://frqliwzhrsmg.compat.objectstorage.eu-frankfurt-1.oraclecloud.com"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}
