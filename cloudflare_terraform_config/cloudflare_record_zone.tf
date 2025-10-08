resource "cloudflare_record" "terraform_managed_resource_9de3f880a720d5a4bb71c0dfd76064c3" {
  content = "198.41.223.208"
  name    = "ns1"
  proxied = false
  ttl     = 1
  type    = "A"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
}

resource "cloudflare_record" "terraform_managed_resource_5e2df14abc00b2bbb53cfbd504de528f" {
  content = "198.41.222.146"
  name    = "ns2"
  proxied = false
  ttl     = 1
  type    = "A"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
}

resource "cloudflare_record" "terraform_managed_resource_f4cb39cb90137d30f685cf91c161428d" {
  content = "2400:cb00:2049:1::c629:dfd0"
  name    = "ns1"
  proxied = false
  ttl     = 1
  type    = "AAAA"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
}

resource "cloudflare_record" "terraform_managed_resource_74b0ea48bfd3c104514df167aff6e555" {
  content = "2400:cb00:2049:1::c629:de92"
  name    = "ns2"
  proxied = false
  ttl     = 1
  type    = "AAAA"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
}

resource "cloudflare_record" "terraform_managed_resource_c2c9d1e34969813cadd1011352d79761" {
  content = "lb.scottpearson.net"
  name    = "api"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
}

resource "cloudflare_record" "terraform_managed_resource_a140d48ace0dccc7efdb3a0064cd0990" {
  content = "lb.scottpearson.net"
  name    = "fallback"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
}

resource "cloudflare_record" "terraform_managed_resource_e2137f7c2db7a8de65a31229f179fa66" {
  content = "lb.scottpearson.net"
  name    = "scottpearson.net"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
}

resource "cloudflare_record" "terraform_managed_resource_5d581a36b5c82b58a76e63cc1b3abba6" {
  content = "lb.scottpearson.net"
  name    = "test"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
}

resource "cloudflare_record" "terraform_managed_resource_ed583c18f2174762a743b54c10dee347" {
  content = "lb.scottpearson.net"
  name    = "www"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
}

