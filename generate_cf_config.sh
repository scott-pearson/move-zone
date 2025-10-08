#!/bin/bash
set -o pipefail

# This script intentionally does not use 'set -e'.
# The 'cf-terraforming' tool can sometimes panic and crash on certain resources.
# By handling errors for each call individually, the script can continue processing
# other resources even if one fails.

# ==============================================================================
# CONFIGURATION
#
# IMPORTANT: Please fill in your Cloudflare Account ID and Zone ID below.
# The Zone ID is only required for generating zone-level resources.
# ==============================================================================
CLOUDFLARE_ACCOUNT_ID="c375fad1094608dd251c2a7fdea837eb"
CLOUDFLARE_ZONE_ID="9ead243424f613e0194590b375a3c9d2"

# ==============================================================================
# SCRIPT LOGIC - No need to edit below this line
# ==============================================================================

# --- Output Directory ---
OUTPUT_DIR="cloudflare_terraform_config"

# --- Resource Lists ---

# Resources that are configured EXCLUSIVELY at the Account level.
ACCOUNT_RESOURCES=(
    "cloudflare_access_application"
    "cloudflare_access_group"
    "cloudflare_access_identity_provider"
    "cloudflare_access_mutual_tls_certificate"
    # "cloudflare_access_policy" # Not supported
    "cloudflare_access_rule"
    "cloudflare_access_service_token"
    "cloudflare_account_member"
    "cloudflare_byo_ip_prefix"
    # "cloudflare_ip_list" # Not supported
    "cloudflare_list"
    "cloudflare_load_balancer_monitor"
    "cloudflare_load_balancer_pool"
    # "cloudflare_magic_firewall_ruleset" # Not supported
    "cloudflare_teams_list"
    "cloudflare_teams_location"
    "cloudflare_teams_proxy_endpoint"
    "cloudflare_teams_rule"
    "cloudflare_tunnel"
    "cloudflare_turnstile_widget"
    # "cloudflare_worker_cron_trigger" # Not supported
    # "cloudflare_worker_script" # Not supported
    # "cloudflare_workers_kv" # Not supported
    "cloudflare_workers_kv_namespace"
)

# Resources that are configured EXCLUSIVELY at the Zone level.
ZONE_RESOURCES=(
    "cloudflare_api_shield"
    "cloudflare_argo"
    # "cloudflare_authenticated_origin_pulls" # Not supported
    # "cloudflare_authenticated_origin_pulls_certificate" # Not supported
    "cloudflare_bot_management"
    "cloudflare_certificate_pack"
    "cloudflare_custom_hostname"
    "cloudflare_custom_hostname_fallback_origin"
    "cloudflare_custom_ssl"
    # "cloudflare_filter" # Depreciated use cloudflare_ruleset
    # "cloudflare_firewall_rule" # Depreciated use cloudflare_ruleset
    "cloudflare_healthcheck"
    "cloudflare_load_balancer"
    # "cloudflare_logpull_retention" # Not supported
    "cloudflare_logpush_job"
    # "cloudflare_logpush_ownership_challenge" # Not supported
    "cloudflare_managed_headers"
    "cloudflare_origin_ca_certificate"
    "cloudflare_page_rule"
    "cloudflare_rate_limit"
    "cloudflare_record"
    "cloudflare_spectrum_application"
    "cloudflare_tiered_cache"
    "cloudflare_url_normalization_settings"
    # "cloudflare_waf_group" # Not supported
    "cloudflare_waf_override"
    "cloudflare_waf_package"
    # "cloudflare_waf_rule" # Not supported
    "cloudflare_waiting_room"
    "cloudflare_worker_route"
    # "cloudflare_zone_dnssec" # Not supported
    "cloudflare_zone_lockdown"
    "cloudflare_zone_settings_override"
    #"cloudflare_zone" # This will pull all zones in the account so commenting
)

# Resources that can be configured at either the Account OR Zone level.
# The script will attempt to generate for both scopes.
ACCOUNT_OR_ZONE_RESOURCES=(
    "cloudflare_custom_pages"
    "cloudflare_ruleset"
)

