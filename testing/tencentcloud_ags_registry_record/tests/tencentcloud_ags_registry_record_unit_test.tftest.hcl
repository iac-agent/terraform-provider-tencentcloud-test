override_resource {
  target = tencentcloud_ags_registry_record.example
  values = {
    id             = "registry-abcdef12#rec-12345678"
    record_id      = "rec-12345678"
    resolved_by    = "stable"
    resolved_label = "stable"
  }
}

run "apply_ags_registry_record" {
  command = apply

  assert {
    condition     = tencentcloud_ags_registry_record.example.id == "registry-abcdef12#rec-12345678"
    error_message = "id should be registry-abcdef12#rec-12345678"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.record_id == "rec-12345678"
    error_message = "record_id should be rec-12345678"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.resolved_by == "stable"
    error_message = "resolved_by should be stable"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.resolved_label == "stable"
    error_message = "resolved_label should be stable"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.registry_id == "registry-abcdef12"
    error_message = "registry_id should be registry-abcdef12"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.name == "tf-test-ags-registry-record"
    error_message = "name should be tf-test-ags-registry-record"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.descriptor_type == "MCP"
    error_message = "descriptor_type should be MCP"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.description == "Test record created by terraform"
    error_message = "description should be the configured value"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.version_name == "v1.0.0"
    error_message = "version_name should be v1.0.0"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.mcp_source.type == "MANUAL"
    error_message = "mcp_source.type should be MANUAL"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.mcp_source.endpoint_url == "https://example.com/server.json"
    error_message = "mcp_source.endpoint_url should be the configured URL"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.agent_source.type == "URL_IMPORT"
    error_message = "agent_source.type should be URL_IMPORT"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.skill_source.type == "MANUAL"
    error_message = "skill_source.type should be MANUAL"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.custom_descriptors != ""
    error_message = "custom_descriptors should be the configured JSON string"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.reason == "terraform test cleanup"
    error_message = "reason should be terraform test cleanup"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.label_mutations[0].operation == "SET"
    error_message = "label_mutations[0].operation should be SET"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.label_mutations[0].name == "env-test"
    error_message = "label_mutations[0].name should be env-test"
  }

  assert {
    condition     = tencentcloud_ags_registry_record.example.label_mutations[0].version_id == "rv-12345678"
    error_message = "label_mutations[0].version_id should be rv-12345678"
  }
}
