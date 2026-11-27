# Online tests for the tencentcloud_ags_sandbox_instances data source
# (DescribeSandboxInstances, AGS v20250920).
#
# The data source is read-only: it only queries DescribeSandboxInstances and
# creates no cloud resources, so these tests produce no residue and need no
# destroy. Assertions target the real cloud responses:
#   - unfiltered query returns a well-formed instance_set;
#   - filtered query returns only instances whose ids are within the
#     configured instance_ids filter;
#   - filtered query state echoes back the configured filter list.
# When var.instance_ids is empty (no instances provided by the caller) the
# filtered run only asserts the echoed filter and well-formedness.

run "query_all_sandbox_instances" {
  command = apply

  assert {
    condition     = length(data.tencentcloud_ags_sandbox_instances.all.id) > 0
    error_message = "the data source id (random token) should not be empty"
  }

  assert {
    condition     = can([for it in data.tencentcloud_ags_sandbox_instances.all.instance_set : it.instance_id]) && can([for it in data.tencentcloud_ags_sandbox_instances.all.instance_set : it.status])
    error_message = "every returned instance should expose instance_id and status"
  }

  assert {
    condition     = alltrue([for it in data.tencentcloud_ags_sandbox_instances.all.instance_set : contains(["STARTING", "RUNNING", "STOPPING", "STOPPED", "STOP_FAILED", "FAILED", "RESIZING"], it.status)])
    error_message = "every returned instance status should be one of the documented enum values"
  }

  assert {
    condition     = alltrue([for it in data.tencentcloud_ags_sandbox_instances.all.instance_set : length(it.tool_id) > 0 && length(it.tool_name) > 0])
    error_message = "every returned instance should carry a non-empty tool_id and tool_name"
  }
}

run "query_filtered_sandbox_instances" {
  command = apply

  assert {
    condition     = length(data.tencentcloud_ags_sandbox_instances.filtered.instance_ids) == length(var.instance_ids)
    error_message = "the filtered query should echo back the configured instance_ids filter"
  }

  assert {
    condition     = length(data.tencentcloud_ags_sandbox_instances.filtered.id) > 0
    error_message = "the filtered data source id (random token) should not be empty"
  }

  # When no ids are supplied the API treats the empty list as "no filter" and
  # returns the full set; the filtered run then only asserts well-formedness.
  assert {
    condition     = length(var.instance_ids) == 0 || alltrue([for it in data.tencentcloud_ags_sandbox_instances.filtered.instance_set : contains(var.instance_ids, it.instance_id)])
    error_message = "every returned instance should be within the configured instance_ids filter"
  }

  assert {
    condition     = alltrue([for it in data.tencentcloud_ags_sandbox_instances.filtered.instance_set : contains(["STARTING", "RUNNING", "STOPPING", "STOPPED", "STOP_FAILED", "FAILED", "RESIZING"], it.status)])
    error_message = "every returned instance status should be one of the documented enum values"
  }
}
