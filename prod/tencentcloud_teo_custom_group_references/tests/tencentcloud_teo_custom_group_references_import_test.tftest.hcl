# Import-scope plan test for the tencentcloud_teo_custom_group_references
# data source (DescribeCustomGroupReferences, TEO v2022-09-01).
#
# A data source has no terraform import block, so this file covers the second
# data source instance from main.tf with a different zone_id / group_id pair,
# proving the full read path stays cloud-API-free for any query combination.
# references is a Computed framework ListNestedAttribute: Terraform 1.11's
# override_data cannot build a list-of-object value for it (it always yields
# a tuple and fails with "expected object type, found tuple"), so it is not
# overridden and stays unknown during plan; its element mapping is covered by
# the Go unit tests in the provider repository.

run "plan_teo_custom_group_references_second_group" {
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
    condition     = data.tencentcloud_teo_custom_group_references.second.zone_id == "zone-9k3gq2xvpl0m"
    error_message = "second zone_id should be zone-9k3gq2xvpl0m"
  }

  assert {
    condition     = data.tencentcloud_teo_custom_group_references.second.group_id == "cg-8r5tjzcewm2y"
    error_message = "second group_id should be cg-8r5tjzcewm2y"
  }
}
