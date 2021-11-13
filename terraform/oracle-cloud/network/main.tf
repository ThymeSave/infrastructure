terraform {
  backend "s3" {
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

provider "oci" {
  region           = "eu-frankfurt-1"
  private_key_path = "../key.pem" # tfsec:ignore:general-secrets-sensitive-in-attribute
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  tenancy_ocid     = var.tenancy_ocid
}

data "oci_objectstorage_namespace" "this" {
  compartment_id = var.compartment_id
}

data "oci_identity_availability_domains" "this" {
  compartment_id = var.compartment_id
}

locals {
  vcn_cidr     = "10.1.0.0/24"
  private_cidr = "10.1.0.0/26"
  public_cidr  = "10.1.0.64/26"
  bastion_cidr = "10.1.0.128/26"
  // .. free: 10.1.0.192/26

  private_subnets = [
    "10.1.0.0/28",
    "10.1.0.16/28",
    "10.1.0.32/27"
  ]
  public_subnets = [
    "10.1.0.64/28",
    "10.1.0.80/28",
    "10.1.0.96/27"
  ]

}
