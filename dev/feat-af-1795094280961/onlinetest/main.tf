terraform {
  required_version = ">= 1.7.0"

  required_providers {
    tencentcloud = {
      source  = "registry.terraform.io/tencentcloudstack/tencentcloud"
      version = "0.0.1-beta.agentflow.af-1795094280961"
    }
  }
}
provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

data "tencentcloud_user_info" "this" {}

resource "tencentcloud_config_recorder_config" "example" {
  status         = true
  from_mode      = var.from_mode
  resource_types = var.resource_types
}
