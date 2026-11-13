provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

resource "tencentcloud_ioa_delivery_strategy" "example" {
  name        = "tf-example-strategy"
  log_types   = ["040201000000", "040202000000", "040205000000"]
  type        = 2
  config_id   = 1
  description = "created by terraform test"
  enabled     = true
}

import {
  to = tencentcloud_ioa_delivery_strategy.example
  id = "123456"
}
