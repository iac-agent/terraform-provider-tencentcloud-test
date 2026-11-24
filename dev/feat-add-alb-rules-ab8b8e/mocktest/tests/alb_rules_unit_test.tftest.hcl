override_resource {
  target = tencentcloud_alb_rules.example
  values = {
    id               = "alb-12345678#lst-12345678#rule-87654321"
    load_balancer_id = "alb-12345678"
    listener_id      = "lst-12345678"
    rules = [{
      actions = [
        {
          order = 10
          type  = "InsertHeader"
          insert_header_config = [{
            key        = "x-tf-header"
            value      = "terraform"
            value_type = "UserDefined"
          }]
        },
        {
          order = 20
          type  = "TargetGroup"
          target_group_config = [{
            target_groups = [{
              target_group_id = "lbtg-12345678"
              weight          = 10
            }]
            target_group_sticky_session = [{
              enabled = false
            }]
          }]
        }
      ]
      conditions = [
        {
          type        = "Host"
          host_config = ["www.example.com"]
        },
        {
          type        = "Path"
          path_config = ["/api"]
        }
      ]
      priority  = 1
      direction = "Request"
      rule_name = "tf-rule-example"
      tags = [{
        tag_key   = "env"
        tag_value = "test"
      }]
    }]
  }
}

run "apply_alb_rule" {
  command = apply

  assert {
    condition     = tencentcloud_alb_rules.example.id == "alb-12345678#lst-12345678#rule-87654321"
    error_message = "id should be loadBalancerId#listenerId#ruleId"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.load_balancer_id == "alb-12345678"
    error_message = "load_balancer_id should be the configured load balancer id"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.listener_id == "lst-12345678"
    error_message = "listener_id should be the configured listener id"
  }

  assert {
    condition     = length(tencentcloud_alb_rules.example.rules) == 1
    error_message = "exactly one forwarding rule should be managed"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].priority == 1
    error_message = "rule priority should be 1"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].direction == "Request"
    error_message = "rule direction should be Request"
  }

  assert {
    condition     = length(tencentcloud_alb_rules.example.rules[0].actions) == 2
    error_message = "rule should carry two actions in the mocked read-back"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].actions[1].type == "TargetGroup"
    error_message = "the last action should be the TargetGroup forward action"
  }

  assert {
    condition     = length(tencentcloud_alb_rules.example.rules[0].conditions) == 2
    error_message = "rule should carry two conditions in the mocked read-back"
  }

  assert {
    condition     = tencentcloud_alb_rules.example.rules[0].conditions[0].host_config[0] == "www.example.com"
    error_message = "host condition should be the configured host name"
  }
}
