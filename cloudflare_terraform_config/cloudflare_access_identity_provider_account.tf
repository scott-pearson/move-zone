resource "cloudflare_access_identity_provider" "terraform_managed_resource_247b34b7-a5bc-4f38-b056-bf060eccd88a" {
  account_id = "5d7ccdf72b74ce76e3af66937c95ca51"
  name       = "GitHub"
  type       = "github"
  config {
    client_id = "Ov23li8mvF7vemQWzHHr"
  }
  scim_config {
    identity_update_behavior = "no_action"
  }
}

resource "cloudflare_access_identity_provider" "terraform_managed_resource_078a681f-c132-4e16-8fef-7c58494960ad" {
  account_id = "5d7ccdf72b74ce76e3af66937c95ca51"
  name       = "onetimepin"
  type       = "onetimepin"
}

