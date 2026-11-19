override_resource {
  target = tencentcloud_teo_inference_domain.example
  values = {
    id          = "zone-3v0yhgt4m1z9#inf-vs06pb1cdz61#test-ai.eo.cn"
    zone_id     = "zone-3v0yhgt4m1z9"
    service_id  = "inf-vs06pb1cdz61"
    domain      = "test-ai.eo.cn"
    auth_switch = "On"
    status      = "Online"
    cname       = "test-ai.eo.cn.edgeonereclaim.dnse1.com"
    create_time = "2026-09-16T20:53:08+08:00"
    update_time = "2026-09-16T20:53:08+08:00"
  }
}

run "apply_inference_domain" {
  command = apply

  assert {
    condition     = tencentcloud_teo_inference_domain.example.id == "zone-3v0yhgt4m1z9#inf-vs06pb1cdz61#test-ai.eo.cn"
    error_message = "id should be zoneId#serviceId#domain"
  }

  assert {
    condition     = tencentcloud_teo_inference_domain.example.zone_id == "zone-3v0yhgt4m1z9"
    error_message = "zone_id should be the configured zone id"
  }

  assert {
    condition     = tencentcloud_teo_inference_domain.example.service_id == "inf-vs06pb1cdz61"
    error_message = "service_id should be the configured inference service id"
  }

  assert {
    condition     = tencentcloud_teo_inference_domain.example.domain == "test-ai.eo.cn"
    error_message = "domain should be the configured inference domain"
  }

  assert {
    condition     = tencentcloud_teo_inference_domain.example.auth_switch == "On"
    error_message = "auth_switch should be On"
  }

  assert {
    condition     = tencentcloud_teo_inference_domain.example.status == "Online"
    error_message = "status should be the mocked domain status"
  }

  assert {
    condition     = tencentcloud_teo_inference_domain.example.cname != ""
    error_message = "cname should be returned from the read API"
  }

  assert {
    condition     = tencentcloud_teo_inference_domain.example.create_time == "2026-09-16T20:53:08+08:00"
    error_message = "create_time should be the mocked creation time"
  }
}
