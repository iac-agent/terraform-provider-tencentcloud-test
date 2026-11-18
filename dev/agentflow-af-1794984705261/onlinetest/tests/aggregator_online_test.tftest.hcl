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
    condition     = tencentcloud_config_aggregator.example.name == local.aggregator_name
    error_message = "aggregator name should match the configured value"
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

run "update_aggregator" {
  command = apply

  assert {
    condition     = tencentcloud_config_aggregator.example.name == local.aggregator_name
    error_message = "aggregator name should be unchanged (no update yet)"
  }
}
