run "open_config_recorder_with_from_mode" {
  command = apply

  assert {
    condition     = tencentcloud_config_recorder_config.example.id != ""
    error_message = "config recorder id should not be empty"
  }

  assert {
    condition     = tencentcloud_config_recorder_config.example.status == true
    error_message = "recorder should be enabled (status true) after apply"
  }

  assert {
    condition     = tencentcloud_config_recorder_config.example.from_mode == 1
    error_message = "from_mode should be 1"
  }

  assert {
    condition     = length(tencentcloud_config_recorder_config.example.resource_types) == 2
    error_message = "resource_types should contain 2 items returned by DescribeConfigRecorder"
  }

  assert {
    condition     = can(tencentcloud_config_recorder_config.example.create_time) && tencentcloud_config_recorder_config.example.create_time != ""
    error_message = "create_time should be returned by the real cloud API"
  }

  assert {
    condition     = can(tencentcloud_config_recorder_config.example.trigger_count)
    error_message = "trigger_count should be readable from DescribeConfigRecorder"
  }
}

run "verify_recorder_state" {
  command = plan

  assert {
    condition     = tencentcloud_config_recorder_config.example.status == true
    error_message = "recorder status should remain enabled on refresh"
  }

  assert {
    condition     = tencentcloud_config_recorder_config.example.from_mode == 1
    error_message = "from_mode should remain 1 after refresh"
  }
}
