provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

data "tencentcloud_user_info" "this" {}

locals {
  owner_uin       = coalesce(var.owner_uin, data.tencentcloud_user_info.this.uin)
  aggregator_name = "${var.aggregator_name}-tfagentflow"
}

resource "tencentcloud_config_aggregator" "example" {
  name        = local.aggregator_name
  description = var.aggregator_description
  type        = "CUSTOM"
  owner_uin   = local.owner_uin

  aggregator_accounts {
    member_uin  = local.owner_uin
    member_name = "self"
  }
}
