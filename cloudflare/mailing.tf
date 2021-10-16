resource "cloudflare_record" "dmarc" {
  zone_id = data.cloudflare_zone.thymesave_app.id
  name    = "_dmarc"
  type    = "TXT"
  value   = "v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s;"
}

resource "cloudflare_record" "dkim" {
  zone_id = data.cloudflare_zone.thymesave_app.id
  name    = "*._domainkey"
  type    = "TXT"
  value   = "v=DKIM1; p="
}
