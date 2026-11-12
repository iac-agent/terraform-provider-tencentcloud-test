provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

resource "tencentcloud_ags_pre_cache_image_task" "example" {
  image               = "ccr.ccs.tencentyun.com/tf-example/demo:v1"
  image_registry_type = "personal"
}

import {
  to = tencentcloud_ags_pre_cache_image_task.example
  id = "cache-001"
}
