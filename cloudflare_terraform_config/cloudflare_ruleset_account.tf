resource "cloudflare_ruleset" "terraform_managed_resource_5661231b54fa4ab5a910dca3c0f6c076" {
  account_id = "5d7ccdf72b74ce76e3af66937c95ca51"
  kind       = "custom"
  name       = "default"
  phase      = "http_ratelimit"
  rules {
    action      = "managed_challenge"
    description = "Rate Limit Wordpress Login"
    enabled     = true
    expression  = "(http.request.uri.path eq \"/wp-login.php\" and http.request.method eq \"POST\")"
    ratelimit {
      characteristics     = ["ip.src", "cf.colo.id"]
      mitigation_timeout  = 300
      period              = 60
      requests_per_period = 5
    }
    ref = "wordpress_rl_rule"
  }
  rules {
    action      = "managed_challenge"
    description = "WAF Attack Score Rate Limit"
    enabled     = true
    expression  = "true"
    ratelimit {
      characteristics     = ["ip.src", "cf.colo.id"]
      counting_expression = "(cf.waf.score le 20)"
      mitigation_timeout  = 3600
      period              = 60
      requests_per_period = 5
      requests_to_origin  = true
    }
    ref = "waf_attack_rl_rule"
  }
}

resource "cloudflare_ruleset" "terraform_managed_resource_ac5b6eb66f02493d9e429d1fe9260169" {
  account_id = "5d7ccdf72b74ce76e3af66937c95ca51"
  kind       = "root"
  name       = "default"
  phase      = "http_ratelimit"
  rules {
    action = "execute"
    action_parameters {
      id = "5661231b54fa4ab5a910dca3c0f6c076"
    }
    description = "Account-Level Rate Limit"
    enabled     = true
    expression  = "(cf.zone.plan eq \"ENT\")"
  }
}

resource "cloudflare_ruleset" "terraform_managed_resource_666dcaa8486a4ca485aec3ca82dcb15e" {
  account_id = "5d7ccdf72b74ce76e3af66937c95ca51"
  kind       = "custom"
  name       = "default"
  phase      = "http_request_firewall_custom"
  rules {
    action = "skip"
    action_parameters {
      phases   = ["http_ratelimit", "http_request_firewall_managed"]
      products = ["bic", "securityLevel"]
      ruleset  = "current"
    }
    description = "Allow origin IPs to skip all security rules"
    enabled     = true
    expression  = "(ip.src in $origin_ips)"
    logging {
      enabled = true
    }
    ref = "origin_skip"
  }
  rules {
    action      = "block"
    description = "Mitigate requests that have leaked credentials"
    enabled     = true
    expression  = "(cf.waf.credential_check.username_and_password_leaked)"
    ref         = "leaked_creds"
  }
  rules {
    action      = "block"
    description = "Mitigate definite bot traffic [1]"
    enabled     = true
    expression  = "(cf.bot_management.score eq 1 and not cf.bot_management.verified_bot and not cf.bot_management.static_resource and not any(http.request.headers[\"scott-test\"][*] eq \"1\"))"
    ref         = "definite_bots"
  }
  rules {
    action      = "managed_challenge"
    description = "Mitigate likely bot bot traffic [2-29]"
    enabled     = true
    expression  = "(cf.bot_management.score gt 1 and cf.bot_management.score lt 30 and not cf.bot_management.verified_bot and not cf.bot_management.static_resource and !cf.bot_management.js_detection.passed and not any(http.request.headers[\"scott-test\"][*] eq \"1\"))"
    ref         = "likely_bots"
  }
}

resource "cloudflare_ruleset" "terraform_managed_resource_22114cc065634bc9b27b2b7ca685f3b9" {
  account_id = "5d7ccdf72b74ce76e3af66937c95ca51"
  kind       = "root"
  name       = "default"
  phase      = "http_request_firewall_custom"
  rules {
    action = "execute"
    action_parameters {
      id = "666dcaa8486a4ca485aec3ca82dcb15e"
    }
    description = "Account-Level Custom Rules"
    enabled     = true
    expression  = "(cf.zone.plan eq \"ENT\")"
  }
}

resource "cloudflare_ruleset" "terraform_managed_resource_ec254607e9c949adbde92cae277fee1f" {
  account_id = "5d7ccdf72b74ce76e3af66937c95ca51"
  kind       = "root"
  name       = "root"
  phase      = "http_request_firewall_managed"
  rules {
    action = "skip"
    action_parameters {
      ruleset = "current"
    }
    description = "Exception (Wordpress Upload)"
    enabled     = true
    expression  = "(http.request.uri.path in {\"/wp-admin/async-upload.php\" \"/wp-admin/admin-ajax.php\"} and http.cookie contains \"wordpress_logged_in\")"
    logging {
      enabled = true
    }
    ref = "wordpress_exception_rule"
  }
  rules {
    action = "execute"
    action_parameters {
      id = "efb7b8c949ac4650a09736fc376e9aee"
      matched_data {
        public_key = "NfCZrnSW979ozku8mK+Hj17hylvVq/DPRkooejVrz14="
      }
      overrides {
        rules {
          enabled = true
          id      = "8e361ee4328f4a3caf6caf3e664ed6fe"
        }
      }
    }
    description = "Cloudflare Managed"
    enabled     = true
    expression  = "true"
    ref         = "managed_waf_rule"
  }
  rules {
    action = "execute"
    action_parameters {
      id = "4814384a9e5d4991b9815dcfc25d2f1f"
      matched_data {
        public_key = "NfCZrnSW979ozku8mK+Hj17hylvVq/DPRkooejVrz14="
      }
      overrides {
        categories {
          category = "paranoia-level-2"
          enabled  = false
        }
        categories {
          category = "paranoia-level-3"
          enabled  = false
        }
        categories {
          category = "paranoia-level-4"
          enabled  = false
        }
        rules {
          action          = "managed_challenge"
          id              = "6179ae15870a4bb7b2d480d4843b323c"
          score_threshold = 40
        }
      }
    }
    description = "OWASP"
    enabled     = true
    expression  = "true"
    ref         = "owasp_managed_rule"
  }
}

