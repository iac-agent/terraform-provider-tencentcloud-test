override_data {
  target = data.tencentcloud_config_system_rules.all
  values = {
    rule_list = [
      {
        identifier      = "cam-user-mfa-enabled"
        rule_name       = "MFA enabled for CAM users"
        description     = "Check CAM users have MFA enabled"
        risk_level      = 1
        identifier_type = "SYSTEM"
        reference_count = 3
      },
      {
        identifier      = "cvm-unattached-disk"
        rule_name       = "Unattached disk check"
        description     = "Check unattached cloud disks"
        risk_level      = 3
        identifier_type = "SYSTEM"
        reference_count = 1
      }
    ]
  }
}

override_data {
  target = data.tencentcloud_config_system_rules.by_keyword
  values = {
    rule_list = [
      {
        identifier      = "cam-user-mfa-enabled"
        rule_name       = "MFA enabled for CAM users"
        description     = "Check CAM users have MFA enabled"
        risk_level      = 1
        identifier_type = "SYSTEM"
        reference_count = 3
      }
    ]
  }
}

override_data {
  target = data.tencentcloud_config_system_rules.by_risk
  values = {
    rule_list = [
      {
        identifier      = "cam-user-mfa-enabled"
        rule_name       = "MFA enabled for CAM users"
        description     = "Check CAM users have MFA enabled"
        risk_level      = 1
        identifier_type = "SYSTEM"
        reference_count = 3
      }
    ]
  }
}

override_data {
  target = data.tencentcloud_config_system_rule.detail
  values = {
    identifier = "cam-user-mfa-enabled"
    system_config_rule = [
      {
        identifier      = "cam-user-mfa-enabled"
        rule_name       = "MFA enabled for CAM users"
        description     = "Check CAM users have MFA enabled"
        risk_level      = 1
        service_function = "cam"
        identifier_type = "SYSTEM"
        reference_count = 3
      }
    ]
  }
}

run "list_all_system_rules" {
  command = apply

  assert {
    condition     = length(data.tencentcloud_config_system_rules.all.rule_list) == 2
    error_message = "should return 2 mocked system rules"
  }

  assert {
    condition     = data.tencentcloud_config_system_rules.all.rule_list[0].identifier == "cam-user-mfa-enabled"
    error_message = "first rule identifier should be cam-user-mfa-enabled"
  }

  assert {
    condition     = data.tencentcloud_config_system_rules.all.rule_list[1].risk_level == 3
    error_message = "second rule risk_level should be 3"
  }
}

run "filter_by_keyword" {
  command = apply

  assert {
    condition     = length(data.tencentcloud_config_system_rules.by_keyword.rule_list) == 1
    error_message = "keyword filter should return 1 mocked rule"
  }

  assert {
    condition     = data.tencentcloud_config_system_rules.by_keyword.rule_list[0].rule_name == "MFA enabled for CAM users"
    error_message = "filtered rule name mismatch"
  }
}

run "filter_by_risk_level" {
  command = apply

  assert {
    condition     = length(data.tencentcloud_config_system_rules.by_risk.rule_list) == 1
    error_message = "risk level filter should return 1 mocked rule"
  }

  assert {
    condition     = data.tencentcloud_config_system_rules.by_risk.rule_list[0].risk_level == 1
    error_message = "filtered rule risk_level should be 1"
  }
}

run "describe_system_rule_detail" {
  command = apply

  assert {
    condition     = data.tencentcloud_config_system_rule.detail.identifier == "cam-user-mfa-enabled"
    error_message = "detail identifier should match input"
  }

  assert {
    condition     = length(data.tencentcloud_config_system_rule.detail.system_config_rule) == 1
    error_message = "system_config_rule should have 1 item"
  }

  assert {
    condition     = data.tencentcloud_config_system_rule.detail.system_config_rule[0].rule_name == "MFA enabled for CAM users"
    error_message = "detail rule_name mismatch"
  }

  assert {
    condition     = data.tencentcloud_config_system_rule.detail.system_config_rule[0].service_function == "cam"
    error_message = "detail service_function mismatch"
  }
}
