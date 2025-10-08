resource "cloudflare_ruleset" "terraform_managed_resource_6042343101574f988b13a3a5442e2e82" {
  kind    = "zone"
  name    = "default"
  phase   = "http_config_settings"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
  rules {
    action = "set_config"
    action_parameters {
      ssl = "full"
    }
    description = "Disable SSL for mbamps"
    enabled     = true
    expression  = "(http.host contains \"mbamps.com\")"
    ref         = "config_rule1"
  }
}

resource "cloudflare_ruleset" "terraform_managed_resource_8c47b99d91ba4f27bfa8d6c5bd895037" {
  kind    = "zone"
  name    = "default"
  phase   = "http_custom_errors"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
  rules {
    action = "serve_error"
    action_parameters {
      content      = "{\n  \"status\": 404,\n  \"error\": \"Not Found\",\n  \"message\": \"The requested resource could not be found.\"\n}"
      content_type = "application/json"
      status_code  = 404
    }
    description = "Custom Error For 404"
    enabled     = true
    expression  = "(http.response.code eq 404)"
    ref         = "error_rule1"
  }
}

resource "cloudflare_ruleset" "terraform_managed_resource_5ebcdf046b75431abf7e937f52db6722" {
  kind    = "zone"
  name    = "default"
  phase   = "http_log_custom_fields"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
  rules {
    action = "log_custom_field"
    action_parameters {
      request_fields  = ["authorization"]
      response_fields = ["cache-control"]
    }
    description = "Set Logpush custom fields for HTTP requests"
    enabled     = true
    expression  = "true"
  }
}

resource "cloudflare_ruleset" "terraform_managed_resource_16c3e1c9075342bcbab3952d3ead654c" {
  kind    = "zone"
  name    = "default"
  phase   = "http_ratelimit"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
  rules {
    action      = "block"
    description = "Rate Limit by user (JWT)"
    enabled     = true
    expression  = "(http.host eq \"api.scottpearson.net\" and any(http.request.headers.names[*] eq \"jwt-auth-header\"))"
    ratelimit {
      characteristics     = ["lookup_json_string(http.request.jwt.claims[\"116c0a3d-6be8-43c4-a355-8b2a3704e991\"][0],\"name\")", "ip.src", "cf.colo.id"]
      mitigation_timeout  = 60
      period              = 60
      requests_per_period = 5
    }
    ref = "jwt_rl_rule"
  }
}

resource "cloudflare_ruleset" "terraform_managed_resource_807e9d2eae814419b9bbb9cc74746ebd" {
  kind    = "zone"
  name    = "default"
  phase   = "http_request_cache_settings"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
  rules {
    action = "set_cache_settings"
    action_parameters {
      browser_ttl {
        default = 86400
        mode    = "override_origin"
      }
      cache = true
      cache_key {
        custom_key {
          header {
            contains = {}
          }
          user {
            device_type = true
            geo         = true
            lang        = false
          }
        }
      }
      edge_ttl {
        default = 86400
        mode    = "override_origin"
        status_code_ttl {
          status_code_range {
            from = 500
            to   = 599
          }
          value = -1
        }
        status_code_ttl {
          status_code = 400
          value       = -1
        }
        status_code_ttl {
          status_code = 401
          value       = -1
        }
        status_code_ttl {
          status_code_range {
            from = 402
            to   = 499
          }
          value = 3600
        }
      }
      origin_cache_control = true
    }
    description = "Cache Everything"
    enabled     = true
    expression  = "true"
    ref         = "cache_rule1"
  }
  rules {
    action = "set_cache_settings"
    action_parameters {
      browser_ttl {
        default = 604800
        mode    = "override_origin"
      }
      cache = true
      cache_key {
        custom_key {
          header {
            contains = {}
          }
          user {
            device_type = true
            geo         = true
            lang        = false
          }
        }
      }
      edge_ttl {
        default = 604800
        mode    = "override_origin"
        status_code_ttl {
          status_code_range {
            from = 500
            to   = 599
          }
          value = -1
        }
        status_code_ttl {
          status_code = 400
          value       = -1
        }
        status_code_ttl {
          status_code = 401
          value       = -1
        }
        status_code_ttl {
          status_code_range {
            from = 402
            to   = 499
          }
          value = 3600
        }
      }
      origin_cache_control = true
    }
    description = "Cache Default File Extensions"
    enabled     = true
    expression  = "(http.request.uri.path.extension in {\"7z\" \"avi\" \"avif\" \"apk\" \"bin\" \"bmp\" \"bz2\" \"class\" \"css\" \"csv\" \"doc\" \"docx\" \"dmg\" \"ejs\" \"eot\" \"eps\" \"exe\" \"flac\" \"gif\" \"gz\" \"ico\" \"iso\" \"jar\" \"jpg\" \"jpeg\" \"js\" \"mid\" \"midi\" \"mkv\" \"mp3\" \"mp4\" \"ogg\" \"otf\" \"pdf\" \"pict\" \"pls\" \"png\" \"ppt\" \"pptx\" \"ps\" \"rar\" \"svg\" \"svgz\" \"swf\" \"tar\" \"tif\" \"tiff\" \"ttf\" \"webm\" \"webp\" \"woff\" \"woff2\" \"xls\" \"xlsx\" \"zip\" \"zst\"})"
    ref         = "cache_rule2"
  }
  rules {
    action = "set_cache_settings"
    action_parameters {
      browser_ttl {
        mode = "bypass"
      }
      cache = false
    }
    description = "Bypass Cache For API"
    enabled     = true
    expression  = "(http.request.uri.path wildcard r\"/api/*\") or (http.host eq \"api.scottpearson.net\")"
    ref         = "cache_rule3"
  }
  rules {
    action = "set_cache_settings"
    action_parameters {
      browser_ttl {
        mode = "bypass"
      }
      cache = false
    }
    description = "Bypass Cache For Wordpress"
    enabled     = true
    expression  = "(http.request.uri.path wildcard r\"/wp-admin/*\") or (http.cookie contains \"wordpress_logged_in\")"
    ref         = "cache_rule4"
  }
  rules {
    action = "set_cache_settings"
    action_parameters {
      browser_ttl {
        mode = "bypass"
      }
      cache = false
    }
    description = "Bypass Cache For Headers"
    enabled     = true
    expression  = "(http.request.uri.path eq \"/headers.php\")"
    ref         = "cache_rule5"
  }
}

