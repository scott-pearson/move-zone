resource "cloudflare_certificate_pack" "terraform_managed_resource_f146464c-b71e-45de-b889-e8c68e21ed37" {
  certificate_authority = "ssl_com"
  cloudflare_branding   = false
  hosts                 = ["scottpearson.net", "*.scottpearson.net"]
  type                  = "advanced"
  validation_method     = "txt"
  validity_days         = 14
  zone_id               = "0ef7f3096d44ff61643b0c70f788587d"
}

resource "cloudflare_certificate_pack" "terraform_managed_resource_2bec2dbd-00ff-40ad-a2a3-083985d58766" {
  certificate_authority = "google"
  cloudflare_branding   = false
  hosts                 = ["scottpearson.net", "*.scottpearson.net"]
  type                  = "advanced"
  validation_method     = "txt"
  validity_days         = 90
  zone_id               = "0ef7f3096d44ff61643b0c70f788587d"
}

