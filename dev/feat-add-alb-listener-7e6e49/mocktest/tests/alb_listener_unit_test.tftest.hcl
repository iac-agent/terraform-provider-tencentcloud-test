# Mock tests for tencentcloud_alb_listener (ALB listener forwarding rules).
# override_resource supplies the state Terraform sees after the mocked
# DescribeRules read-back: the resource id is the RuleId returned by
# CreateRules, and rules[0].rule_id is the same RuleId from DescribeRules.
# provider Create/Read/Update/Delete are not executed under override, so the
# assertions below check config acceptance, id/reference wiring and outputs;
# the plan run blocks provide the real schema validation coverage.

override_resource {
  target = tencentcloud_alb_listener.example
  values = {
    id = "rule-1a2b3c4d"
    rules = {
      actions = [
        {
          order                 = 10
          type                  = "InsertHeader"
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

# Mocked read-back for the minimal resource: Optional+Computed priority and
# direction are filled with plausible computed values.
override_resource {
  target = tencentcloud_alb_listener.minimal
  values = {
    id = "rule-5e6f7a8b"
    rules = {
      actions = [{
        order     = 1
        type      = "FixedResponse"
        insert_header_config = null
        redirect_config      = null
        remove_header_config = null
        rewrite_config       = null
        target_group_config  = null
        fixed_response_config = {
          http_code    = 404
          content      = "not found"
          content_type = "text/plain"
        }
      }]
      conditions    = null
      priority      = 1
      direction     = "Request"
      rule_name     = null
      tags          = null
      rule_id       = "rule-5e6f7a8b"
      create_time   = "2025-11-26 11:00:00"
      modify_time   = "2025-11-26 11:00:00"
      status        = "Provisioning"
    }
  }
}

# Schema-level check: a fully populated configuration passes provider plan
# validation (nested action/condition/tag attribute names and types).
run "plan_full_config" {
  command = plan

  assert {
    condition     = tencentcloud_alb_listener.example.listener_id == "lst-a1b2c3d4"
    error_message = "listener_id should be accepted during plan"
  }

  assert {
    condition     = length(tencentcloud_alb_listener.example.rules) == 1
    error_message = "exactly one rule should be configured"
  }
}

# Schema-level check: Optional and Optional+Computed attributes may be omitted.
run "plan_minimal_config" {
  command = plan

  assert {
    condition     = tencentcloud_alb_listener.minimal.load_balancer_id == "alb-m5n6o7p8"
    error_message = "load_balancer_id should be accepted during plan"
  }
}

# apply+override: only verifies config acceptance, state composition and
# outputs; it does not exercise provider CRUD (which is skipped by override).
run "create_forwarding_rule" {
  command = apply

  assert {
    condition     = tencentcloud_alb_listener.example.id == "rule-1a2b3c4d" && output.example_rule_id == "rule-1a2b3c4d"
    error_message = "resource id and output should expose the mocked CreateRules RuleId"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_id == "lst-a1b2c3d4" && tencentcloud_alb_listener.example.load_balancer_id == "alb-e5f6g7h8"
    error_message = "listener_id and load_balancer_id should be retained in state"
  }

  assert {
    condition     = length(tencentcloud_alb_listener.example.rules) == 1 && tencentcloud_alb_listener.example.rules[0].rule_id == "rule-1a2b3c4d"
    error_message = "exactly one rule should be managed with the DescribeRules RuleId"
  }

  assert {
    condition     = length(tencentcloud_alb_listener.example.rules[0].actions) == 2 && tencentcloud_alb_listener.example.rules[0].actions[0].insert_header_config.key == "x-tf-mock" && tencentcloud_alb_listener.example.rules[0].actions[1].target_group_config.target_groups[0].target_group_id == "lbtg-1234abcd"
    error_message = "mocked InsertHeader and TargetGroup actions should be retained in order"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.rules[0].conditions[0].host_config[0] == "www.example.com" && tencentcloud_alb_listener.example.rules[0].tags[0].tag_value == "mocktest"
    error_message = "mocked Host condition and tags should be retained"
  }

  assert {
    condition     = tencentcloud_alb_listener.minimal.id == "rule-5e6f7a8b" && output.minimal_rule_ids[0] == "rule-5e6f7a8b"
    error_message = "minimal resource id and rule_id output should resolve to the mocked RuleId"
  }

  assert {
    condition     = tencentcloud_alb_listener.minimal.rules[0].priority == 1 && tencentcloud_alb_listener.minimal.rules[0].direction == "Request" && tencentcloud_alb_listener.minimal.rules[0].status == "Provisioning"
    error_message = "computed priority, direction and read-back status should be present in state"
  }
}
