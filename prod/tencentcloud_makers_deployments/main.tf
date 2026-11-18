provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

data "tencentcloud_makers_deployments" "example" {
  zone_id        = "zone-2qk1q3x8"
  project_id     = "proj-1234567890"
  deployment_ids = ["dpl-abcdefg1", "dpl-abcdefg2"]

  filters = [
    {
      name   = "Status"
      values = ["Success", "Failed"]
    },
    {
      name   = "RepoBranch"
      values = ["main"]
    },
  ]

  order_by   = "CreatedOn"
  order_type = "Desc"
  start_time = "2024-01-01T00:00:00Z"
  end_time   = "2024-12-31T23:59:59Z"
}
