resource "cloudflare_access_group" "terraform_managed_resource_0cc4f1e7-d02c-49d4-a5f2-f4a767bf1189" {
  account_id = "5d7ccdf72b74ce76e3af66937c95ca51"
  name       = "My Emails"
  include {
      email = ["scott@cloudflare.com", "grayfox0014@gmail.com", "scottkpearson1@gmail.com"]
  } 
}

