provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

data "tencentcloud_makers_deployment_log" "example" {
  zone_id       = "zone-abc123"
  project_id    = "proj-123456"
  deployment_id = "deploy-987654"
}
