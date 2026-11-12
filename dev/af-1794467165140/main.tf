provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

data "tencentcloud_config_system_rules" "all" {}

data "tencentcloud_config_system_rules" "by_keyword" {
  keyword = "mfa"
}

data "tencentcloud_config_system_rules" "by_risk" {
  risk_level = 1
}

data "tencentcloud_config_system_rule" "detail" {
  identifier = "cam-user-mfa-enabled"
}
