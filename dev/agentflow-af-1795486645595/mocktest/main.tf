provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

resource "tencentcloud_ags_sandbox_instance" "example" {
  tool_name = "tf-mock-tool"
  timeout   = "10m"
  auth_mode = "DEFAULT"

  mount_options = [
    {
      name       = "workspace"
      mount_path = "/workspace"
      sub_path   = null
      read_only  = false
    }
  ]

  custom_configuration = {
    image               = "ccr.ccs.tencentyun.com/test/go-httpbin:v2.16.1"
    image_registry_type = "personal"
    command             = ["/bin/go-httpbin"]
    args                = ["-port", "8080"]
    env                 = null
    ports               = null
    dns_config          = null
    security_context    = null
    resources = {
      cpu     = "1"
      memory  = "1Gi"
      storage = null
    }
    probe = null
  }

  metadata = [
    {
      name  = "owner"
      value = "terraform"
    }
  ]
}
