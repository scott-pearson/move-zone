resource "cloudflare_teams_rule" "terraform_managed_resource_271a40cf-27d5-4c99-8890-30791c8e9633" {
  account_id  = "5d7ccdf72b74ce76e3af66937c95ca51"
  action      = "off"
  description = "Bypass HTTPS decryption of Microsoft 365 traffic"
  enabled     = true
  filters     = ["http"]
  name        = "Do Not Inspect Microsoft 365"
  precedence  = 20000
  traffic     = "any(app.ids[*] in {626 594 635 514 601 596 597 680})"
  rule_settings {
    block_page_enabled                 = false
    insecure_disable_dnssec_validation = false
    ip_categories                      = false
  }
}

