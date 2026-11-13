terraform {
  required_version = ">= 1.7.0"

  required_providers {
    tencentcloud = {
      source  = "registry.terraform.io/tencentcloudstack/tencentcloud"
      version = "0.0.1-beta.feat.add.ioa.delivery.server"
    }
  }
}
