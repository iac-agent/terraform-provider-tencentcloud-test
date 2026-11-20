provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

resource "tencentcloud_config_recorder_config" "example" {
  status    = true
  from_mode = 2

  resource_types = [
    "QCS::CAM::Group",
    "QCS::CAM::Role",
  ]
}
