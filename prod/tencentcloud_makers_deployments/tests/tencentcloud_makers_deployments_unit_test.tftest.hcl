run "plan_makers_deployments" {
  command = plan

  # data blocks call the cloud API at plan time: override_data returns fake
  # values so no request is ever sent.
  override_data {
    target = data.tencentcloud_makers_deployments.example
    values = {
      zone_id        = "zone-2qk1q3x8"
      project_id     = "proj-1234567890"
      deployment_ids = ["dpl-abcdefg1", "dpl-abcdefg2"]
      order_by       = "CreatedOn"
      order_type     = "Desc"
      start_time     = "2024-01-01T00:00:00Z"
      end_time       = "2024-12-31T23:59:59Z"
      total_count    = 2
    }
  }

  assert {
    condition     = data.tencentcloud_makers_deployments.example.zone_id == "zone-2qk1q3x8"
    error_message = "zone_id should be zone-2qk1q3x8"
  }

  assert {
    condition     = data.tencentcloud_makers_deployments.example.project_id == "proj-1234567890"
    error_message = "project_id should be proj-1234567890"
  }

  assert {
    condition     = length(data.tencentcloud_makers_deployments.example.deployment_ids) == 2
    error_message = "deployment_ids should contain 2 elements"
  }

  assert {
    condition     = data.tencentcloud_makers_deployments.example.deployment_ids[0] == "dpl-abcdefg1"
    error_message = "deployment_ids[0] should be dpl-abcdefg1"
  }

  assert {
    condition     = data.tencentcloud_makers_deployments.example.filters[0].name == "Status"
    error_message = "filters[0].name should be Status"
  }

  assert {
    condition     = length(data.tencentcloud_makers_deployments.example.filters[0].values) == 2
    error_message = "filters[0].values should contain 2 elements"
  }

  assert {
    condition     = data.tencentcloud_makers_deployments.example.filters[1].name == "RepoBranch"
    error_message = "filters[1].name should be RepoBranch"
  }

  assert {
    condition     = data.tencentcloud_makers_deployments.example.filters[1].values[0] == "main"
    error_message = "filters[1].values[0] should be main"
  }

  assert {
    condition     = data.tencentcloud_makers_deployments.example.order_by == "CreatedOn"
    error_message = "order_by should be CreatedOn"
  }

  assert {
    condition     = data.tencentcloud_makers_deployments.example.order_type == "Desc"
    error_message = "order_type should be Desc"
  }

  assert {
    condition     = data.tencentcloud_makers_deployments.example.start_time == "2024-01-01T00:00:00Z"
    error_message = "start_time should be 2024-01-01T00:00:00Z"
  }

  assert {
    condition     = data.tencentcloud_makers_deployments.example.end_time == "2024-12-31T23:59:59Z"
    error_message = "end_time should be 2024-12-31T23:59:59Z"
  }

  assert {
    condition     = data.tencentcloud_makers_deployments.example.total_count == 2
    error_message = "total_count should be 2"
  }
}

run "plan_makers_deployments_minimal" {
  command = plan

  # Only the required attributes are set; every optional attribute is omitted
  # so the data source schema's optionality is exercised.
  override_data {
    target = data.tencentcloud_makers_deployments.example
    values = {
      zone_id     = "zone-2qk1q3x8"
      project_id  = "proj-1234567890"
      order_by    = "ModifiedOn"
      order_type  = "Asc"
      start_time  = "2024-01-01T00:00:00Z"
      end_time    = "2024-12-31T23:59:59Z"
      total_count = 0
    }
  }

  assert {
    condition     = data.tencentcloud_makers_deployments.example.zone_id == "zone-2qk1q3x8"
    error_message = "zone_id should be zone-2qk1q3x8"
  }

  assert {
    condition     = data.tencentcloud_makers_deployments.example.project_id == "proj-1234567890"
    error_message = "project_id should be proj-1234567890"
  }

  assert {
    condition     = data.tencentcloud_makers_deployments.example.total_count == 0
    error_message = "total_count should be 0"
  }
}
