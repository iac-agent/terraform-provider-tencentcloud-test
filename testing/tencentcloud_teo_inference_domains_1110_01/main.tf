provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

data "tencentcloud_teo_inference_domains_1110_01" "example" {
  zone_id    = "zone-2p6f4u8x"
  service_id = "es-abc12345"
  sort_by    = "CreateTime"
  sort_order = "Desc"
}
