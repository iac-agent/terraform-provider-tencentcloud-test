provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

resource "tencentcloud_config_aggregate_rule" "example" {
  identifier       = "cam-user-group-bound"
  identifier_type  = "SYSTEM"
  rule_name        = "tf-example-aggregate-rule"
  resource_type    = ["QCS::CAM::User"]
  account_group_id = "agr-12345678"
  risk_level       = 3
  description      = "tf example aggregate config rule"

  trigger_type {
    message_type                = "ScheduledNotification"
    maximum_execution_frequency = "TwentyFour_Hours"
  }

  input_parameter {
    parameter_key = "maxMemorySize"
    type          = "Require"
    value         = "512"
  }

  region_scope                = ["ap-guangzhou", "ap-shanghai"]
  exclude_resource_ids_scope  = ["ins-12345678"]
}
