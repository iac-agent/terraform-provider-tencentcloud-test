override_resource {
  target = tencentcloud_ags_pre_cache_image_task.example
  values = {
    id                      = "cache-001"
    pre_cache_image_id      = "cache-001"
    image                   = "ccr.ccs.tencentyun.com/tf-example/demo:v1"
    image_registry_type     = "personal"
    image_digest            = "sha256:0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef"
    status                  = "READY"
    message                 = "pre cache finished"
    create_time             = "2026-01-01T00:00:00Z"
    ready_time              = "2026-01-01T00:10:00Z"
    last_used_time          = "2026-01-02T00:00:00Z"
    source_type             = "EXPLICIT"
    cached_image_size_bytes = 1048576
  }
}

run "apply_ags_pre_cache_image_task" {
  command = apply

  assert {
    condition     = tencentcloud_ags_pre_cache_image_task.example.id == "cache-001"
    error_message = "id should be cache-001"
  }

  assert {
    condition     = tencentcloud_ags_pre_cache_image_task.example.pre_cache_image_id == "cache-001"
    error_message = "pre_cache_image_id should be cache-001"
  }

  assert {
    condition     = tencentcloud_ags_pre_cache_image_task.example.image == "ccr.ccs.tencentyun.com/tf-example/demo:v1"
    error_message = "image should be the configured value"
  }

  assert {
    condition     = tencentcloud_ags_pre_cache_image_task.example.image_registry_type == "personal"
    error_message = "image_registry_type should be personal"
  }

  assert {
    condition     = tencentcloud_ags_pre_cache_image_task.example.image_digest == "sha256:0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef"
    error_message = "image_digest should be the mocked digest"
  }

  assert {
    condition     = tencentcloud_ags_pre_cache_image_task.example.status == "READY"
    error_message = "status should be READY"
  }

  assert {
    condition     = tencentcloud_ags_pre_cache_image_task.example.message == "pre cache finished"
    error_message = "message should be pre cache finished"
  }

  assert {
    condition     = tencentcloud_ags_pre_cache_image_task.example.create_time == "2026-01-01T00:00:00Z"
    error_message = "create_time should be 2026-01-01T00:00:00Z"
  }

  assert {
    condition     = tencentcloud_ags_pre_cache_image_task.example.ready_time == "2026-01-01T00:10:00Z"
    error_message = "ready_time should be 2026-01-01T00:10:00Z"
  }

  assert {
    condition     = tencentcloud_ags_pre_cache_image_task.example.last_used_time == "2026-01-02T00:00:00Z"
    error_message = "last_used_time should be 2026-01-02T00:00:00Z"
  }

  assert {
    condition     = tencentcloud_ags_pre_cache_image_task.example.source_type == "EXPLICIT"
    error_message = "source_type should be EXPLICIT"
  }

  assert {
    condition     = tencentcloud_ags_pre_cache_image_task.example.cached_image_size_bytes == 1048576
    error_message = "cached_image_size_bytes should be 1048576"
  }
}
