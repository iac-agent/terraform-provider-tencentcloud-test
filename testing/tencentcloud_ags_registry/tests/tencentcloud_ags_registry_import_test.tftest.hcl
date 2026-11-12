override_resource {
  target = tencentcloud_ags_registry.example
  values = {
    id            = "reg-abcdef01"
    registry_id   = "reg-abcdef01"
    name          = "ags-registry-test"
    description   = "created by terraform acctest"
    approval_mode = "AUTO"
    registry = {
      registry_id             = "reg-abcdef01"
      name                    = "ags-registry-test"
      description             = "created by terraform acctest"
      approval_mode           = "AUTO"
      region                  = "ap-guangzhou"
      status                  = "ACTIVE"
      create_time             = "2026-08-11T10:00:00Z"
      update_time             = "2026-08-11T10:00:00Z"
      record_count            = 0
      published_record_count  = 0
      app_id                  = 1250000000
      creator_uin             = "100000000001"
      creator_sub_account_uin = ""
    }
  }
}

run "import_ags_registry" {
  command = apply

  assert {
    condition     = tencentcloud_ags_registry.example.id == "reg-abcdef01"
    error_message = "id should be reg-abcdef01 after import"
  }

  assert {
    condition     = tencentcloud_ags_registry.example.registry_id == "reg-abcdef01"
    error_message = "registry_id should be reg-abcdef01 after import"
  }

  assert {
    condition     = tencentcloud_ags_registry.example.name == "ags-registry-test"
    error_message = "name should be ags-registry-test after import"
  }

  assert {
    condition     = tencentcloud_ags_registry.example.approval_mode == "AUTO"
    error_message = "approval_mode should be AUTO after import"
  }

  assert {
    condition     = tencentcloud_ags_registry.example.registry.status == "ACTIVE"
    error_message = "registry.status should be ACTIVE after import"
  }

  assert {
    condition     = tencentcloud_ags_registry.example.registry.app_id == 1250000000
    error_message = "registry.app_id should be 1250000000 after import"
  }
}
