override_resource {
  target = tencentcloud_config_recorder_config.example
  values = {
    id            = "config-recorder-mock-id"
    create_time   = "2025-01-01 00:00:00"
    trigger_count = 3
    open_count    = 1
    update_count  = 2
  }
}

run "create_config_recorder" {
  command = apply

  assert {
    condition     = tencentcloud_config_recorder_config.example.id == "config-recorder-mock-id"
    error_message = "id should be config-recorder-mock-id"
  }

  assert {
    condition     = tencentcloud_config_recorder_config.example.status == true
    error_message = "status should be true"
  }

  assert {
    condition     = tencentcloud_config_recorder_config.example.from_mode == 1
    error_message = "from_mode should be 1 (called from control center)"
  }

  assert {
    condition     = length(tencentcloud_config_recorder_config.example.resource_types) == 2
    error_message = "resource_types should contain 2 items"
  }

  assert {
    condition     = tencentcloud_config_recorder_config.example.resource_types[0] == "QCS::CAM::Group"
    error_message = "resource_types[0] should be QCS::CAM::Group"
  }

  assert {
    condition     = tencentcloud_config_recorder_config.example.create_time == "2025-01-01 00:00:00"
    error_message = "create_time should be mocked value"
  }

  assert {
    condition     = tencentcloud_config_recorder_config.example.trigger_count == 3
    error_message = "trigger_count should be mocked value 3"
  }

  assert {
    condition     = tencentcloud_config_recorder_config.example.open_count == 1
    error_message = "open_count should be mocked value 1"
  }

  assert {
    condition     = tencentcloud_config_recorder_config.example.update_count == 2
    error_message = "update_count should be mocked value 2"
  }
}

run "update_from_mode" {
  command = plan

  assert {
    condition     = tencentcloud_config_recorder_config.example.from_mode == 1
    error_message = "from_mode should remain 1 after plan"
  }

  assert {
    condition     = tencentcloud_config_recorder_config.example.status == true
    error_message = "status should remain true after plan"
  }
}
