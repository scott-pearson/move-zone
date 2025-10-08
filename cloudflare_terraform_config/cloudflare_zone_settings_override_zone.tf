resource "cloudflare_zone_settings_override" "terraform_managed_resource_0ef7f3096d44ff61643b0c70f788587d" {
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
  settings {
    always_online             = "on"
    always_use_https          = "off"
    automatic_https_rewrites  = "on"
    brotli                    = "on"
    browser_cache_ttl         = 0
    browser_check             = "on"
    cache_level               = "aggressive"
    challenge_ttl             = 86400
    cname_flattening          = "flatten_at_root"
    development_mode          = "off"
    early_hints               = "on"
    email_obfuscation         = "off"
    hotlink_protection        = "off"
    http2                     = "on"
    http3                     = "on"
    ip_geolocation            = "on"
    ipv6                      = "on"
    max_upload                = 500
    min_tls_version           = "1.2"
    mirage                      = "off"
    opportunistic_encryption    = "on"
    opportunistic_onion         = "on"
    origin_error_page_pass_thru = "off"
    prefetch_preload            = "on"
    privacy_pass                = "on"
    proxy_read_timeout          = "100"
    pseudo_ipv4                 = "off"
    replace_insecure_js         = "on"
    response_buffering          = "off"
    rocket_loader               = "on"
    security_header {
      enabled            = true
      include_subdomains = false
      max_age            = 31556952
      nosniff            = false
      preload            = true
    }
    security_level              = "essentially_off"
    server_side_exclude         = "on"
    sort_query_string_for_cache = "off"
    ssl                         = "strict"
    tls_1_3                     = "zrt"
    tls_client_auth             = "off"
    true_client_ip_header       = "off"
    waf                         = "off"
    websockets                  = "on"
    zero_rtt                    = "on"
  }
}

