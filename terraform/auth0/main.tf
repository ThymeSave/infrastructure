terraform {
  backend "s3" {
    bucket                      = "terraform-state"
    key                         = "auth0/terraform.tfstate"
    region                      = "eu-frankfurt-1"
    shared_credentials_file     = "../state_credentials.ini"
    endpoint                    = "https://frqliwzhrsmg.compat.objectstorage.eu-frankfurt-1.oraclecloud.com"
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    force_path_style            = true
  }

  required_providers {
    auth0 = {
      source  = "alexkappa/auth0"
      version = "~> 0.26"
    }
  }
}

provider "auth0" {
  domain        = "thymesave.eu.auth0.com"
  client_id     = "hWDtJtFz7VYn3JvTRR732hKqte0dw44B"
  client_secret = var.api_client_secret
}
