override_resource {
  target = tencentcloud_config_aggregate_rule.example
  values = {
    id             = "agr-12345678#cr-87654321abcdef"
    config_rule_id = "cr-87654321abcdef"
    status         = "ACTIVE"
  }
}

run "apply_aggregate_rule" {
  command = apply

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.id == "agr-12345678#cr-87654321abcdef"
    error_message = "id should be accountGroupId#ruleId"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.config_rule_id == "cr-87654321abcdef"
    error_message = "config_rule_id should be the mocked rule id"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.account_group_id == "agr-12345678"
    error_message = "account_group_id should be the configured account group"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.identifier == "cam-user-group-bound"
    error_message = "identifier should be the configured template identifier"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.identifier_type == "SYSTEM"
    error_message = "identifier_type should be SYSTEM"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.rule_name == "tf-example-aggregate-rule"
    error_message = "rule_name should be the configured value"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.resource_type[0] == "QCS::CAM::User"
    error_message = "resource_type should contain QCS::CAM::User"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.risk_level == 3
    error_message = "risk_level should be 3"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.trigger_type[0].message_type == "ScheduledNotification"
    error_message = "trigger_type message_type should be ScheduledNotification"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.trigger_type[0].maximum_execution_frequency == "TwentyFour_Hours"
    error_message = "maximum_execution_frequency should be TwentyFour_Hours"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.input_parameter[0].parameter_key == "maxMemorySize"
    error_message = "input_parameter key should be maxMemorySize"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.input_parameter[0].value == "512"
    error_message = "input_parameter value should be 512"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.region_scope[0] == "ap-guangzhou"
    error_message = "region_scope should contain ap-guangzhou"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.exclude_resource_ids_scope[0] == "ins-12345678"
    error_message = "exclude_resource_ids_scope should contain ins-12345678"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.status == "ACTIVE"
    error_message = "status should be ACTIVE"
  }
}
