# Mock the API response for the Read-after-Create/Update call, focusing on the
# rate_limiting_rules.rules.mode field newly introduced by agentflow-af-1795490728279.
override_resource {
  target = tencentcloud_teo_security_policy_config.example
  values = {
    zone_id = "zone-mock001"
    entity  = "ZoneDefaultPolicy"
    id      = "zone-mock001#ZoneDefaultPolicy"

    security_policy = {
      rate_limiting_rules = {
        rules = {
          0 = {
            id                    = "rule-mock-001"
            name                  = "rate-limit-mock-1"
            condition             = "$${http.request.uri.path} eq '/login'"
            mode                  = "Throttle"
            max_request_threshold = 100
            counting_period       = "60s"
            enabled               = "on"
            action                = { 0 = { name = "Monitor" } }
          }
        }
      }
    }
  }
}

run "apply_security_policy_with_mode" {
  command = apply

  assert {
    condition     = tencentcloud_teo_security_policy_config.example.id == "zone-mock001#ZoneDefaultPolicy"
    error_message = "resource id should be composed of zone_id and entity"
  }

  assert {
    condition     = tencentcloud_teo_security_policy_config.example.zone_id == "zone-mock001"
    error_message = "zone_id should be zone-mock001"
  }

  assert {
    condition     = tencentcloud_teo_security_policy_config.example.entity == "ZoneDefaultPolicy"
    error_message = "entity should be ZoneDefaultPolicy"
  }
}

run "mode_field_read_back_as_throttle" {
  command = apply

  assert {
    condition     = tencentcloud_teo_security_policy_config.example.security_policy[0].rate_limiting_rules[0].rules[0].mode == "Throttle"
    error_message = "rules[0].mode should be read back as Throttle"
  }

  assert {
    condition     = tencentcloud_teo_security_policy_config.example.security_policy[0].rate_limiting_rules[0].rules[0].name == "rate-limit-mock-1"
    error_message = "rules[0].name should be rate-limit-mock-1"
  }

  assert {
    condition     = can(tencentcloud_teo_security_policy_config.example.security_policy[0].rate_limiting_rules[0].rules[0].id)
    error_message = "rules[0].id (computed, API-returned rule id) should be present"
  }

  assert {
    condition     = tencentcloud_teo_security_policy_config.example.security_policy[0].rate_limiting_rules[0].rules[0].max_request_threshold == 100
    error_message = "rules[0].max_request_threshold should be 100"
  }

  assert {
    condition     = tencentcloud_teo_security_policy_config.example.security_policy[0].rate_limiting_rules[0].rules[0].counting_period == "60s"
    error_message = "rules[0].counting_period should be 60s"
  }

  assert {
    condition     = tencentcloud_teo_security_policy_config.example.security_policy[0].rate_limiting_rules[0].rules[0].action[0].name == "Monitor"
    error_message = "rules[0].action[0].name should be Monitor"
  }
}
