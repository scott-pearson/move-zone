terraform {
  required_providers {
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "4.52.5"
    }
  }
}

provider "cloudflare" {
# too many things don't work with account_api_tokens at this time using $CLOUDFLARE_EMAIL and $CLOUDFLARE_API_KEY env variables instead
#api_token = var.cloudflare_api_token

# For security these values are defined as environment variables locally rather than hardcoded, if you plan to manage tf through git or other version control consider use of environment variables or a tfvars file that is not tracked
# email = $CLOUDFLARE_EMAIL
# api_key = $CLOUDFLARE_API_KEY
}
