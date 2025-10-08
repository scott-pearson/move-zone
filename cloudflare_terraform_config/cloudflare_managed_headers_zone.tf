resource "cloudflare_managed_headers" "terraform_managed_resource_0ef7f3096d44ff61643b0c70f788587d" {
  zone_id = "0ef7f3096d44ff61643b0c70f788587d"
  managed_request_headers {
    enabled = true
    id      = "add_bot_protection_headers"
  }
  managed_request_headers {
    enabled = true
    id      = "add_client_certificate_headers"
  }
  managed_request_headers {
    enabled = true
    id      = "add_visitor_location_headers"
  }
  managed_response_headers {
    enabled = true
    id      = "remove_x-powered-by_header"
  }
  managed_response_headers {
    enabled = true
    id      = "add_security_headers"
  }
}

