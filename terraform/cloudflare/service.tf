resource "cloudflare_record" "funnel" {
  name    = "funnel.app"
  type    = "CNAME"
  zone_id = data.cloudflare_zone.thymesave_app.id
  value   = "130.162.34.79"
}
