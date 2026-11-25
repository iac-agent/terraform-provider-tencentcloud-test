# Unit tests for the tencentcloud_teo_custom_group_references data source
# (DescribeCustomGroupReferences, TEO v2022-09-01).
#
# The data source has two required query inputs (zone_id, group_id) and one
# Computed list (references). Terraform 1.11's override_data cannot build a
# list-of-object value for a framework ListNestedAttribute (it always yields
# a tuple and fails with "expected object type, found tuple"), so the
# references list is not mocked explicitly; its element mapping is covered by
# the Go unit tests in the provider repository. Only the config-written query
# inputs are asserted in plan mode.

run "plan_teo_custom_group_references" {
  command = plan

  # The data block would call the cloud API during plan: override_data
  # returns fake values, no request is made.
  override_data {
    target = data.tencentcloud_teo_custom_group_references.example
    values = {
      zone_id  = "zone-3fkff38fyw8s"
      group_id = "cg-2q1pkwfyagzz"
    }
  }

  override_data {
    target = data.tencentcloud_teo_custom_group_references.second
    values = {
      zone_id  = "zone-9k3gq2xvpl0m"
      group_id = "cg-8r5tjzcewm2y"
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
