# Online test: `terraform test` runs against the real cloud, so every assert
# below checks values returned by StartSandboxInstance / DescribeSandboxInstances
# and by CreateSandboxTool / DescribeSandboxToolList (no mock override here).
# The sandbox tool is created by main.tf as the parent of the sandbox instance,
# and `terraform test` destroys both at the end of the run (no residue).

run "apply_ags_sandbox_instance" {
  command = apply

  # --- identity of the started sandbox instance ---
  assert {
    condition     = can(regex("^[A-Za-z0-9][A-Za-z0-9-]{7,}$", tencentcloud_ags_sandbox_instance.example.id))
    error_message = "sandbox instance id should be a non-empty cloud id, got: ${tencentcloud_ags_sandbox_instance.example.id}"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.instance_id == tencentcloud_ags_sandbox_instance.example.id
    error_message = "instance_id should be the same as the resource id, got instance_id=${tencentcloud_ags_sandbox_instance.example.instance_id} id=${tencentcloud_ags_sandbox_instance.example.id}"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.tool_id == tencentcloud_ags_sandbox_tool.example.id
    error_message = "tool_id should be the id of the sandbox tool created for this run, got: ${tencentcloud_ags_sandbox_instance.example.tool_id}"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.tool_name == local.tool_name
    error_message = "tool_name reported by the cloud should be ${local.tool_name}, got: ${tencentcloud_ags_sandbox_instance.example.tool_name}"
  }

  # --- state of the freshly started instance, as reported by the cloud ---
  assert {
    condition     = contains(["STARTING", "RUNNING"], tencentcloud_ags_sandbox_instance.example.status)
    error_message = "a freshly started sandbox instance should be STARTING or RUNNING, got: ${tencentcloud_ags_sandbox_instance.example.status}"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.network_mode == "PUBLIC"
    error_message = "the instance should inherit the PUBLIC network mode of the sandbox tool, got: ${tencentcloud_ags_sandbox_instance.example.network_mode}"
  }

  assert {
    condition     = contains(["DEFAULT", "TOKEN", "NONE", "PUBLIC"], tencentcloud_ags_sandbox_instance.example.auth_mode)
    error_message = "auth_mode should be a cloud supported value, got: ${tencentcloud_ags_sandbox_instance.example.auth_mode}"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.persistent != null
    error_message = "persistent should be reported by the cloud"
  }

  # --- timeout is configured as `<n>m` and reported back in seconds ---
  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.timeout == local.instance_timeout
    error_message = "timeout should keep the configured value ${local.instance_timeout}, got: ${tencentcloud_ags_sandbox_instance.example.timeout}"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.timeout_seconds == var.instance_timeout_minutes * 60
    error_message = "the cloud should report timeout_seconds = ${var.instance_timeout_minutes * 60}, got: ${tencentcloud_ags_sandbox_instance.example.timeout_seconds}"
  }

  # --- computed outputs are filled from the describe answer ---
  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.create_time != null && tencentcloud_ags_sandbox_instance.example.create_time != ""
    error_message = "create_time should be reported by the cloud, got: ${tencentcloud_ags_sandbox_instance.example.create_time}"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.stop_reason == null
    error_message = "a running instance should not have a stop_reason, got: ${tencentcloud_ags_sandbox_instance.example.stop_reason}"
  }

  # --- metadata is sent at start time and reported back by the describe API ---
  assert {
    condition = (
      tencentcloud_ags_sandbox_instance.example.metadata == null ||
      (length(tencentcloud_ags_sandbox_instance.example.metadata) == 1 &&
      tencentcloud_ags_sandbox_instance.example.metadata[0].value == "tf-agentflow")
    )
    error_message = "metadata should keep the single createdBy=tf-agentflow entry, got: ${jsonencode(tencentcloud_ags_sandbox_instance.example.metadata)}"
  }
}

# Re-planning the very same configuration must not replace the running sandbox
# instance (a replacement would leak the first instance until its timeout): the
# ids stay known from state and are not marked for replacement.
run "plan_ags_sandbox_instance_is_stable" {
  command = plan

  assert {
    condition     = can(regex("^[A-Za-z0-9][A-Za-z0-9-]{7,}$", tencentcloud_ags_sandbox_instance.example.id))
    error_message = "re-planning must keep the existing sandbox instance id from state, got: ${tencentcloud_ags_sandbox_instance.example.id}"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.instance_id == tencentcloud_ags_sandbox_instance.example.id
    error_message = "instance_id must still equal the id on re-plan"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.tool_id == tencentcloud_ags_sandbox_tool.example.id
    error_message = "tool_id must stay unchanged on re-plan, got: ${tencentcloud_ags_sandbox_instance.example.tool_id}"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.example.timeout == local.instance_timeout
    error_message = "timeout must stay unchanged on re-plan, got: ${tencentcloud_ags_sandbox_instance.example.timeout}"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_tool.example.id == tencentcloud_ags_sandbox_instance.example.tool_id
    error_message = "the sandbox tool created for this run must not be replaced on re-plan"
  }
}
