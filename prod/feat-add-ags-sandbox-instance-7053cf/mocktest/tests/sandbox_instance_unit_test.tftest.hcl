override_resource {
  target = tencentcloud_ags_sandbox_instance.full
  values = {
    id               = "instance-mock0001"
    instance_id      = "instance-mock0001"
    tool_id          = "tool-mock0001"
    network_mode     = "PUBLIC"
    persistent       = false
    status           = "RUNNING"
    timeout_seconds  = 1800
    expires_at       = "2025-09-20T10:30:00Z"
    stop_reason      = null
    create_time      = "2025-09-20T10:00:00Z"
    update_time      = "2025-09-20T10:00:00Z"
    computer_configuration = {
      os_world_configuration = {
        version = "osworld1"
      }
    }
  }
}

override_resource {
  target = tencentcloud_ags_sandbox_instance.clone
  values = {
    id               = "instance-mock0002"
    instance_id      = "instance-mock0002"
    tool_name        = "tf-example-tool"
    auth_mode        = "DEFAULT"
    network_mode     = "SANDBOX"
    persistent       = false
    status           = "RUNNING"
    timeout_seconds  = 300
    expires_at       = "2025-09-20T09:05:00Z"
    stop_reason      = null
    create_time      = "2025-09-20T09:00:00Z"
    update_time      = "2025-09-20T09:00:00Z"
    computer_configuration = {
      os_world_configuration = {
        version = "osworld1"
      }
    }
  }
}

run "start_sandbox_instance_full" {
  command = apply

  assert {
    condition     = tencentcloud_ags_sandbox_instance.full.id == "instance-mock0001" && tencentcloud_ags_sandbox_instance.full.instance_id == tencentcloud_ags_sandbox_instance.full.id
    error_message = "id should be the mocked instance id and should be the same as instance_id"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.full.status == "RUNNING" && tencentcloud_ags_sandbox_instance.full.network_mode == "PUBLIC" && tencentcloud_ags_sandbox_instance.full.persistent == false
    error_message = "status / network_mode / persistent should be the mocked cloud values"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.full.timeout_seconds == 1800 && tencentcloud_ags_sandbox_instance.full.expires_at == "2025-09-20T10:30:00Z"
    error_message = "timeout_seconds should be 1800 and expires_at should be the mocked value"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.full.tool_name == "tf-example-tool" && tencentcloud_ags_sandbox_instance.full.timeout == "30m" && tencentcloud_ags_sandbox_instance.full.auth_mode == "DEFAULT"
    error_message = "tool_name / timeout / auth_mode should keep the configured values"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.full.custom_configuration.image == "ccr.ccs.tencentyun.com/tf-example/go-httpbin:v2.16.1" && tencentcloud_ags_sandbox_instance.full.custom_configuration.ports[0].port == 8080 && tencentcloud_ags_sandbox_instance.full.custom_configuration.resources.storage == "5Gi" && tencentcloud_ags_sandbox_instance.full.metadata[0].value == "tf-example"
    error_message = "custom_configuration and metadata should keep the configured values"
  }
}

run "start_sandbox_instance_from_source" {
  command = apply

  assert {
    condition     = tencentcloud_ags_sandbox_instance.clone.id == "instance-mock0002" && tencentcloud_ags_sandbox_instance.clone.instance_id == "instance-mock0002"
    error_message = "clone instance id should be the mocked instance id"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.clone.tool_id == "tool-mock0001" && tencentcloud_ags_sandbox_instance.clone.source_instance_id == "instance-source0001"
    error_message = "tool_id / source_instance_id should keep the configured values"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.clone.timeout == "300s" && tencentcloud_ags_sandbox_instance.clone.timeout_seconds == 300
    error_message = "timeout should be 300s and the cloud-side timeout_seconds should be 300"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_instance.clone.status == "RUNNING" && tencentcloud_ags_sandbox_instance.clone.network_mode == "SANDBOX"
    error_message = "status / network_mode should be the mocked cloud values"
  }
}
