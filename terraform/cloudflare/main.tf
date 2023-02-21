terraform {
  backend "s3" {
    bucket                      = "terraform-state"
    key                         = "cloudflare/terraform.tfstate"
    region                      = "eu-frankfurt-1"
    shared_credentials_file     = "../state_credentials.ini"
    endpoint                    = "https://frqliwzhrsmg.compat.objectstorage.eu-frankfurt-1.oraclecloud.com"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.api_token
}

data "cloudflare_zone" "thymesave_app" {
  name = "thymesave.app"
}
