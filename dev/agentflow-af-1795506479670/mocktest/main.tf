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
  tool_id = "tool-1234abcd"
  timeout = "10m"

  mount_options = [
    {
      name       = "workspace"
      mount_path = "/workspace"
      sub_path   = "/sub"
      read_only  = true
    }
  ]

  custom_configuration = {
    image               = "ccr.ccs.tencentyun.com/test/go-httpbin:v2.16.1"
    image_registry_type = "personal"
    command             = ["/bin/go-httpbin"]
    args                = ["-port", "8080"]
    ports = [
      {
        name     = "http"
        port     = 8080
        protocol = "TCP"
      }
    ]
    resources = {
      cpu    = "1"
      memory = "2Gi"
    }
  }

  auth_mode = "TOKEN"

  metadata = [
    {
      name  = "k1"
      value = "v1"
    }
  ]
}
