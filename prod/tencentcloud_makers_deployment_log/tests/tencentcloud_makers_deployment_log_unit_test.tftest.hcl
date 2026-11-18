run "plan_makers_deployment_log" {
  command = plan

  # data block would call the cloud API at plan time: override_data returns
  # fake values so no request is sent.
  override_data {
    target = data.tencentcloud_makers_deployment_log.example
    values = {
      zone_id       = "zone-abc123"
      project_id    = "proj-123456"
      deployment_id = "deploy-987654"
      log_url       = "https://log.example.com/deploy-987654.log"
    }
  }

  assert {
    condition     = data.tencentcloud_makers_deployment_log.example.zone_id == "zone-abc123"
    error_message = "zone_id should be zone-abc123"
  }

  assert {
    condition     = data.tencentcloud_makers_deployment_log.example.project_id == "proj-123456"
    error_message = "project_id should be proj-123456"
  }

  assert {
    condition     = data.tencentcloud_makers_deployment_log.example.deployment_id == "deploy-987654"
    error_message = "deployment_id should be deploy-987654"
  }

  assert {
    condition     = data.tencentcloud_makers_deployment_log.example.log_url == "https://log.example.com/deploy-987654.log"
    error_message = "log_url should be the overridden computed value"
  }
}
