run "apply_alb_rules" {
  command = apply

  assert {
    condition     = tencentcloud_alb_rules.example.id == "${var.load_balancer_id}#${var.listener_id}"
    error_message = "id should be the composite of load_balancer_id and listener_id joined by '#', got: ${tencentcloud_alb_rules.example.id}"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.load_balancer_id == var.load_balancer_id
    error_message = "load_balancer_id should echo the configured load balancer"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.listener_id == var.listener_id
    error_message = "listener_id should echo the configured listener"
  }

  assert {
    condition     = length(tencentcloud_alb_rules.example.rules) == 1
    error_message = "rules should contain exactly one rule, got: ${length(tencentcloud_alb_rules.example.rules)}"
  }

  assert {
    condition     = can(regex("^rule-[0-9a-zA-Z]{8}$", tencentcloud_alb_rules.example.rules[0].rule_id))
    error_message = "rules[0].rule_id should match rule- followed by 8 alphanumeric characters, got: ${tencentcloud_alb_rules.example.rules[0].rule_id}"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].priority == 20001
    error_message = "rules[0].priority should echo the configured priority"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].direction == "Request"
    error_message = "rules[0].direction should be Request"
  }

  assert {
    condition     = can(regex("^${var.rule_name_prefix}-tfagentflow-", tencentcloud_alb_rules.example.rules[0].rule_name))
    error_message = "rules[0].rule_name should start with the configured prefix, got: ${tencentcloud_alb_rules.example.rules[0].rule_name}"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].status == "Active" || tencentcloud_alb_rules.example.rules[0].status == "Provisioning"
    error_message = "rules[0].status should be Active or Provisioning right after creation, got: ${tencentcloud_alb_rules.example.rules[0].status}"
  }

  assert {
    condition     = length(tencentcloud_alb_rules.example.rules[0].conditions) == 1 && tencentcloud_alb_rules.example.rules[0].conditions[0].type == "Path"
    error_message = "rules[0].conditions should contain one Path condition, got: ${jsonencode(tencentcloud_alb_rules.example.rules[0].conditions[*].type)}"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].conditions[0].path_config[0] == "/tfagentflow/"
    error_message = "rules[0].conditions[0].path_config should echo the configured path, got: ${jsonencode(tencentcloud_alb_rules.example.rules[0].conditions[0].path_config)}"
  }

  assert {
    condition     = length(tencentcloud_alb_rules.example.rules[0].actions) == 2
    error_message = "rules[0].actions should contain exactly two actions, got: ${length(tencentcloud_alb_rules.example.rules[0].actions)}"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].actions[0].type == "InsertHeader" && tencentcloud_alb_rules.example.rules[0].actions[0].order == 1
    error_message = "rules[0].actions[0] should be the InsertHeader action with order 1, got: ${tencentcloud_alb_rules.example.rules[0].actions[0].type}/${tencentcloud_alb_rules.example.rules[0].actions[0].order}"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].actions[0].insert_header_config.key == "X-Custom-Env" && tencentcloud_alb_rules.example.rules[0].actions[0].insert_header_config.value == "tfagentflow" && tencentcloud_alb_rules.example.rules[0].actions[0].insert_header_config.value_type == "UserDefined"
    error_message = "rules[0].actions[0].insert_header_config should echo the configured header"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].actions[1].type == "TargetGroup" && tencentcloud_alb_rules.example.rules[0].actions[1].order == 2
    error_message = "rules[0].actions[1] should be the TargetGroup action with order 2, got: ${tencentcloud_alb_rules.example.rules[0].actions[1].type}/${tencentcloud_alb_rules.example.rules[0].actions[1].order}"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].actions[1].target_group_config.target_groups[0].target_group_id == var.target_group_id
    error_message = "rules[0].actions[1].target_group_config.target_groups[0].target_group_id should echo the configured target group"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].actions[1].target_group_config.target_group_sticky_session.enabled == true
    error_message = "target_group_sticky_session.enabled should be true"
  }

  assert {
    condition     = length(tencentcloud_alb_rules.example.rules[0].tags) == 1 && tencentcloud_alb_rules.example.rules[0].tags[0].tag_key == "createdBy" && tencentcloud_alb_rules.example.rules[0].tags[0].tag_value == "tf-agentflow"
    error_message = "rules[0].tags should echo the configured tag"
  }
}
