run "create_aggregate_rule" {
  command = apply

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.id != ""
    error_message = "resource id (accountGroupId#ruleId) should not be empty"
  }

  assert {
    condition     = can(regex("^${var.account_group_id}#", tencentcloud_config_aggregate_rule.example.id))
    error_message = "resource id should start with the configured account group id"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.config_rule_id != ""
    error_message = "config_rule_id returned by the cloud should not be empty"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.rule_name == local.rule_name
    error_message = "rule_name should match the requested value"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.identifier == var.identifier
    error_message = "identifier should match the requested system template"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.identifier_type == "SYSTEM"
    error_message = "identifier_type should be SYSTEM"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.account_group_id == var.account_group_id
    error_message = "account_group_id should match the requested account group"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.risk_level == var.risk_level
    error_message = "risk_level should match the requested value"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.trigger_type[0].message_type == "ScheduledNotification"
    error_message = "trigger_type message_type should be ScheduledNotification as created"
  }

  assert {
    condition     = tencentcloud_config_aggregate_rule.example.resource_type[0] == var.resource_type[0]
    error_message = "resource_type should match the requested value"
  }
}