resource "cloudflare_ruleset" "terraform_managed_resource_2e179682e1d44486823b27e8ba15afb4" {
  kind    = "zone"
  name    = "default"
  phase   = "http_request_dynamic_redirect"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
  rules {
    action = "redirect"
    action_parameters {
      from_value {
        preserve_query_string = false
        status_code           = 301
        target_url {
          expression = "regex_replace(http.request.uri, \"^/bob(.*)$\", \"/?bob$${1}\")"
        }
      }
    }
    description = "Redirect Bob to / and append to query string"
    enabled     = true
    expression  = "(http.request.uri.path matches r\"^/bob[^/]*$\")"
    ref         = "redirect_rule1"
  }
}

resource "cloudflare_ruleset" "terraform_managed_resource_bb8c194106aa4dfc88632f6394c79de9" {
  kind    = "zone"
  name    = "default"
  phase   = "http_request_firewall_custom"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
  rules {
    action      = "log"
    description = "Log clients that passed JS detection"
    enabled     = true
    expression  = "(cf.bot_management.js_detection.passed)"
    ref         = "js_detections_rule"
  }
  rules {
    action      = "log"
    description = "API Shield Fallthrough rule"
    enabled     = true
    expression  = "(cf.api_gateway.fallthrough_detected and http.host in {\"api.scottpearson.net\"})"
    ref         = "api_fallthrough_rule"
  }
  rules {
    action      = "block"
    description = "Block API requests with no authentication"
    enabled     = true
    expression  = "(not cf.api_gateway.auth_id_present and http.host eq \"api.scottpearson.net\")"
    ref         = "api_auth_rule"
  }
  rules {
    action      = "block"
    description = "Enforce mTLS authentication"
    enabled     = true
    expression  = "((not cf.tls_client_auth.cert_verified or cf.tls_client_auth.cert_revoked) and http.host eq \"scottpearson.net\" and http.request.uri.path wildcard r\"/api/*\")"
    ref         = "mtls_rule"
  }
  rules {
    action      = "block"
    description = "Block requests to ns1/ns2"
    enabled     = true
    expression  = "(http.host in {\"ns1.scottpearson.net\" \"ns2.scottpearson.net\"})"
    ref         = "ns_rule"
  }
}

resource "cloudflare_ruleset" "terraform_managed_resource_f65a623f98a34eab8c3a88e0c219df76" {
  kind    = "zone"
  name    = "default"
  phase   = "http_request_late_transform"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
  rules {
    action = "rewrite"
    action_parameters {
      headers {
        expression = "ip.src.country"
        name       = "x-country"
        operation  = "set"
      }
    }
    description = "Send Country in Custom Header"
    enabled     = true
    expression  = "true"
    ref         = "reqheader_transform1"
  }
}

