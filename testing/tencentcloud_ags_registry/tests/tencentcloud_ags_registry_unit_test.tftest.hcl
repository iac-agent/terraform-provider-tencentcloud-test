override_resource {
  target = tencentcloud_ags_registry.example
  values = {
    id            = "reg-abcdef01"
    registry_id   = "reg-abcdef01"
    name          = "ags-registry-test"
    description   = "created by terraform acctest"
    approval_mode = "AUTO"
    tags = [
      {
        key   = "env"
        value = "test"
      },
      {
        key   = "team"
        value = "qa"
      },
    ]
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

run "apply_ags_registry" {
  command = apply

  assert {
    condition     = tencentcloud_ags_registry.example.id == "reg-abcdef01"
    error_message = "id should be reg-abcdef01"
  }

  assert {
    condition     = tencentcloud_ags_registry.example.registry_id == "reg-abcdef01"
    error_message = "registry_id should be reg-abcdef01"
  }

  assert {
    condition     = tencentcloud_ags_registry.example.name == "ags-registry-test"
    error_message = "name should be ags-registry-test"
  }

  assert {
    condition     = tencentcloud_ags_registry.example.description == "created by terraform acctest"
    error_message = "description should be as configured"
  }

  assert {
    condition     = tencentcloud_ags_registry.example.approval_mode == "AUTO"
    error_message = "approval_mode should be AUTO"
  }

  assert {
    condition     = tencentcloud_ags_registry.example.tags[0].key == "env" && tencentcloud_ags_registry.example.tags[0].value == "test"
    error_message = "tags[0] should be env=test"
  }

  assert {
    condition     = tencentcloud_ags_registry.example.tags[1].key == "team" && tencentcloud_ags_registry.example.tags[1].value == "qa"
    error_message = "tags[1] should be team=qa"
  }

  assert {
    condition     = tencentcloud_ags_registry.example.registry.status == "ACTIVE"
    error_message = "registry.status should be ACTIVE"
  }

  assert {
    condition     = tencentcloud_ags_registry.example.registry.region == "ap-guangzhou"
    error_message = "registry.region should be ap-guangzhou"
  }

  assert {
    condition     = tencentcloud_ags_registry.example.registry.app_id == 1250000000
    error_message = "registry.app_id should be 1250000000"
  }

  assert {
    condition     = tencentcloud_ags_registry.example.registry.creator_uin == "100000000001"
    error_message = "registry.creator_uin should be 100000000001"
  }

  assert {
    condition     = tencentcloud_ags_registry.example.registry.record_count == 0 && tencentcloud_ags_registry.example.registry.published_record_count == 0
    error_message = "registry record counts should be 0"
  }

}