# --- Prerequisite Checks ---
function check_prerequisites() {
    echo "🔎 Checking prerequisites..."
    if ! command -v cf-terraforming &> /dev/null; then
        echo "❌ Error: 'cf-terraforming' command not found."
        echo "Please install it from: https://github.com/cloudflare/cf-terraforming"
        exit 1
    fi

    if [[ -z "$CLOUDFLARE_API_TOKEN" ]] && [[ -z "$CLOUDFLARE_API_KEY" || -z "$CLOUDFLARE_EMAIL" ]]; then
        echo "❌ Error: Cloudflare credentials are not set."
        echo "Please set either CLOUDFLARE_API_TOKEN or both CLOUDFLARE_API_KEY and CLOUDFLARE_EMAIL environment variables."
        exit 1
    fi

    if [[ "$CLOUDFLARE_ACCOUNT_ID" == "your_account_id_here" ]]; then
        echo "❌ Error: Please edit the script and set your CLOUDFLARE_ACCOUNT_ID."
        exit 1
    fi

    echo "✅ Prerequisites met."
}

# --- Generic Generation Function with Error Handling ---
function generate_resource() {
    local resource_type=$1
    local file_path=$2
    shift 2
    local cf_args=("$@")

    local err_path="${file_path}.err"
    echo "   -> Generating '$resource_type'..."

    if cf-terraforming generate --resource-type "$resource_type" "${cf_args[@]}" > "$file_path" 2> "$err_path"; then
        # Command succeeded
        rm "$err_path" # Clean up empty error file
        if [ ! -s "$file_path" ]; then
            # File is empty, meaning no resources of this type were found
            rm "$file_path"
            echo "      - No resources found for '$resource_type'. Cleaned up empty file."
        else
            echo "      ✅ Successfully generated '$resource_type'."
        fi
    else
        # Command failed
        local exit_code=$?
        echo "      ❌ ERROR: 'cf-terraforming' crashed or failed for resource '$resource_type' (Exit Code: $exit_code)."
        if [ -s "$err_path" ]; then
            echo "      - Error details from tool:"
            # Indent the error output for readability
            sed 's/^/      | /' "$err_path"
        fi
        # Clean up the failed output file and the error log
        rm -f "$file_path" "$err_path"
    fi
}

# --- Main Generation Logic ---
function main() {
    check_prerequisites

    echo "🚀 Starting Terraform config generation..."
    mkdir -p "$OUTPUT_DIR"

    # --- Generate Account-Level Resources ---
    echo -e "\n🔄 Processing Account-Level Resources..."
    for resource in "${ACCOUNT_RESOURCES[@]}"; do
        # Set CLOUDFLARE_ACCOUNT_ID env var only for this command
        CLOUDFLARE_ACCOUNT_ID=$CLOUDFLARE_ACCOUNT_ID generate_resource "$resource" "$OUTPUT_DIR/${resource}_account.tf"
    done

    # --- Generate Zone-Level Resources ---
    if [[ "$CLOUDFLARE_ZONE_ID" != "your_zone_id_here" ]] && [[ -n "$CLOUDFLARE_ZONE_ID" ]]; then
        echo -e "\n🔄 Processing Zone-Level Resources for Zone ID: $CLOUDFLARE_ZONE_ID..."
        for resource in "${ZONE_RESOURCES[@]}"; do
            # For zone resources, we DO NOT set the account ID env var, only the --zone flag.
            generate_resource "$resource" "$OUTPUT_DIR/${resource}_zone.tf" --zone "$CLOUDFLARE_ZONE_ID"
        done
    else
        echo -e "\n⏭️  Skipping Zone-Level resources because CLOUDFLARE_ZONE_ID is not set."
    fi

    # --- Generate Account-or-Zone-Level Resources ---
    echo -e "\n🔄 Processing Account-or-Zone-Level Resources..."
    for resource in "${ACCOUNT_OR_ZONE_RESOURCES[@]}"; do
        # Account Level
        CLOUDFLARE_ACCOUNT_ID=$CLOUDFLARE_ACCOUNT_ID generate_resource "$resource" "$OUTPUT_DIR/${resource}_account.tf"

        # Zone Level
        if [[ "$CLOUDFLARE_ZONE_ID" != "your_zone_id_here" ]] && [[ -n "$CLOUDFLARE_ZONE_ID" ]]; then
            generate_resource "$resource" "$OUTPUT_DIR/${resource}_zone.tf" --zone "$CLOUDFLARE_ZONE_ID"
        fi
    done

    echo -e "\n\n🎉 All done!"
    echo "Your Terraform configuration files have been generated in the '$OUTPUT_DIR' directory."
    echo "Please check the output above for any errors that may have occurred during the process."
}

# --- Run Script ---
main
