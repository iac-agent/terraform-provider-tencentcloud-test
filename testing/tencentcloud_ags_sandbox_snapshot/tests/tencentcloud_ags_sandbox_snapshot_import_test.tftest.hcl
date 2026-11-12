override_resource {
  target = tencentcloud_ags_sandbox_snapshot.example
  values = {
    id            = "snap-mock-0001"
    instance_id   = "sandbox-8f9de2ab"
    snapshot_name = "tf-test-snapshot"
    memory        = true
    client_token  = "tf-test-client-token-001"
    status        = "ACTIVE"
    status_reason = ""
    create_time   = "2025-09-20T10:00:00Z"
    update_time   = "2025-09-20T10:00:00Z"
    tags = [
      {
        key   = "env"
        value = "test"
      },
      {
        key   = "owner"
        value = "tf"
      },
    ]
  }
}

run "import_ags_sandbox_snapshot" {
  command = apply

  assert {
    condition     = tencentcloud_ags_sandbox_snapshot.example.id == "snap-mock-0001"
    error_message = "id should be snap-mock-0001"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_snapshot.example.instance_id == "sandbox-8f9de2ab"
    error_message = "instance_id should be sandbox-8f9de2ab"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_snapshot.example.snapshot_name == "tf-test-snapshot"
    error_message = "snapshot_name should be tf-test-snapshot"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_snapshot.example.memory == true
    error_message = "memory should be true"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_snapshot.example.status == "ACTIVE"
    error_message = "status should be ACTIVE"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_snapshot.example.tags[0].key == "env"
    error_message = "tags[0].key should be env"
  }

  assert {
    condition     = tencentcloud_ags_sandbox_snapshot.example.tags[1].value == "tf"
    error_message = "tags[1].value should be tf"
  }
}
