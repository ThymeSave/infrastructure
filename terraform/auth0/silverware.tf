resource "auth0_client" "silverware_prod" {
  name               = "silverware"
  app_type           = "spa"
  description        = "OAUth2 Client for Silverware SPA"
  logo_uri           = "https://design.thymesave.app/logo/color/ThymeSaveLogo.svg"
  initiate_login_uri = "https://my.thymesave.app"
  sso                = true
  allowed_origins = [
    "http://localhost:4200",
    "https://*.thymesave.app",
    "https://*.silverware.pages.dev"
  ]
  web_origins = [
    "http://localhost:4200",
    "https://*.thymesave.app",
    "https://*.silverware.pages.dev"
  ]
  jwt_configuration {
    alg                 = "RS256"
    lifetime_in_seconds = 86400
  }
}
