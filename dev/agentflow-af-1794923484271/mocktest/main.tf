provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

resource "tencentcloud_config_aggregate_config_rule" "example" {
  account_group_id = "ca-Zp9EiU7Pa4Vy0lFFm8XM"
  identifier       = "cam-password-policy-check"
  identifier_type  = "SYSTEM"
  rule_name        = "tf-mock-aggregate-config-rule"
  resource_type    = ["QCS::CAM::User"]
  risk_level       = 1
  description      = "Mock aggregate config rule created by terraform test"

  trigger_type = [
    {
      message_type                = "ScheduledNotification"
      maximum_execution_frequency = "TwentyFour_Hours"
    },
  ]

  input_parameter = [
    {
      parameter_key = "MinimumLength"
      type          = "Optional"
      value         = "8"
    },
  ]

  region_scope = ["ap-guangzhou", "ap-shanghai"]

  tags_scope = [
    {
      tag_key   = "env"
      tag_value = "prod"
    },
  ]

  exclude_resource_ids_scope = ["ins-xxxxxxxx"]
}
