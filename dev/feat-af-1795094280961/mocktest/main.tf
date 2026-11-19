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

resource "tencentcloud_config_recorder_config" "example" {
  status         = true
  from_mode      = 1
  resource_types = [
    "QCS::CAM::Group",
    "QCS::CVM::Instance",
  ]
}
