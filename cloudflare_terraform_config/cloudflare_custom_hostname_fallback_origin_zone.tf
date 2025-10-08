resource "cloudflare_custom_hostname_fallback_origin" "terraform_managed_resource_fallback_scottpearson_net" {
  origin  = "fallback.scottpearson.net"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
}

