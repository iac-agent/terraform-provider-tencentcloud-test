# Online tests for the tencentcloud_ags_gpu_resource_specs data source
# (DescribeGPUResourceSpecs, AGS v20250920).
#
# These tests run against the real cloud: no mock/override is used, asserts
# check the actual API response. The data source is read-only, so the test
# leaves no resources behind and nothing needs to be destroyed.

run "query_all_specs_online" {
  command = apply

  # The query must succeed against the real cloud and always report a
  # non-negative total count and a non-null specs list.
  assert {
    condition     = data.tencentcloud_ags_gpu_resource_specs.all.total_count >= 0
    error_message = "total_count should be non-negative on a successful real-cloud query"
  }

  assert {
    condition     = data.tencentcloud_ags_gpu_resource_specs.all.specs != null
    error_message = "specs should never be null; the API returns [] when no sellable spec exists"
  }

  # Every returned spec must carry a non-empty GPU type identifier.
  assert {
    condition     = alltrue([for s in data.tencentcloud_ags_gpu_resource_specs.all.specs : s.gpu_type != null && s.gpu_type != ""])
    error_message = "every returned spec must report a non-empty gpu_type"
  }

  # Every returned spec must report positive per-instance CPU, memory and GPU card counts.
  assert {
    condition     = alltrue([for s in data.tencentcloud_ags_gpu_resource_specs.all.specs : s.cpu > 0 && s.memory > 0 && s.gpu_num > 0])
    error_message = "every returned spec must report positive cpu, memory and gpu_num"
  }

  # available_count may be null (quota unknown) but, when reported, must be non-negative.
  assert {
    condition     = alltrue([for s in data.tencentcloud_ags_gpu_resource_specs.all.specs : s.available_count == null || s.available_count >= 0])
    error_message = "available_count must be null (unknown quota) or non-negative"
  }
}

run "query_filtered_spec_online" {
  command = apply

  # The configured filter inputs must be preserved in the state.
  assert {
    condition     = data.tencentcloud_ags_gpu_resource_specs.filtered.gpu_type == var.gpu_type
    error_message = "gpu_type should keep the configured filter value"
  }

  assert {
    condition     = data.tencentcloud_ags_gpu_resource_specs.filtered.cpu == var.cpu && data.tencentcloud_ags_gpu_resource_specs.filtered.memory == var.memory && data.tencentcloud_ags_gpu_resource_specs.filtered.gpu_num == var.gpu_num
    error_message = "cpu/memory/gpu_num should keep the configured filter values"
  }

  # The exact-match query returns at most one spec (all four items match exactly).
  assert {
    condition     = data.tencentcloud_ags_gpu_resource_specs.filtered.total_count <= 1
    error_message = "an exact four-item filter must match at most one spec"
  }

  # When a spec is returned, it must echo back the filtered GPU type.
  assert {
    condition     = data.tencentcloud_ags_gpu_resource_specs.filtered.total_count == 0 || data.tencentcloud_ags_gpu_resource_specs.filtered.specs[0].gpu_type == var.gpu_type
    error_message = "the returned spec (if any) must match the filtered gpu_type"
  }
}
