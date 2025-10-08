resource "cloudflare_custom_hostname" "terraform_managed_resource_33f25fe3-6e29-4128-a3de-921cb2c61af1" {
  hostname = "scott-ch2.mbamps.com"
  zone_id  = "0ef7f3096d44ff61643b0c70f788587d"
  ssl {
    bundle_method         = "ubiquitous"
    certificate_authority = "google"
    method                = "txt"
    settings {
      min_tls_version = "1.0"
    }
    type     = "dv"
    wildcard = false
  }
}

resource "cloudflare_custom_hostname" "terraform_managed_resource_23f225e5-1bd4-4c92-b81c-8a2ab7423c47" {
  hostname = "scott-ch3.mbamps.com"
  zone_id  = "0ef7f3096d44ff61643b0c70f788587d"
  ssl {
    bundle_method         = "ubiquitous"
    certificate_authority = "google"
    method                = "txt"
    settings {
      min_tls_version = "1.0"
    }
    type     = "dv"
    wildcard = false
  }
}

resource "cloudflare_custom_hostname" "terraform_managed_resource_39d425c6-6d5e-4c79-ba5d-86d3f689d7cb" {
  hostname = "scott-ch.mbamps.com"
  zone_id  = "0ef7f3096d44ff61643b0c70f788587d"
  ssl {
    bundle_method         = "ubiquitous"
    certificate_authority = "google"
    method                = "http"
    settings {
      ciphers = ["ECDHE-ECDSA-AES128-GCM-SHA256", "ECDHE-ECDSA-AES256-GCM-SHA384", "ECDHE-ECDSA-CHACHA20-POLY1305"]
    }
    type     = "dv"
    wildcard = false
  }
}

