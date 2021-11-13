resource "cloudflare_record" "funnel" {
  name    = "funnel.thymesave.app"
  type    = "A"
  zone_id = data.cloudflare_zone.thymesave_app.id
  value   = "130.162.34.79"
  proxied = true
}

resource "cloudflare_record" "my" {
  name    = "my.thymesave.app"
  type    = "CNAME"
  zone_id = data.cloudflare_zone.thymesave_app.id
  value   = "silverware.pages.dev"
  proxied = true
}
