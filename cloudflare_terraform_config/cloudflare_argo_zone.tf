resource "cloudflare_argo" "terraform_managed_resource_smart_routing" {
  smart_routing  = "on"
  tiered_caching = "on"
  zone_id        = "0ef7f3096d44ff61643b0c70f788587d"
}

