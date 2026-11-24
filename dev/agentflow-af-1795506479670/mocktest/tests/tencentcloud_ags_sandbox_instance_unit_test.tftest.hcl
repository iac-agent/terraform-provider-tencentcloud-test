override_resource {
  target = tencentcloud_ags_sandbox_instance.example
  values = {
    id              = "inst-8765dcba"
    instance_id     = "inst-8765dcba"
    tool_id         = "tool-1234abcd"
    tool_name       = "tf-example"
    status          = "RUNNING"
    persistent      = false
    timeout_seconds = 600
    expires_at      = "2026-01-01T01:00:00Z"
    network_mode    = "PUBLIC"
    auth_mode       = "TOKEN"
    create_time     = "2026-01-01T00:00:00Z"
    update_time     = "2026-01-01T00:10:00Z"
  }
}

run "apply_sandbox_instance" {
  command = apply

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.id == "inst-8765dcba"
    error_message = "id should be the sandbox instance id inst-8765dcba"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.instance_id == "inst-8765dcba"
    error_message = "instance_id should be inst-8765dcba"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.tool_id == "tool-1234abcd"
    error_message = "tool_id should be tool-1234abcd"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.status == "RUNNING"
    error_message = "status should be RUNNING"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.timeout_seconds == 600
    error_message = "timeout_seconds should be 600"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.network_mode == "PUBLIC"
    error_message = "network_mode should be PUBLIC"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.auth_mode == "TOKEN"
    error_message = "auth_mode should be TOKEN"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.timeout == "10m"
    error_message = "timeout should be kept as configured (10m)"
  }
}
