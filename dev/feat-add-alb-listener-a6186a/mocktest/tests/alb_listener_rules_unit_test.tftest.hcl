# Mock tests for tencentcloud_alb_listener (ALB listener forwarding rules).
# override_resource supplies the state Terraform sees after the mocked
# DescribeRules read-back: the resource id is the first RuleId returned by
# CreateRules, and rules[0].rule_id is the same RuleId from DescribeRules.

override_resource {
  target = tencentcloud_alb_listener.example
  values = {
    id = "rule-1a2b3c4d"
    rules = {
      actions = [
        {
          order                = 10
          type                 = "InsertHeader"
          fixed_response_config = null
          insert_header_config = {
            key        = "x-tf-mock"
            value      = "agentflow"
            value_type = "UserDefined"
          }
          redirect_config      = null
          remove_header_config = null
          rewrite_config       = null
          target_group_config  = null
        },
        {
          order                 = 20
          type                  = "TargetGroup"
          fixed_response_config = null
          insert_header_config  = null
          redirect_config       = null
          remove_header_config  = null
          rewrite_config        = null
          target_group_config = {
            target_groups = [{
              target_group_id = "lbtg-1234abcd"
              weight          = 20
            }]
            target_group_sticky_session = {
              enabled = false
              timeout = 1000
            }
          }
        }
      ]
      conditions = [{
        type                = "Host"
        cookie_config       = null
        header_config       = null
        host_config         = ["www.example.com"]
        method_config       = null
        path_config         = null
        query_string_config = null
        source_ip_config    = null
      }]
      priority    = 10
      direction   = "Request"
      rule_name   = "tf-mock-rule"
      tags        = [{ tag_key = "env", tag_value = "mocktest" }]
      rule_id     = "rule-1a2b3c4d"
      create_time = "2025-11-26 10:00:00"
      modify_time = "2025-11-26 10:00:00"
      status      = "Active"
    }
  }
}

override_resource {
  target = tencentcloud_alb_listener.redirect
  values = {
    id = "rule-5e6f7a8b"
    rules = {
      actions = [{
        order                 = 1
        type                  = "Redirect"
        fixed_response_config = null
        insert_header_config  = null
        redirect_config = {
          http_code = 302
          host      = "www.example.com"
          path      = "/new"
          port      = "443"
          protocol  = "HTTPS"
          query     = null
        }
        remove_header_config = null
        rewrite_config       = null
        target_group_config  = null
      }]
      conditions = [{
        type                = "Path"
        cookie_config       = null
        header_config       = null
        host_config         = null
        method_config       = null
        path_config         = ["/old"]
        query_string_config = null
        source_ip_config    = null
      }]
      priority    = 20
      direction   = "Request"
      rule_name   = "tf-mock-redirect-rule"
      tags        = null
      rule_id     = "rule-5e6f7a8b"
      create_time = "2025-11-26 11:00:00"
      modify_time = "2025-11-26 11:30:00"
      status      = "Configuring"
    }
  }
}

run "create_forwarding_rule" {
  command = apply

  assert {
    condition     = tencentcloud_alb_listener.example.id == "rule-1a2b3c4d"
    error_message = "resource id should be the RuleId returned by CreateRules"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_id == "lst-a1b2c3d4" && tencentcloud_alb_listener.example.load_balancer_id == "alb-e5f6g7h8"
    error_message = "listener_id and load_balancer_id should match the configuration"
  }

  assert {
    condition     = length(tencentcloud_alb_listener.example.rules) == 1 && tencentcloud_alb_listener.example.rules[0].rule_id == "rule-1a2b3c4d"
    error_message = "exactly one rule should be managed and its rule_id should be the DescribeRules RuleId"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.rules[0].priority == 10 && tencentcloud_alb_listener.example.rules[0].rule_name == "tf-mock-rule" && tencentcloud_alb_listener.example.rules[0].status == "Active"
    error_message = "rule priority, name and read-back status should be kept in state"
  }

  assert {
    condition     = length(tencentcloud_alb_listener.example.rules[0].actions) == 2 && tencentcloud_alb_listener.example.rules[0].actions[0].insert_header_config.key == "x-tf-mock" && tencentcloud_alb_listener.example.rules[0].actions[1].target_group_config.target_groups[0].target_group_id == "lbtg-1234abcd"
    error_message = "mocked InsertHeader and TargetGroup actions should be kept in order"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.rules[0].conditions[0].host_config[0] == "www.example.com" && tencentcloud_alb_listener.example.rules[0].tags[0].tag_value == "mocktest"
    error_message = "mocked Host condition and tags should be kept"
  }
}

run "create_redirect_rule" {
  command = apply

  assert {
    condition     = tencentcloud_alb_listener.redirect.id == "rule-5e6f7a8b" && tencentcloud_alb_listener.redirect.rules[0].rule_id == "rule-5e6f7a8b"
    error_message = "redirect rule id and rule_id should both be the mocked RuleId"
  }

  assert {
    condition     = tencentcloud_alb_listener.redirect.listener_id == "lst-z9y8x7w6" && tencentcloud_alb_listener.redirect.rules[0].priority == 20
    error_message = "redirect rule listener_id and priority should match the configuration"
  }

  assert {
    condition     = tencentcloud_alb_listener.redirect.rules[0].actions[0].type == "Redirect" && tencentcloud_alb_listener.redirect.rules[0].actions[0].redirect_config.http_code == 302 && tencentcloud_alb_listener.redirect.rules[0].actions[0].redirect_config.protocol == "HTTPS"
    error_message = "mocked Redirect action should keep http_code and protocol"
  }

  assert {
    condition     = tencentcloud_alb_listener.redirect.rules[0].conditions[0].path_config[0] == "/old" && tencentcloud_alb_listener.redirect.rules[0].status == "Configuring"
    error_message = "mocked Path condition and read-back status should be kept"
  }
}
