run "apply_ioa_delivery_strategy" {
  command = apply

  override_resource {
    target = tencentcloud_ioa_delivery_strategy.example
    values = {
      id          = "123456"
      name        = "tf-example-strategy"
      log_types   = ["040201000000", "040202000000", "040205000000"]
      type        = 2
      config_id   = 1
      description = "created by terraform test"
      enabled     = true
    }
  }

  assert {
    condition     = tencentcloud_ioa_delivery_strategy.example.id == "123456"
    error_message = "id should be 123456"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_strategy.example.name == "tf-example-strategy"
    error_message = "name should be tf-example-strategy"
  }

  assert {
    condition     = length(tencentcloud_ioa_delivery_strategy.example.log_types) == 3
    error_message = "log_types should have 3 elements"
  }

  assert {
    condition     = contains(tencentcloud_ioa_delivery_strategy.example.log_types, "040201000000")
    error_message = "log_types should contain identity security type"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_strategy.example.type == 2
    error_message = "type should be 2 (kafka)"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_strategy.example.config_id == 1
    error_message = "config_id should be 1"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_strategy.example.description == "created by terraform test"
    error_message = "description should match the configuration"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_strategy.example.enabled == true
    error_message = "enabled should be true"
  }
}
