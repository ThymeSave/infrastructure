infrastructure
===
[![License: GPL v3](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![pre-commit](https://img.shields.io/badge/%E2%9A%93%20%20pre--commit-enabled-success)](https://pre-commit.com/)
[![Dependabot](https://badgen.net/badge/Dependabot/enabled/green?icon=dependabot)](https://dependabot.com/)

This repository contains all infrastructure we use to run ThymeSave as a managed service.

## Development

### Required tools

- [tfenv](https://github.com/tfutils/tfenv)
- [tflint](https://github.com/terraform-linters/tflint)
- [tfsec](https://github.com/aquasecurity/tfsec)
- [pre-commit](https://pre-commit.com/)

### Basic

#### Setup

1. Copy the state credentials config: `cp state_credentials.ini.example state_credentials.ini`
2. Fill in your credentials

#### Apply

1. First setup module as described in the README
2. Switch to module e. g. `cd cloudflare`
3. Initialize terraform: `terraform init`
4. Apply: `terraform apply`

### Oracle cloud resources

1. Go to oracle-cloud: `cd oracle-cloud`
2. Copy the variables file `cp sample.tfvars local.tfvars`
3. Replace the placeholders with your user specific variables

### CloudFlare
1. Go to cloudflare: `cd cloudflare`
2. Copy the variables file `cp sample.tfvars local.tfvars`
3. Replace the placeholders with your user specific variables
