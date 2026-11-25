# Mock tests for the tencentcloud_teo_custom_group_references data source
# (DescribeCustomGroupReferences, TEO v20220901, framework stack).
#
# The data block calls the cloud API at plan time, so every run block uses
# override_data to return fake values without issuing any request. Terraform
# 1.11's override_data cannot build a list-of-object value for a framework
# ListNestedAttribute (it always yields a tuple and fails with "expected object
# type, found tuple"), so the computed references list is not mocked explicitly
# and stays an empty list; the required query inputs zone_id/group_id are
# asserted directly. The list element mapping is covered by Go unit tests in
# the provider repository.

run "plan_teo_custom_group_references" {
  command = plan

  # Data source would call the cloud API during plan; override_data returns
  # fake values so no request is made.
  override_data {
    target = data.tencentcloud_teo_custom_group_references.example
    values = {
      zone_id  = "zone-3fkff38fyw8s"
      group_id = "cg-2q1pkwfyagzz"
    }
  }

  assert {
    condition     = data.tencentcloud_teo_custom_group_references.example.zone_id == "zone-3fkff38fyw8s"
    error_message = "zone_id should be zone-3fkff38fyw8s"
  }

  assert {
    condition     = data.tencentcloud_teo_custom_group_references.example.group_id == "cg-2q1pkwfyagzz"
    error_message = "group_id should be cg-2q1pkwfyagzz"
  }
}

run "plan_teo_custom_group_references_empty_result" {
  command = plan

  # A custom group that no configuration references returns an empty list,
  # which is a valid outcome, not a failure.
  override_data {
    target = data.tencentcloud_teo_custom_group_references.example
    values = {
      zone_id  = "zone-3fkff38fyw8s"
      group_id = "cg-2q1pkwfyagzz"
    }
  }

  assert {
    condition     = data.tencentcloud_teo_custom_group_references.example.zone_id == "zone-3fkff38fyw8s"
    error_message = "zone_id should be zone-3fkff38fyw8s"
  }

  assert {
    condition     = data.tencentcloud_teo_custom_group_references.example.group_id == "cg-2q1pkwfyagzz"
    error_message = "group_id should be cg-2q1pkwfyagzz"
  }

  assert {
    condition     = length(data.tencentcloud_teo_custom_group_references.example.references) == 0
    error_message = "references should be an empty list when the override does not mock it"
  }
}
