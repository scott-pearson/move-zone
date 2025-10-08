resource "cloudflare_load_balancer_monitor" "terraform_managed_resource_f200caeafaa828d6a8ea2ed2df2d5440" {
  account_id       = "5d7ccdf72b74ce76e3af66937c95ca51"
  allow_insecure   = false
  consecutive_down = 0
  consecutive_up   = 0
  description      = "production_healthcheck"
  expected_body    = "OK"
  expected_codes   = "200"
  follow_redirects = false
  interval         = 60
  method           = "GET"
  path             = "/healthcheck.txt"
  port             = 443
  probe_zone       = "scottpearson.net"
  retries          = 2
  timeout          = 5
  type             = "https"
}

