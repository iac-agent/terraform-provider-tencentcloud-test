override_resource {
  target = tencentcloud_alb_rules.example
  values = {
    id         = "alb-12345678#lst-12345678"
    next_token = ""
  }
}

override_resource {
  target = tencentcloud_alb_rules.redirect
  values = {
    id         = "alb-87654321#lst-87654321"
    next_token = ""
  }
}

run "create_forwarding_rule" {
  command = apply

  assert {
    condition     = tencentcloud_alb_rules.example.id == "alb-12345678#lst-12345678"
    error_message = "id should be load_balancer_id#listener_id"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.load_balancer_id == "alb-12345678" && tencentcloud_alb_rules.example.listener_id == "lst-12345678"
    error_message = "load_balancer_id and listener_id should match the configuration"
  }

  assert {
    condition     = length(tencentcloud_alb_rules.example.rules) == 1
    error_message = "exactly one forwarding rule should be managed"
  }

  assert {
    condition     = length(tencentcloud_alb_rules.example.rules[0].conditions) == 2 && tencentcloud_alb_rules.example.rules[0].conditions[0].type == "Host"
    error_message = "mocked conditions (Host + Path) should be kept"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].priority == 1 && tencentcloud_alb_rules.example.rules[0].rule_name == "tf-rule-mocktest"
    error_message = "rule priority and name should be kept"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].actions[0].type == "InsertHeader" && tencentcloud_alb_rules.example.rules[0].actions[0].insert_header_config.key == "x-tf-header"
    error_message = "first action should be the mocked InsertHeader action"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].actions[1].target_group_config.target_groups[0].target_group_id == "lbtg-12345678"
    error_message = "last action should forward to the mocked target group"
  }
}

run "create_redirect_rule" {
  command = apply

  assert {
    condition     = tencentcloud_alb_rules.redirect.id == "alb-87654321#lst-87654321"
    error_message = "id should be load_balancer_id#listener_id"
  }

  assert {
    condition     = tencentcloud_alb_rules.redirect.rules[0].actions[0].type == "Redirect"
    error_message = "action type should be Redirect"
  }

  assert {
    condition     = tencentcloud_alb_rules.redirect.rules[0].priority == 2 && tencentcloud_alb_rules.redirect.rules[0].rule_name == "tf-rule-redirect"
    error_message = "redirect rule priority and name should be kept"
  }

  assert {
    condition     = tencentcloud_alb_rules.redirect.rules[0].actions[0].redirect_config.http_code == 302
    error_message = "redirect http_code should be 302"
  }

  assert {
    condition     = tencentcloud_alb_rules.redirect.rules[0].actions[0].redirect_config.protocol == "HTTPS"
    error_message = "redirect protocol should be HTTPS"
  }

  assert {
    condition     = tencentcloud_alb_rules.redirect.rules[0].actions[0].redirect_config.port == "443"
    error_message = "redirect port should be 443"
  }
}
