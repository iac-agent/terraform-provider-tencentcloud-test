provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource block(s) for the resource under test are appended below by the
# agent. Do not remove or modify the provider block above.
# ==============================================================================

resource "tencentcloud_ags_sandbox_instance" "example" {
  tool_id = var.tool_id
  timeout = var.instance_timeout

  custom_configuration = {
    image               = var.image
    image_registry_type = var.image_registry_type
  }

  auth_mode = "TOKEN"

  metadata = [
    {
      name  = var.metadata_name
      value = var.metadata_value
    }
  ]
}
