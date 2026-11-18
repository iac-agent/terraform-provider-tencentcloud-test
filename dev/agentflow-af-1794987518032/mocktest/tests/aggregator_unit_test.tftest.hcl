override_resource {
  target = tencentcloud_config_aggregator.example
  values = {
    id                = "ca-Zp9EiU7Pa4Vy0lFFm8XM#100012345678"
    account_group_id  = "ca-Zp9EiU7Pa4Vy0lFFm8XM"
    owner_uin         = "100012345678"
    name              = "tf-mock-aggregator"
    description       = "Mock aggregator created by terraform test"
    type              = "CUSTOM"
    aggregator_status = 1
    aggregator_accounts = [
      {
        member_uin  = 100012345679
        member_name = "member-1"
      },
      {
        member_uin  = 100012345680
        member_name = "member-2"
      }
    ]
  }
}

run "apply_config_aggregator" {
  command = apply

  assert {
    condition     = tencentcloud_config_aggregator.example.id == "ca-Zp9EiU7Pa4Vy0lFFm8XM#100012345678"
    error_message = "id should be account_group_id#owner_uin"
  }

  assert {
    condition     = tencentcloud_config_aggregator.example.account_group_id == "ca-Zp9EiU7Pa4Vy0lFFm8XM"
    error_message = "account_group_id should be the mock aggregator id"
  }

  assert {
    condition     = tencentcloud_config_aggregator.example.owner_uin == "100012345678"
    error_message = "owner_uin should be the configured value"
  }

  assert {
    condition     = tencentcloud_config_aggregator.example.name == "tf-mock-aggregator"
    error_message = "name should be the configured value"
  }

  assert {
    condition     = tencentcloud_config_aggregator.example.type == "CUSTOM"
    error_message = "type should be CUSTOM"
  }

  assert {
    condition     = tencentcloud_config_aggregator.example.aggregator_status == 1
    error_message = "aggregator_status should be 1"
  }

  assert {
    condition     = length(tencentcloud_config_aggregator.example.aggregator_accounts) == 2
    error_message = "aggregator_accounts should contain 2 members"
  }

  assert {
    condition     = tencentcloud_config_aggregator.example.aggregator_accounts[0].member_uin == 100012345679 && tencentcloud_config_aggregator.example.aggregator_accounts[0].member_name == "member-1"
    error_message = "first member should be 100012345679/member-1"
  }

  assert {
    condition     = tencentcloud_config_aggregator.example.aggregator_accounts[1].member_uin == 100012345680 && tencentcloud_config_aggregator.example.aggregator_accounts[1].member_name == "member-2"
    error_message = "second member should be 100012345680/member-2"
  }
}
