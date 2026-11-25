provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

data "tencentcloud_teo_custom_groups" "example" {
  zone_id = "zone-27h0vbm5w1e"

  group_types = ["TLSFingerprint", "UA"]
}

data "tencentcloud_teo_custom_groups" "all" {
  zone_id = "zone-27h0vbm5w1e"
}

data "tencentcloud_teo_custom_groups" "referer" {
  zone_id = "zone-27h0vbm5w1e"

  group_types = ["Referer"]
}
