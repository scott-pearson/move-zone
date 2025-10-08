resource "cloudflare_custom_pages" "terraform_managed_resource_waf_block" {
  account_id = "5d7ccdf72b74ce76e3af66937c95ca51"
  state      = "customized"
  type       = "waf_block"
  url        = "https://scottpearson.net/errors/cf-403.html"
}

resource "cloudflare_custom_pages" "terraform_managed_resource_ratelimit_block" {
  account_id = "5d7ccdf72b74ce76e3af66937c95ca51"
  state      = "customized"
  type       = "ratelimit_block"
  url        = "https://scottpearson.net/errors/cf-429.html"
}

resource "cloudflare_custom_pages" "terraform_managed_resource_managed_challenge" {
  account_id = "5d7ccdf72b74ce76e3af66937c95ca51"
  state      = "customized"
  type       = "managed_challenge"
  url        = "https://scottpearson.net/errors/cf-503.html"
}

resource "cloudflare_custom_pages" "terraform_managed_resource_500_errors" {
  account_id = "5d7ccdf72b74ce76e3af66937c95ca51"
  state      = "customized"
  type       = "500_errors"
  url        = "https://scottpearson.net/errors/cf-5xx.html"
}

resource "cloudflare_custom_pages" "terraform_managed_resource_1000_errors" {
  account_id = "5d7ccdf72b74ce76e3af66937c95ca51"
  state      = "customized"
  type       = "1000_errors"
  url        = "https://scottpearson.net/errors/cf-1xxx.html"
}

