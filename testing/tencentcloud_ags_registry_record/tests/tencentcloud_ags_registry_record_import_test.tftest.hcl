override_resource {
  target = tencentcloud_ags_registry_record.example
  values = {
    id             = "registry-abcdef12#rec-12345678"
    record_id      = "rec-12345678"
    resolved_by    = "stable"
    resolved_label = "stable"
  }
}

run "import_ags_registry_record" {
  command = apply

  assert {
    condition     = tencentcloud_ags_registry_record.example.id == "registry-abcdef12#rec-12345678"
    error_message = "id should be registry-abcdef12#rec-12345678"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.registry_id == "registry-abcdef12"
    error_message = "registry_id should be registry-abcdef12"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.record_id == "rec-12345678"
    error_message = "record_id should be rec-12345678"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.name == "tf-test-ags-registry-record"
    error_message = "name should be the configured value"
  }
}
