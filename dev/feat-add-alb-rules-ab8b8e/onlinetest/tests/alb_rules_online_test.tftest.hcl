run "apply_alb_rule" {
  command = apply

  assert {
    condition     = can(regex("^alb-[0-9a-zA-Z]{8}#lst-[0-9a-zA-Z]{8}#rule-[0-9a-zA-Z]{8}$", tencentcloud_alb_rules.example.id))
    error_message = "id should be the composite load_balancer_id#listener_id#rule_id, got: ${tencentcloud_alb_rules.example.id}"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.load_balancer_id == var.load_balancer_id
    error_message = "load_balancer_id should echo the configured load balancer, got: ${tencentcloud_alb_rules.example.load_balancer_id}"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.listener_id == var.listener_id
    error_message = "listener_id should echo the configured listener, got: ${tencentcloud_alb_rules.example.listener_id}"
  }

  assert {
    condition     = length(tencentcloud_alb_rules.example.rules) == 1
    error_message = "exactly one forwarding rule should be managed"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].priority == 1
    error_message = "rule priority should be 1 as configured"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].direction == "Request"
    error_message = "rule direction should be Request as configured"
  }

  assert {
    condition     = can(regex("^${var.rule_name_prefix}-tfagentflow-", tencentcloud_alb_rules.example.rules[0].rule_name))
    error_message = "rule_name should start with the configured prefix, got: ${tencentcloud_alb_rules.example.rules[0].rule_name}"
  }

  assert {
    condition     = length(tencentcloud_alb_rules.example.rules[0].conditions) == 2
    error_message = "the rule read-back should carry the two configured conditions"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].conditions[0].host_config[0] == var.rule_host
    error_message = "the host condition should echo the configured host name"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].conditions[1].path_config[0] == var.rule_path
    error_message = "the path condition should echo the configured path"
  }

  assert {
    condition     = length(tencentcloud_alb_rules.example.rules[0].actions) == 2
    error_message = "the rule read-back should carry the two configured actions"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].actions[1].type == "TargetGroup"
    error_message = "the last action should be the TargetGroup forward action"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].actions[1].target_group_config[0].target_groups[0].target_group_id == var.target_group_id
    error_message = "the forward action should echo the configured target group id"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].actions[0].insert_header_config[0].key == var.insert_header_key
    error_message = "the insert-header action should echo the configured header key"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].actions[0].insert_header_config[0].value == var.insert_header_value
    error_message = "the insert-header action should echo the configured header value"
  }
}
