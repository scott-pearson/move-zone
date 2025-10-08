resource "cloudflare_load_balancer_pool" "terraform_managed_resource_cd2e07b66c605c492d26acf62d2ebe00" {
  account_id         = "5d7ccdf72b74ce76e3af66937c95ca51"
  check_regions      = ["WEU", "EEU", "ENAM", "WNAM", "NSAM", "SSAM"]
  description        = "EU/AMER production pool"
  enabled            = true
  latitude           = 51.5177
  longitude          = -0.6215
  minimum_origins    = 1
  monitor            = "f200caeafaa828d6a8ea2ed2df2d5440"
  name               = "eu-amer-production"
  notification_email = "scott@cloudflare.com"
  origin_steering {
    policy = "random"
  }
  origins {
    address = "104.248.162.62"
    enabled = true
    name    = "scott-web01"
    weight  = 1
  }
}

resource "cloudflare_load_balancer_pool" "terraform_managed_resource_b786c315262a2942e3bf47ba8c6a6b45" {
  account_id         = "5d7ccdf72b74ce76e3af66937c95ca51"
  check_regions      = ["ME", "NAF", "NEAS", "OC", "SAS", "SAF", "SEAS"]
  description        = "Rest of world production pool"
  enabled            = true
  latitude           = -33.8978
  longitude          = 151.1899
  minimum_origins    = 1
  monitor            = "f200caeafaa828d6a8ea2ed2df2d5440"
  name               = "row-production"
  notification_email = "scott@cloudflare.com"
  origin_steering {
    policy = "random"
  }
  origins {
    address = "209.38.29.196"
    enabled = true
    name    = "scott-web02"
    weight  = 1
  }
}

