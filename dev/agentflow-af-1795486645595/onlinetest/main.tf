provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# Prerequisite of the instance under test: a sandbox tool created by this test
# itself, so the case never references pre-existing cloud resources and can be
# fully destroyed afterwards.
resource "tencentcloud_ags_sandbox_tool" "instance_source" {
  tool_name = var.tool_name
  tool_type = "custom"

  network_configuration = {
    network_mode = "PUBLIC"
    vpc_config   = null
  }

  custom_configuration = {
    image               = var.image
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

  persistent = false
}

# Resource under test: StartSandboxInstance.
resource "tencentcloud_ags_sandbox_instance" "example" {
  tool_name = tencentcloud_ags_sandbox_tool.instance_source.tool_name
  timeout   = var.timeout
}
