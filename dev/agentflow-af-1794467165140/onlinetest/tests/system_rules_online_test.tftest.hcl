run "list_all_system_rules_online" {
  command = apply

  assert {
    condition     = length(data.tencentcloud_config_system_rules.all-tfagentflow.rule_list) > 0
    error_message = "system preset rules list should not be empty in real environment"
  }

  assert {
    condition     = data.tencentcloud_config_system_rules.all-tfagentflow.rule_list[0].identifier != ""
    error_message = "first rule identifier should not be empty"
  }
}

run "filter_by_keyword_online" {
  command = apply

  assert {
    condition     = length(data.tencentcloud_config_system_rules.by-keyword-tfagentflow.rule_list) > 0
    error_message = "keyword fuzzy filter should match at least the rule with the given identifier"
  }
}

run "describe_system_rule_detail_online" {
  command = apply

  assert {
    condition     = data.tencentcloud_config_system_rule.detail-tfagentflow.identifier == var.rule_identifier
    error_message = "detail identifier should equal the requested identifier"
  }

  assert {
    condition     = length(data.tencentcloud_config_system_rule.detail-tfagentflow.system_config_rule) == 1
    error_message = "system_config_rule should contain exactly 1 rule"
  }

  assert {
    condition     = data.tencentcloud_config_system_rule.detail-tfagentflow.system_config_rule[0].rule_name != ""
    error_message = "rule_name should not be empty in real environment"
  }
}
