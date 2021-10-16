locals {
  pages = toset([
    "www",
    "thymesave.app",
    "funnel.docs",
    "design"
  ])
}

resource "cloudflare_record" "github_pages" {
  for_each = local.pages
  zone_id  = data.cloudflare_zone.thymesave_app.id
  name     = each.value
  type     = "CNAME"
  value    = "thymesave.github.io"
  proxied  = false
}

resource "cloudflare_record" "github_verification" {
  zone_id = data.cloudflare_zone.thymesave_app.id
  name    = "_github-challenge-thymesave"
  type    = "TXT"
  value   = "518d5e00c7"
}
