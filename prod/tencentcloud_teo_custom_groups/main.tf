provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

# Query all custom groups of a site (group_types left unset, all types queried).
data "tencentcloud_teo_custom_groups" "all" {
  zone_id = "zone-27h0vbm5w1e"
}

# Query custom groups filtered by every valid group type value.
data "tencentcloud_teo_custom_groups" "filtered" {
  zone_id = "zone-27h0vbm5w1e"

  group_types = ["TLSFingerprint", "UA", "Referer"]
}
