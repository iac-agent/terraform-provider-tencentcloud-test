run "plan_teo_inference_domains_1110_01" {
  command = plan

  # Data source would call the cloud API during plan; override_data returns
  # fake values so no request is made.
  override_data {
    target = data.tencentcloud_teo_inference_domains_1110_01.example
    values = {
      zone_id    = "zone-2p6f4u8x"
      service_id = "es-abc12345"
      sort_by    = "CreateTime"
      sort_order = "Desc"
    }
  }

  assert {
    condition     = data.tencentcloud_teo_inference_domains_1110_01.example.zone_id == "zone-2p6f4u8x"
    error_message = "zone_id should be zone-2p6f4u8x"
  }

  assert {
    condition     = data.tencentcloud_teo_inference_domains_1110_01.example.service_id == "es-abc12345"
    error_message = "service_id should be es-abc12345"
  }

  assert {
    condition     = data.tencentcloud_teo_inference_domains_1110_01.example.sort_by == "CreateTime"
    error_message = "sort_by should be CreateTime"
  }

  assert {
    condition     = data.tencentcloud_teo_inference_domains_1110_01.example.sort_order == "Desc"
    error_message = "sort_order should be Desc"
  }
}

run "plan_teo_inference_domains_1110_01_default_sort" {
  command = plan

  # Only required fields set; optional sort fields omitted, plan still succeeds.
  override_data {
    target = data.tencentcloud_teo_inference_domains_1110_01.example
    values = {
      zone_id    = "zone-2p6f4u8x"
      service_id = "es-abc12345"
    }
  }

  assert {
    condition     = data.tencentcloud_teo_inference_domains_1110_01.example.zone_id == "zone-2p6f4u8x"
    error_message = "zone_id should be zone-2p6f4u8x"
  }

  assert {
    condition     = data.tencentcloud_teo_inference_domains_1110_01.example.service_id == "es-abc12345"
    error_message = "service_id should be es-abc12345"
  }
}
