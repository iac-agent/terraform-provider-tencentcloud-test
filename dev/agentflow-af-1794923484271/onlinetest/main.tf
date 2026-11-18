provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Only new resources created by this test are used; nothing references existing
# cloud resources and everything is destroyed by terraform test teardown.
# ==============================================================================

# An account group (aggregator) is required as the scope of aggregate config
# rules. A global RD aggregator has no member accounts to clean up.
resource "tencentcloud_config_aggregator" "example" {
  name        = "${var.rule_name_prefix}-aggregator"
  description = "created by terraform agentflow online test"
  type        = "RD"
  owner_uin   = var.owner_uin
}

resource "tencentcloud_config_aggregate_config_rule" "example" {
  account_group_id = tencentcloud_config_aggregator.example.account_group_id
  identifier       = "cam-user-group-bound"
  identifier_type  = "SYSTEM"
  rule_name        = "${var.rule_name_prefix}-rule"
  resource_type    = ["QCS::CAM::User"]
  risk_level       = 3
  description      = "created by terraform agentflow online test"

  trigger_type = [
    {
      message_type                = "ScheduledNotification"
      maximum_execution_frequency = "TwentyFour_Hours"
    },
  ]
}
