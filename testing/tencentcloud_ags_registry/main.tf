provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

resource "tencentcloud_ags_registry" "example" {
  name          = "ags-registry-test"
  description   = "created by terraform acctest"
  approval_mode = "AUTO"

  tags = [
    {
      key   = "env"
      value = "test"
    },
    {
      key   = "team"
      value = "qa"
    },
  ]
}

import {
  to = tencentcloud_ags_registry.example
  id = "reg-abcdef01"
}
