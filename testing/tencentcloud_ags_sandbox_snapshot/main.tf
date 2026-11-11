provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

resource "tencentcloud_ags_sandbox_snapshot" "example" {
  instance_id   = "sandbox-8f9de2ab"
  snapshot_name = "tf-test-snapshot"
  memory        = true
  client_token  = "tf-test-client-token-001"

  tags = [
    {
      key   = "env"
      value = "test"
    },
    {
      key   = "owner"
      value = "tf"
    },
  ]
}

import {
  to = tencentcloud_ags_sandbox_snapshot.example
  id = "snap-mock-0001"
}
