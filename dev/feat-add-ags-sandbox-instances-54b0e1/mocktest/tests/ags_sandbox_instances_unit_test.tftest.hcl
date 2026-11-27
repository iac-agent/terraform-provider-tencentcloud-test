# Mock tests for the tencentcloud_ags_sandbox_instances data source
# (DescribeSandboxInstances, AGS v20250920).
#
# Terraform 1.11's override_data cannot build a list-of-object value for a
# framework ListNestedAttribute (it always yields a tuple and fails with
# "expected object type, found tuple"; function calls such as tolist() are
# rejected in override values), so instance_set is not mocked explicitly and
# stays an empty list; the scalar id and the instance_ids query-filter
# attributes are asserted directly. The list element mapping is covered by Go
# unit tests in the provider repository.

override_data {
  target = data.tencentcloud_ags_sandbox_instances.all
  values = {
    instance_ids = null
  }
}

override_data {
  target = data.tencentcloud_ags_sandbox_instances.filtered
  values = {
    instance_ids = ["instance-mock0001", "instance-mock0002"]
  }
}

run "query_all_sandbox_instances" {
  command = apply

  assert {
    condition     = length(data.tencentcloud_ags_sandbox_instances.all.id) > 0
    error_message = "id should be a non-empty random token"
  }

  assert {
    condition     = data.tencentcloud_ags_sandbox_instances.all.instance_ids == null
    error_message = "instance_ids should stay unset when no filter is configured"
  }

  assert {
    condition     = length(data.tencentcloud_ags_sandbox_instances.all.instance_set) == 0
    error_message = "instance_set should be an empty list when it is not mocked"
  }
}

run "query_filtered_sandbox_instances" {
  command = apply

  assert {
    condition     = length(data.tencentcloud_ags_sandbox_instances.filtered.id) > 0
    error_message = "id should be a non-empty random token"
  }

  assert {
    condition     = length(data.tencentcloud_ags_sandbox_instances.filtered.instance_ids) == 2 && data.tencentcloud_ags_sandbox_instances.filtered.instance_ids[0] == "instance-mock0001" && data.tencentcloud_ags_sandbox_instances.filtered.instance_ids[1] == "instance-mock0002"
    error_message = "the configured instance_ids filter should be kept in state"
  }

  assert {
    condition     = length(data.tencentcloud_ags_sandbox_instances.filtered.instance_set) == 0
    error_message = "instance_set should be an empty list when it is not mocked"
  }
}
