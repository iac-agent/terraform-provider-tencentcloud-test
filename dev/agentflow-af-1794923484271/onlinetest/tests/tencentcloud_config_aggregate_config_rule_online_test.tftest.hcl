run "create_aggregate_config_rule" {
  command = apply

  # account group created by this test
  assert {
    condition     = tencentcloud_config_aggregator.example.account_group_id != ""
    error_message = "aggregator account_group_id should not be empty"
  }

  # composite id is <account_group_id>#<rule_id>
  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.id == "${tencentcloud_config_aggregator.example.account_group_id}#${tencentcloud_config_aggregate_config_rule.example.config_rule_id}"
    error_message = "id should be <account_group_id>#<rule_id>"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.config_rule_id != ""
    error_message = "config_rule_id should be returned by the cloud"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.rule_name == "${var.rule_name_prefix}-rule"
    error_message = "rule_name should be the configured value"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.identifier == "cam-user-group-bound"
    error_message = "identifier should be the configured preset rule id"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.identifier_type == "SYSTEM"
    error_message = "identifier_type should be SYSTEM"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.account_group_id == tencentcloud_config_aggregator.example.account_group_id
    error_message = "account_group_id should match the aggregator created by this test"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.risk_level == 3
    error_message = "risk_level should be 3"
  }

  assert {
    condition     = length(tencentcloud_config_aggregate_config_rule.example.resource_type) == 1 && tencentcloud_config_aggregate_config_rule.example.resource_type[0] == "QCS::CAM::User"
    error_message = "resource_type should contain QCS::CAM::User"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.trigger_type[0].message_type == "ScheduledNotification"
    error_message = "trigger_type[0].message_type should be ScheduledNotification as returned by the cloud"
  }

  # cloud-owned fields reported by DescribeAggregateConfigRule
  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.status == "ACTIVE"
    error_message = "a new rule should be ACTIVE"
  }

  assert {
    condition     = tencentcloud_config_aggregate_config_rule.example.create_time != ""
    error_message = "create_time should be reported by the cloud"
  }
}
