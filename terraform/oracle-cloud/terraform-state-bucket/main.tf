terraform {
  backend "s3" {
    bucket = "terraform-state"
    key    = "oracle-cloud/terraform-state-bucket/terraform.tfstate"
    region = "eu-frankfurt-1"
    # tfsec:ignore:general-secrets-sensitive-in-attribute
    shared_credentials_file     = "../../state_credentials.ini"
    endpoint                    = "https://frqliwzhrsmg.compat.objectstorage.eu-frankfurt-1.oraclecloud.com"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }
}

provider "oci" {
  region = "eu-frankfurt-1"
  # tfsec:ignore:general-secrets-sensitive-in-attribute
  private_key_path = "../key.pem"
  user_ocid        = var.user_ocid
  fingerprint      = var.fingerprint
  tenancy_ocid     = var.tenancy_ocid
}

data "oci_objectstorage_namespace" "this" {
  compartment_id = var.compartment_id
}