resource "cloudflare_ruleset" "terraform_managed_resource_6962d1bc3c644dd89a523a03479c7525" {
  kind    = "zone"
  name    = "default"
  phase   = "http_request_origin"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
  rules {
    action = "route"
    action_parameters {
      host_header = "scottpearson.net"
      origin {
        host = "lb.scottpearson.net"
        port = 443
      }
      sni {
        value = "scottpearson.net"
      }
    }
    description = "Origin override for fallback.scottpearson.net"
    enabled     = true
    expression  = "(http.host eq \"fallback.scottpearson.net\")"
    ref         = "origin_rule1"
  }
}

resource "cloudflare_ruleset" "terraform_managed_resource_93e40f0b472648d7a37ad237205d33a4" {
  description = "ruleset for controlling url normalization"
  kind        = "zone"
  name        = "Entrypoint for url normalization ruleset"
  phase       = "http_request_sanitize"
  zone_id     = "0ef7f3096d44ff61643b0c70f788587d"
  rules {
    action = "execute"
    action_parameters {
      id = "70339d97bdb34195bbf054b1ebe81f76"
      overrides {
        rules {
          enabled = false
          id      = "78723a9e0c7c4c6dbec5684cb766231d"
        }
        rules {
          enabled = false
          id      = "b232b534beea4e00a21dcbb7a8a545e9"
        }
        rules {
          enabled = true
          id      = "20e18610e4a048d6b87430b3cb2d89a3"
        }
        rules {
          enabled = false
          id      = "60444c0705d4438799584a15cca2cb7d"
        }
      }
    }
    enabled    = true
    expression = "true"
  }
}

resource "cloudflare_ruleset" "terraform_managed_resource_df1ffb2339d444e0bf23749942c80f33" {
  kind    = "zone"
  name    = "default"
  phase   = "http_request_transform"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
  rules {
    action = "rewrite"
    action_parameters {
      uri {
        path {
          value = "/"
        }
        query {
          value = "test=1"
        }
      }
    }
    description = "Rewrite Test Path"
    enabled     = true
    expression  = "(http.request.uri.path matches r\"^/test[^/]*$\")"
    ref         = "rewrite_rule1"
  }
}

resource "cloudflare_ruleset" "terraform_managed_resource_e4e5e7b883d140e29ddc96872f850832" {
  kind    = "zone"
  name    = "default"
  phase   = "http_response_compression"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
  rules {
    action = "compress_response"
    action_parameters {
      algorithms {
        name = "zstd"
      }
      algorithms {
        name = "brotli"
      }
      algorithms {
        name = "gzip"
      }
    }
    description = "Enable Zstd Compression"
    enabled     = true
    expression  = "(http.response.content_type.media_type in {\"text/html\" \"text/richtext\" \"text/plain\" \"text/css\" \"text/x-script\" \"text/x-component\" \"text/x-java-source\" \"text/x-markdown\" \"application/javascript\" \"application/x-javascript\" \"text/javascript\" \"text/js\" \"image/x-icon\" \"image/vnd.microsoft.icon\" \"application/x-perl\" \"application/x-httpd-cgi\" \"text/xml\" \"application/xml\" \"application/rss+xml\" \"application/vnd.api+json\" \"application/x-protobuf\" \"application/json\" \"multipart/bag\" \"multipart/mixed\" \"application/xhtml+xml\" \"font/ttf\" \"font/otf\" \"font/x-woff\" \"image/svg+xml\" \"application/vnd.ms-fontobject\" \"application/ttf\" \"application/x-ttf\" \"application/otf\" \"application/x-otf\" \"application/truetype\" \"application/opentype\" \"application/x-opentype\" \"application/font-woff\" \"application/eot\" \"application/font\" \"application/font-sfnt\" \"application/wasm\" \"application/javascript-binast\" \"application/manifest+json\" \"application/ld+json\" \"application/graphql+json\" \"application/geo+json\"})"
    ref         = "compression1"
  }
}

resource "cloudflare_ruleset" "terraform_managed_resource_6f2a7e98ebf543f88d4dbaa534d3eecf" {
  kind    = "zone"
  name    = "default"
  phase   = "http_response_headers_transform"
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
  rules {
    action = "rewrite"
    action_parameters {
      headers {
        expression = "ip.src.country"
        name       = "x-country"
        operation  = "set"
      }
    }
    description = "Send Country in Custom Response Header"
    enabled     = true
    expression  = "true"
    ref         = "resheader_transform1"
  }
}

