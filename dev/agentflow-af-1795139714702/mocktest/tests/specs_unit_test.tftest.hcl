# Mock tests for the tencentcloud_ags_gpu_resource_specs data source
# (DescribeGPUResourceSpecs, AGS v20250920).
#
# Terraform 1.11's override_data cannot build a list-of-object value for a
# framework ListNestedAttribute (it always yields a tuple and fails with
# "expected object type, found tuple"), so specs is not mocked explicitly and
# stays an empty list; the scalar query-input and total_count attributes are
# asserted directly. The list element mapping is covered by Go unit tests in
# the provider repository.

override_data {
  target = data.tencentcloud_ags_gpu_resource_specs.all
  values = {
    gpu_type    = null
    cpu         = null
    memory      = null
    gpu_num     = null
    offset      = null
    limit       = null
    total_count = 2
  }
}

override_data {
  target = data.tencentcloud_ags_gpu_resource_specs.filtered
  values = {
    gpu_type    = "5090d"
    cpu         = 64
    memory      = 192
    gpu_num     = 2
    offset      = null
    limit       = null
    total_count = 1
  }
}

run "query_all_specs" {
  command = plan

  assert {
    condition     = data.tencentcloud_ags_gpu_resource_specs.all.gpu_type == null
    error_message = "gpu_type should stay unset when no filter is configured"
  }

  assert {
    condition     = data.tencentcloud_ags_gpu_resource_specs.all.total_count == 2
    error_message = "total_count should be 2"
  }

  assert {
    condition     = length(data.tencentcloud_ags_gpu_resource_specs.all.specs) == 0
    error_message = "specs should be an empty list"
  }
}

run "query_filtered_spec" {
  command = plan

  assert {
    condition     = data.tencentcloud_ags_gpu_resource_specs.filtered.gpu_type == "5090d"
    error_message = "gpu_type should keep the configured filter value 5090d"
  }

  assert {
    condition     = data.tencentcloud_ags_gpu_resource_specs.filtered.cpu == 64 && data.tencentcloud_ags_gpu_resource_specs.filtered.memory == 192 && data.tencentcloud_ags_gpu_resource_specs.filtered.gpu_num == 2
    error_message = "cpu/memory/gpu_num should keep the configured filter values"
  }

  assert {
    condition     = data.tencentcloud_ags_gpu_resource_specs.filtered.total_count == 1
    error_message = "total_count should be 1"
  }

  assert {
    condition     = length(data.tencentcloud_ags_gpu_resource_specs.filtered.specs) == 0
    error_message = "specs should be an empty list"
  }
}
