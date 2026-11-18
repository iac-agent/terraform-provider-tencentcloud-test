provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

resource "tencentcloud_config_aggregator" "example" {
  name        = "tf-mock-aggregator"
  description = "Mock aggregator created by terraform test"
  type        = "CUSTOM"
  owner_uin   = "100012345678"

  aggregator_accounts {
    member_uin  = 100012345679
    member_name = "member-1"
  }

  aggregator_accounts {
    member_uin  = 100012345680
    member_name = "member-2"
  }
}
