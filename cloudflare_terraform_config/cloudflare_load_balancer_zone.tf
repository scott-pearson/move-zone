resource "cloudflare_load_balancer" "terraform_managed_resource_ec6a0aae32ca7fce2cb084e24abff714" {
  default_pool_ids = ["cd2e07b66c605c492d26acf62d2ebe00", "b786c315262a2942e3bf47ba8c6a6b45"]
  description      = "Production Load Balancer"
  enabled          = true
  fallback_pool_id = "cd2e07b66c605c492d26acf62d2ebe00"
  name             = "lb.scottpearson.net"
  proxied          = true
  session_affinity = "none"
  steering_policy  = "proximity"
  zone_id          = "0ef7f3096d44ff61643b0c70f788587d"
  adaptive_routing {
    failover_across_pools = true
  }
  location_strategy {
    mode       = "resolver_ip"
    prefer_ecs = "always"
  }
  random_steering {
    default_weight = 1
  }
  rules {
    condition = "(any(http.request.headers[\"lb\"][*] in {\"eu\" \"amer\"}))"
    disabled  = false
    name      = "Conditional Routing (EU/AMER)"
    overrides {
      default_pools = ["cd2e07b66c605c492d26acf62d2ebe00"]
    }
    priority = 0
  }
  rules {
    condition = "(any(http.request.headers[\"lb\"][*] eq \"row\"))"
    disabled  = false
    name      = "Conditional Routing (ROW)"
    overrides {
      default_pools = ["b786c315262a2942e3bf47ba8c6a6b45"]
    }
    priority = 10
  }
  session_affinity_attributes {
    samesite               = "Auto"
    secure                 = "Auto"
    zero_downtime_failover = "none"
  }
}

