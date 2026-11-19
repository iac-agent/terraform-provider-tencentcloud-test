override_resource {
  target = tencentcloud_ags_gpu_resource_group.example
  values = {
    id              = "rg-mock-0001"
    resource_group_id = "rg-mock-0001"
    name            = "tf-test-gpu-group"
    gpu_type        = "5090d"
    gpu_type_alias  = "RTX 5090D"
    gpu_memory_gib  = 32
    cpu             = 16
    memory          = 64
    gpu_num         = 1
    total_count     = 4
    available_count = 2
    allocated_count = 2
  }
}

run "apply_ags_gpu_resource_group" {
  command = apply

  assert {
    condition     = tencentcloud_ags_gpu_resource_group.example.id == "rg-mock-0001"
    error_message = "id should be rg-mock-0001"
  }

  assert {
    condition     = tencentcloud_ags_gpu_resource_group.example.resource_group_id == "rg-mock-0001"
    error_message = "resource_group_id should be rg-mock-0001"
  }

  assert {
    condition     = tencentcloud_ags_gpu_resource_group.example.name == "tf-test-gpu-group"
    error_message = "name should be tf-test-gpu-group"
  }

  assert {
    condition     = tencentcloud_ags_gpu_resource_group.example.gpu_type == "5090d"
    error_message = "gpu_type should be 5090d"
  }

  assert {
    condition     = tencentcloud_ags_gpu_resource_group.example.gpu_memory_gib == 32
    error_message = "gpu_memory_gib should be 32"
  }

  assert {
    condition     = tencentcloud_ags_gpu_resource_group.example.gpu_num == 1
    error_message = "gpu_num should be 1"
  }

  assert {
    condition     = tencentcloud_ags_gpu_resource_group.example.total_count == 4
    error_message = "total_count should be 4"
  }

  assert {
    condition     = tencentcloud_ags_gpu_resource_group.example.available_count == 2
    error_message = "available_count should be 2"
  }
}
