# Online test (real cloud API, no mock override) for the newly added
# security_policy.rate_limiting_rules.rules.mode field.
# The resource is a configuration-only resource: destroy is a no-op and leaves
# no cloud resource behind (the policy config is reverted by updating back is
# not required; the resource itself creates no persistent cloud object).
run "apply_security_policy_with_mode" {
  command = apply

  assert {
    condition     = tencentcloud_teo_security_policy_config.example.id != ""
    error_message = "resource id should not be empty after apply"
  }

  assert {
    condition     = can(regex("^${var.zone_id}#", tencentcloud_teo_security_policy_config.example.id))
    error_message = "resource id should be prefixed with the configured zone_id (format: zone_id#entity)"
  }

  assert {
    condition     = can(regex("#ZoneDefaultPolicy$", tencentcloud_teo_security_policy_config.example.id))
    error_message = "resource id should end with the site-level policy entity ZoneDefaultPolicy"
  }

  assert {
    condition     = tencentcloud_teo_security_policy_config.example.zone_id == var.zone_id
    error_message = "zone_id should round-trip the configured site id"
  }

  assert {
    condition     = tencentcloud_teo_security_policy_config.example.entity == "ZoneDefaultPolicy"
    error_message = "entity should be ZoneDefaultPolicy"
  }
}

run "mode_field_matches_configured_value" {
  command = apply

  assert {
    condition     = length(tencentcloud_teo_security_policy_config.example.security_policy) == 1
    error_message = "security_policy should be read back from DescribeSecurityPolicy"
  }

  assert {
    condition     = length(tencentcloud_teo_security_policy_config.example.security_policy[0].rate_limiting_rules[0].rules) >= 1
    error_message = "rate_limiting_rules.rules should contain the configured rule after read"
  }

  assert {
    condition     = tencentcloud_teo_security_policy_config.example.security_policy[0].rate_limiting_rules[0].rules[0].name == "tf-agentflow-rate-limit-mode"
    error_message = "the rate limit rule name read back from the real API should match the configured name"
  }

  assert {
    condition     = tencentcloud_teo_security_policy_config.example.security_policy[0].rate_limiting_rules[0].rules[0].mode == var.rate_limit_mode
    error_message = "the rate limit rule mode read back from the real API should match the configured mode (parameter under test)"
  }

  assert {
    condition     = tencentcloud_teo_security_policy_config.example.security_policy[0].rate_limiting_rules[0].rules[0].enabled == "on"
    error_message = "the rate limit rule should be enabled after apply"
  }

  assert {
    condition     = tencentcloud_teo_security_policy_config.example.security_policy[0].rate_limiting_rules[0].rules[0].id != ""
    error_message = "the API-returned rule id should not be empty"
  }
}
