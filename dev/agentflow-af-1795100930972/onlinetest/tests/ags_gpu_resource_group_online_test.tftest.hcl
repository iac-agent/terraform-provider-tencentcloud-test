run "import_rename_and_read_gpu_resource_group" {
  command = apply

  assert {
    condition     = tencentcloud_ags_gpu_resource_group.example.id == var.resource_group_id
    error_message = "id should equal the imported resource group id"
  }

  assert {
    condition     = tencentcloud_ags_gpu_resource_group.example.resource_group_id == var.resource_group_id
    error_message = "resource_group_id should equal the imported resource group id"
  }

  # var.initial_name must differ from the group's current cloud name, so this
  # apply exercised ModifyGPUResourceGroup and the read-back shows the new name.
  assert {
    condition     = tencentcloud_ags_gpu_resource_group.example.name == var.initial_name
    error_message = "name should be the renamed value reported by DescribeGPUResourceGroups"
  }

  assert {
    condition     = tencentcloud_ags_gpu_resource_group.example.gpu_type != ""
    error_message = "gpu_type should be reported by the cloud"
  }

  assert {
    condition     = tencentcloud_ags_gpu_resource_group.example.gpu_num > 0
    error_message = "gpu_num should be a positive number reported by the cloud"
  }

  assert {
    condition     = tencentcloud_ags_gpu_resource_group.example.total_count >= 0
    error_message = "total_count should be reported by the cloud"
  }
}

run "reapply_is_stable" {
  command = apply

  # A second apply of the same configuration must not drift: the name already
  # matches the cloud value after the rename in the previous run.
  assert {
    condition     = tencentcloud_ags_gpu_resource_group.example.resource_group_id == var.resource_group_id
    error_message = "resource group identity must not change on re-apply"
  }

  assert {
    condition     = tencentcloud_ags_gpu_resource_group.example.name == var.initial_name
    error_message = "name should remain the renamed value on re-apply"
  }

  assert {
    condition     = tencentcloud_ags_gpu_resource_group.example.gpu_type != ""
    error_message = "gpu_type should still be readable on re-apply"
  }
}
