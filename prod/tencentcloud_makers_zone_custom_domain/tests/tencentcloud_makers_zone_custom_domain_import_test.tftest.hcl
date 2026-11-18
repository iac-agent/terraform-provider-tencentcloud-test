override_resource {
  target = tencentcloud_makers_zone_custom_domain.example
  values = {
    id         = "zone-12345678#0#www.example.com"
    zone_id    = "zone-12345678"
    project_id = "0"
    domain     = "www.example.com"
    env        = "Production"
  }
}

run "import_makers_zone_custom_domain" {
  command = apply

  assert {
    condition     = tencentcloud_makers_zone_custom_domain.example.id == "zone-12345678#0#www.example.com"
    error_message = "id should be the composite zone_id#project_id#domain value"
  }

  assert {
    condition     = tencentcloud_makers_zone_custom_domain.example.zone_id == "zone-12345678"
    error_message = "zone_id should be zone-12345678"
  }

  assert {
    condition     = tencentcloud_makers_zone_custom_domain.example.project_id == "0"
    error_message = "project_id should be 0"
  }

  assert {
    condition     = tencentcloud_makers_zone_custom_domain.example.domain == "www.example.com"
    error_message = "domain should be www.example.com"
  }

  assert {
    condition     = tencentcloud_makers_zone_custom_domain.example.env == "Production"
    error_message = "env should be Production"
  }
}
