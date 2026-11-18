run "create_and_verify_aggregator" {
  command = apply

  assert {
    condition     = tencentcloud_config_aggregator.example.id != ""
    error_message = "aggregator id (account_group_id#owner_uin) should not be empty after create"
  }

  assert {
    condition     = tencentcloud_config_aggregator.example.account_group_id != ""
    error_message = "account_group_id returned by DescribeAggregator should not be empty"
  }

  assert {
    condition     = tencentcloud_config_aggregator.example.name == "${var.aggregator_name}-tfagentflow"
    error_message = "aggregator name should match the configured value"
  }

  assert {
    condition     = tencentcloud_config_aggregator.example.description == var.aggregator_description
    error_message = "aggregator description should match the configured value"
  }

  assert {
    condition     = tencentcloud_config_aggregator.example.type == "CUSTOM"
    error_message = "aggregator type should be CUSTOM"
  }

  assert {
    condition     = tencentcloud_config_aggregator.example.owner_uin == local.owner_uin
    error_message = "owner_uin should match the credential-derived value"
  }
}

run "update_aggregator_via_update_api" {
  command = apply

  // Different variable values trigger an in-place update, exercising the
  // UpdateAggregator API path (Name/Description/AggregatorAccounts).
  variables {
    aggregator_name        = "${var.aggregator_name}-updated"
    aggregator_description = "Updated by online test for agentflow af-1794987518032 (UpdateAggregator)"
  }

  assert {
    condition     = tencentcloud_config_aggregator.example.name == "${var.aggregator_name}-updated-tfagentflow"
    error_message = "aggregator name should be updated in place via UpdateAggregator"
  }

  assert {
    condition     = tencentcloud_config_aggregator.example.description == "Updated by online test for agentflow af-1794987518032 (UpdateAggregator)"
    error_message = "aggregator description should be updated in place via UpdateAggregator"
  }

  // Stable identity: id must remain non-empty and unchanged after the in-place update.
  assert {
    condition     = tencentcloud_config_aggregator.example.account_group_id != ""
    error_message = "account_group_id should remain stable after update"
  }

  assert {
    condition     = tencentcloud_config_aggregator.example.owner_uin == local.owner_uin
    error_message = "owner_uin should remain stable after update"
  }

  assert {
    condition     = length(tencentcloud_config_aggregator.example.aggregator_accounts) >= 1
    error_message = "aggregator should still have member accounts after update"
  }
}
