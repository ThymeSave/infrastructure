infrastructure
===
[![License: GPL v3](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![pre-commit](https://img.shields.io/badge/%E2%9A%93%20%20pre--commit-enabled-success)](https://pre-commit.com/)
[![Dependabot](https://badgen.net/badge/Dependabot/enabled/green?icon=dependabot)](https://dependabot.com/)

This repository contains all infrastructure we use to run ThymeSave as a managed service.

## Providers we use

### CloudFlare

Battle proven DNS and DDOS protection. There service is free and they
also offer SSL termination out of the box.

### Oracle Cloud

Oracle Cloud provides a [Free Tier](https://www.oracle.com/cloud/free/)
that allows us to run in an cloud environment with failure resilence and
use clustering. And the best of all: its completely free!

At the time of creating the project knowledge inside the ThymeSave org
is very limited, so things are subject to change and improvements.

> Because of the free tier we are limited on how we can build infrastructure, so please keep this in mind :)

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


## Commit Message Convention

This repository follows [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/)

### Format

`<type>(optional scope): <description>`
Example: `feat(pre-event): Add speakers section`

### 1. Type

Available types are:

- feat → Changes about addition or removal of a feature. Ex: `feat: Add table on landing page`
  , `feat: Remove table from landing page`
- fix → Bug fixing, followed by the bug. Ex: `fix: Illustration overflows in mobile view`
- docs → Update documentation (README.md)
- style → Updating style, and not changing any logic in the code (reorder imports, fix whitespace, remove comments)
- chore → Installing new dependencies, or bumping deps
- refactor → Changes in code, same output, but different approach
- ci → Update github workflows, husky
- test → Update testing suite, cypress files
- revert → when reverting commits
- perf → Fixing something regarding performance (deriving state, using memo, callback)
- vercel → Blank commit to trigger vercel deployment. Ex: `vercel: Trigger deployment`

### 2. Optional Scope

Labels per page Ex: `feat(pre-event): Add date label`

*If there is no scope needed, you don't need to write it*

### 3. Description

Description must fully explain what is being done.

Add BREAKING CHANGE in the description if there is a significant change.

**If there are multiple changes, then commit one by one**

- After colon, there are a single space Ex: `feat: Add something`
- When using `fix` type, state the issue Ex: `fix: File size limiter not working`
- Use imperative, dan present tense: "change" not "changed" or "changes"
- Use capitals in front of the sentence
- Don't add full stop (.) at the end of the sentence


## Contributing

### [Code of Conduct](https://github.com/ThymeSave/funnel/blob/main/CODE-OF-CONDUCT.md)

ThymeSave has adopted a Code of Conduct that we expect project participants to adhere to. Please read the full text so
that you can understand what actions will and will not be tolerated.

### Contributing guide

For infrastructure there is no standardized way to contribute. If you feel like sth. could be improved feel free to create a ticket or pull request.
