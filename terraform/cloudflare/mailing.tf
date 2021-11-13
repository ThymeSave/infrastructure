resource "cloudflare_record" "dmarc" {
  zone_id = data.cloudflare_zone.thymesave_app.id
  name    = "_dmarc"
  type    = "TXT"
  value   = "v=DMARC1;p=reject;pct=100;"
}

resource "cloudflare_record" "dkim" {
  zone_id = data.cloudflare_zone.thymesave_app.id
  name    = "*._domainkey"
  type    = "TXT"
  value   = "v=DKIM1;k=rsa;t=s;s=email;p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArGkhIX/Jm3d9Yi6BroPh6D3xiO/v98CivW4lSb6w7N4yCwsXGpp1H7juE1htks+TGckgNt15Fekjk3yVmzeAdutKNqcb9xP9yF4jwVd4fIeejWgVj1oD/1I2WfDm7fKi4OzmUqnL5Rh3lh3RZxJiPgTrzXs+M95cMZOPjnuk/xDuZWYSuz4Ld2Jup+5LsZYNjb/AN1iPIM69DmeivEEthGiimKRwzDyWMe+31xHDybR6yhxWF+FyMHh3Y78ivOe+IyPqe8qYXSe18LM9cnSGw6XQW9AXWDtSXtDCkrgYsp6B0WgI4PpYHCmLzTjPjUPysWcW7wh8JqqdRWDetkgJrQIDAQAB"
}

resource "cloudflare_record" "spf" {
  zone_id = data.cloudflare_zone.thymesave_app.id
  name    = "."
  type    = "TXT"
  value   = "v=spf1 mx a -all"
}

resource "cloudflare_record" "autoconfig" {
  zone_id = data.cloudflare_zone.thymesave_app.id
  for_each = toset([
    "autoconfig",
    "autodiscover"
  ])
  name    = each.value
  type    = "CNAME"
  value   = "beta.timo-reymann.de"
  proxied = true
}

resource "cloudflare_record" "mx" {
  zone_id  = data.cloudflare_zone.thymesave_app.id
  name     = "thymesave.app"
  type     = "MX"
  value    = "beta.timo-reymann.de"
  proxied  = false
  priority = 0
}

resource "cloudflare_record" "mail_meta" {
  zone_id = data.cloudflare_zone.thymesave_app.id
  for_each = {
    _autodiscover = {
      port     = 443
      priority = 1
      target   = "beta.timo-reymann.de"
    },
    _imaps = {
      port     = 993
      priority = 1
      target   = "beta.timo-reymann.de"
    },
    _smtps = {
      port     = 465
      priority = 1
      target   = "beta.timo-reymann.de"
    }
  }
  name = "thymesave.app"
  type = "SRV"

  data {
    service  = each.key
    proto    = "_tcp"
    name     = "thymesave.app"
    priority = each.value.priority
    weight   = 0
    port     = each.value.port
    target   = each.value.target
  }
}
