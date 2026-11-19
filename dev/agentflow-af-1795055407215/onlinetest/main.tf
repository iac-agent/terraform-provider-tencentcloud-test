provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

locals {
  rule_name = "${var.rule_name_prefix}-tfagentflow"
}

resource "tencentcloud_config_aggregate_rule" "example" {
  identifier       = var.identifier
  identifier_type  = "SYSTEM"
  rule_name        = local.rule_name
  resource_type    = var.resource_type
  account_group_id = var.account_group_id
  risk_level       = var.risk_level
  description      = "created by terraform agentflow online test"

  trigger_type {
    message_type                = "ScheduledNotification"
    maximum_execution_frequency = "TwentyFour_Hours"
  }
}
