run "apply_sandbox_instance" {
  command = apply

  assert {
    condition     = can(regex("^inst-[0-9a-zA-Z]+$", tencentcloud_ags_sandbox_instance.example.instance_id))
    error_message = "instance_id should be a real instance id starting with inst-, got: ${tencentcloud_ags_sandbox_instance.example.instance_id}"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.id == tencentcloud_ags_sandbox_instance.example.instance_id
    error_message = "id should be the same as instance_id, got: ${tencentcloud_ags_sandbox_instance.example.id}"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.tool_id == var.tool_id
    error_message = "tool_id should echo the configured sandbox tool"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.status == "RUNNING" || tencentcloud_ags_sandbox_instance.example.status == "STARTING"
    error_message = "status should be RUNNING or STARTING on a freshly started instance, got: ${tencentcloud_ags_sandbox_instance.example.status}"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.auth_mode == "TOKEN"
    error_message = "auth_mode should be TOKEN as configured, got: ${tencentcloud_ags_sandbox_instance.example.auth_mode}"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.create_time != null && tencentcloud_ags_sandbox_instance.example.create_time != ""
    error_message = "create_time should be reported by the cloud, got: ${tencentcloud_ags_sandbox_instance.example.create_time}"
  }
}
