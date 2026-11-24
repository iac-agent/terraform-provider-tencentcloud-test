override_resource {
  target = tencentcloud_ags_sandbox_instance.example
  values = {
    id              = "sbi-mock001"
    instance_id     = "sbi-mock001"
    tool_id         = "tool-mock001"
    tool_name       = "tf-mock-tool"
    timeout         = "10m"
    status          = "RUNNING"
    timeout_seconds = 600
    expires_at      = "2026-01-01T00:10:00Z"
    network_mode    = "PUBLIC"
    persistent      = false
    auth_mode       = "DEFAULT"
  }
}

run "apply_sandbox_instance" {
  command = apply

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.id == "sbi-mock001"
    error_message = "id should be the sandbox instance id sbi-mock001"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.instance_id == "sbi-mock001"
    error_message = "instance_id should be sbi-mock001"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.tool_name == "tf-mock-tool"
    error_message = "tool_name should be tf-mock-tool"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.status == "RUNNING"
    error_message = "status should be RUNNING after creation"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.timeout_seconds == 600
    error_message = "timeout_seconds should be 600"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.timeout == "10m"
    error_message = "timeout should keep the configured create-only value 10m"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.auth_mode == "DEFAULT"
    error_message = "auth_mode should be DEFAULT"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.mount_options[0].name == "workspace"
    error_message = "mount_options[0].name should be workspace"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.metadata[0].name == "owner"
    error_message = "metadata[0].name should be owner"
  }
}
