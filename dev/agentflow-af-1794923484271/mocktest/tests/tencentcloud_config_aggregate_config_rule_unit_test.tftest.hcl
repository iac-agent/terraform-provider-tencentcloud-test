override_resource {
  target = tencentcloud_config_aggregate_config_rule.example
  values = {
    id             = "ca-Zp9EiU7Pa4Vy0lFFm8XM#cr-12345678"
    config_rule_id = "cr-12345678"
    status         = "ACTIVE"
    create_time    = "2024-01-01 00:00:00"
  }
}

run "apply_aggregate_config_rule" {
  command = apply

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.id == "ca-Zp9EiU7Pa4Vy0lFFm8XM#cr-12345678"
    error_message = "id should be account_group_id#rule_id"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.config_rule_id == "cr-12345678"
    error_message = "config_rule_id should be the mock rule id"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.account_group_id == "ca-Zp9EiU7Pa4Vy0lFFm8XM"
    error_message = "account_group_id should be the configured value"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.identifier == "cam-password-policy-check"
    error_message = "identifier should be the configured value"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.identifier_type == "SYSTEM"
    error_message = "identifier_type should be SYSTEM"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.rule_name == "tf-mock-aggregate-config-rule"
    error_message = "rule_name should be the configured value"
  }

  assert {
    condition     = length(tencentcloud_config_aggregate_config_rule.example.resource_type) == 1 && tencentcloud_config_aggregate_config_rule.example.resource_type[0] == "QCS::CAM::User"
    error_message = "resource_type should contain QCS::CAM::User"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.risk_level == 1
    error_message = "risk_level should be 1"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.trigger_type[0].message_type == "ScheduledNotification"
    error_message = "trigger_type[0].message_type should be ScheduledNotification"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.trigger_type[0].maximum_execution_frequency == "TwentyFour_Hours"
    error_message = "trigger_type[0].maximum_execution_frequency should be TwentyFour_Hours"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.input_parameter[0].parameter_key == "MinimumLength"
    error_message = "input_parameter[0].parameter_key should be MinimumLength"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.input_parameter[0].value == "8"
    error_message = "input_parameter[0].value should be 8"
  }

  assert {
    condition     = length(tencentcloud_config_aggregate_config_rule.example.region_scope) == 2
    error_message = "region_scope should have 2 entries"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.tags_scope[0].tag_key == "env" && tencentcloud_config_aggregate_config_rule.example.tags_scope[0].tag_value == "prod"
    error_message = "tags_scope[0] should be env=prod"
  }

  assert {
    condition     = length(tencentcloud_config_aggregate_config_rule.example.exclude_resource_ids_scope) == 1
    error_message = "exclude_resource_ids_scope should have 1 entry"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.status == "ACTIVE"
    error_message = "status should be ACTIVE (mocked read-back value)"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.create_time == "2024-01-01 00:00:00"
    error_message = "create_time should be the mocked read-back value"
  }
}
