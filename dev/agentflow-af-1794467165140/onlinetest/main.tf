provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

data "tencentcloud_config_system_rules" "all-tfagentflow" {}

data "tencentcloud_config_system_rules" "by-keyword-tfagentflow" {
  keyword = var.rule_identifier
}

data "tencentcloud_config_system_rule" "detail-tfagentflow" {
  identifier = var.rule_identifier
}
