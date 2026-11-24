run "start_sandbox_instance" {
  command = apply

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.id != "" && can(regex("^sbi-", tencentcloud_ags_sandbox_instance.example.instance_id))
    error_message = "instance_id should be a non-empty sandbox instance id returned by the real cloud"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.tool_id == tencentcloud_ags_sandbox_tool.instance_source.tool_id
    error_message = "tool_id reported by the cloud should be the id of the sandbox tool created by this test"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.tool_name == var.tool_name
    error_message = "tool_name reported by the cloud should equal the configured tool name"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.status == "RUNNING"
    error_message = "status should be RUNNING after the provider finished waiting for the instance"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.timeout_seconds > 0
    error_message = "timeout_seconds reported by the cloud should be a positive value"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.create_time != ""
    error_message = "create_time reported by the cloud should be non-empty"
  }
}
