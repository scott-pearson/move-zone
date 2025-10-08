resource "cloudflare_list" "terraform_managed_resource_7874ab5f4d1c435ab22cb52c3556341d" {
  account_id  = "5d7ccdf72b74ce76e3af66937c95ca51"
  description = "IPv4 and IPv6 list of origin IPs"
  kind        = "ip"
  name        = "origin_ips"
  item {
    comment = "Origin IP"
    value {
      ip = "104.248.162.62"
    }
  }
  item {
    comment = "Origin IP"
    value {
      ip = "2a03:b0c0:1:e0::8b3d:3001"
    }
  }
}

