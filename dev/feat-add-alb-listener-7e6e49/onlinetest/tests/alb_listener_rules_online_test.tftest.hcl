# Online tests for tencentcloud_alb_listener (ALB listener forwarding rules).
# No mock/override is used: assertions check values read back from the cloud.
# Both run blocks use command = apply; terraform test destroys the resources
# afterwards, so no forwarding rule is left behind.

run "create_and_read_back_rule" {
  command = apply

  # CreateRules returns RuleIds; the resource id must be the first RuleId.
  assert {
    condition     = can(regex("^rule-[0-9a-zA-Z]{8}$", tencentcloud_alb_listener.tfagentflow.id))
    error_message = "resource id should be a RuleId (rule- followed by 8 alphanumerics) returned by CreateRules, got: ${tencentcloud_alb_listener.tfagentflow.id}"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.listener_id == var.listener_id
    error_message = "listener_id should echo the configured listener"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.load_balancer_id == var.load_balancer_id
    error_message = "load_balancer_id should echo the configured load balancer"
  }

  assert {
    condition     = length(tencentcloud_alb_listener.tfagentflow.rules) == 1
    error_message = "exactly one forwarding rule should be managed, got: ${length(tencentcloud_alb_listener.tfagentflow.rules)}"
  }

  # DescribeRules read-back: RuleId, name, priority, direction and status.
  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.rules[0].rule_id == tencentcloud_alb_listener.tfagentflow.id
    error_message = "rules[0].rule_id read back from DescribeRules should equal the resource id"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.rules[0].rule_name == local.rule_name
    error_message = "rules[0].rule_name should equal the configured unique rule name"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.rules[0].priority == 20001
    error_message = "rules[0].priority should echo the configured priority 20001"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.rules[0].direction == "Request"
    error_message = "rules[0].direction should be Request"
  }

  assert {
    condition     = contains(["Provisioning", "Active", "Configuring"], tencentcloud_alb_listener.tfagentflow.rules[0].status)
    error_message = "rules[0].status should be a valid DescribeRules status, got: ${tencentcloud_alb_listener.tfagentflow.rules[0].status}"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.rules[0].create_time != null && tencentcloud_alb_listener.tfagentflow.rules[0].create_time != ""
    error_message = "rules[0].create_time should be read back from DescribeRules"
  }

  # Conditions read-back.
  assert {
    condition     = length(tencentcloud_alb_listener.tfagentflow.rules[0].conditions) == 2
    error_message = "rules[0].conditions should contain the two configured conditions"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.rules[0].conditions[0].type == "Host" && tencentcloud_alb_listener.tfagentflow.rules[0].conditions[0].host_config[0] == var.rule_host
    error_message = "the first condition should echo the configured Host condition"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.rules[0].conditions[1].type == "Path" && tencentcloud_alb_listener.tfagentflow.rules[0].conditions[1].path_config[0] == var.rule_path
    error_message = "the second condition should echo the configured Path condition"
  }

  # Actions read-back, preserving execution order.
  assert {
    condition     = length(tencentcloud_alb_listener.tfagentflow.rules[0].actions) == 2
    error_message = "rules[0].actions should contain the two configured actions"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.rules[0].actions[0].type == "InsertHeader" && tencentcloud_alb_listener.tfagentflow.rules[0].actions[0].order == 1
    error_message = "the first action should be InsertHeader with order 1"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.rules[0].actions[0].insert_header_config.key == var.insert_header_key && tencentcloud_alb_listener.tfagentflow.rules[0].actions[0].insert_header_config.value == var.insert_header_value
    error_message = "InsertHeader action should echo the configured header key and value"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.rules[0].actions[1].type == "TargetGroup" && tencentcloud_alb_listener.tfagentflow.rules[0].actions[1].order == 20
    error_message = "the last action should be TargetGroup with order 20"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.rules[0].actions[1].target_group_config.target_groups[0].target_group_id == var.target_group_id
    error_message = "TargetGroup action should echo the configured target group id"
  }

  assert {
    condition     = length(tencentcloud_alb_listener.tfagentflow.rules[0].tags) == 1 && tencentcloud_alb_listener.tfagentflow.rules[0].tags[0].tag_key == "createdBy" && tencentcloud_alb_listener.tfagentflow.rules[0].tags[0].tag_value == "tf-agentflow"
    error_message = "rules[0].tags should echo the configured tag"
  }
}

# Exercise the Update path (ModifyRulesAttributes): the two variable overrides
# change rule_name and the Path condition in place (both are nested under
# rules, which has no RequiresReplace plan modifier). The RuleId stays stable.
run "modify_rule_attributes" {
  command = apply

  variables {
    rule_name_prefix = "${var.rule_name_prefix}-updated"
    rule_path        = "${var.rule_path}updated"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.rules[0].rule_id == tencentcloud_alb_listener.tfagentflow.id
    error_message = "rules[0].rule_id should still be the same RuleId after the update"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.rules[0].rule_name == "${var.rule_name_prefix}-updated-tfagentflow-${local.rule_name_suffix}"
    error_message = "rules[0].rule_name should reflect the updated name prefix"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.rules[0].conditions[1].path_config[0] == "${var.rule_path}updated"
    error_message = "rules[0].conditions[1].path_config should reflect the updated path"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.rules[0].priority == 20001 && tencentcloud_alb_listener.tfagentflow.rules[0].direction == "Request"
    error_message = "priority and direction should remain unchanged after the update"
  }

  assert {
    condition     = length(tencentcloud_alb_listener.tfagentflow.rules[0].actions) == 2 && tencentcloud_alb_listener.tfagentflow.rules[0].actions[1].target_group_config.target_groups[0].target_group_id == var.target_group_id
    error_message = "the TargetGroup action should remain intact after the update"
  }
}
