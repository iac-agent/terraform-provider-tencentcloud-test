provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

locals {
  # AGS tool names must be unique per AppId, so the prefix provided at
  # execution time gets a fixed suffix.
  tool_name = "${var.tool_name_prefix}-tfagentflow"

  # StartSandboxInstance accepts duration strings (`5m`, `300s`, `1h`); the
  # cloud reports the same duration back in `timeout_seconds`.
  instance_timeout = "${var.instance_timeout_minutes}m"
}

# A sandbox instance can only be started from a sandbox tool (or a snapshot /
# source instance), so the tool is created by this very test configuration
# instead of referencing an existing one. Both resources are destroyed by
# `terraform test` at the end of the run, leaving no residue on the cloud.
resource "tencentcloud_ags_sandbox_tool" "example" {
  tool_name   = local.tool_name
  tool_type   = "custom"
  description = "AGS sandbox tool created by the agentflow online test for tencentcloud_ags_sandbox_instance."

  network_configuration = {
    network_mode = "PUBLIC"
  }

  custom_configuration = {
    image               = var.sandbox_image
    image_registry_type = var.image_registry_type

    ports = [
      {
        name     = "http"
        port     = var.container_port
        protocol = "TCP"
      },
    ]

    resources = {
      cpu    = var.cpu
      memory = var.memory
    }
  }
}

resource "tencentcloud_ags_sandbox_instance" "example" {
  tool_id   = tencentcloud_ags_sandbox_tool.example.id
  timeout   = local.instance_timeout
  auth_mode = "DEFAULT"

  metadata = [
    {
      name  = "createdBy"
      value = "tf-agentflow"
    },
  ]
}
