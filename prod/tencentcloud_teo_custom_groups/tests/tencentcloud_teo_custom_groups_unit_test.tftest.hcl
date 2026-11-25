# Mock tests for the tencentcloud_teo_custom_groups data source
# (DescribeCustomGroups, TEO v20220901).
#
# Terraform 1.11's override_data cannot build a list-of-object value for a
# framework ListNestedAttribute (it always yields a tuple and fails with
# "expected object type, found tuple"), so custom_groups is not mocked
# explicitly and stays an empty list. The scalar attributes (zone_id,
# group_types, group_total_count) are asserted directly, and the list element
# mapping is covered by Go unit tests in the provider repository.

override_data {
  target = data.tencentcloud_teo_custom_groups.all
  values = {
    zone_id           = "zone-27h0vbm5w1e"
    group_types       = null
    group_total_count = 2
  }
}

override_data {
  target = data.tencentcloud_teo_custom_groups.filtered
  values = {
    zone_id           = "zone-27h0vbm5w1e"
    group_types       = ["TLSFingerprint", "UA", "Referer"]
    group_total_count = 1
  }
}

run "query_all_custom_groups" {
  command = plan

  assert {
    condition     = data.tencentcloud_teo_custom_groups.all.zone_id == "zone-27h0vbm5w1e"
    error_message = "zone_id should keep the configured site id"
  }

  assert {
    condition     = data.tencentcloud_teo_custom_groups.all.group_types == null
    error_message = "group_types should stay unset when no filter is configured"
  }

  assert {
    condition     = data.tencentcloud_teo_custom_groups.all.group_total_count == 2
    error_message = "group_total_count should be 2"
  }

  assert {
    condition     = length(data.tencentcloud_teo_custom_groups.all.custom_groups) == 0
    error_message = "custom_groups should be an empty list when not mockable"
  }
}

run "query_custom_groups_by_type" {
  command = plan

  assert {
    condition     = data.tencentcloud_teo_custom_groups.filtered.zone_id == "zone-27h0vbm5w1e"
    error_message = "filtered zone_id should keep the configured site id"
  }

  assert {
    condition     = data.tencentcloud_teo_custom_groups.filtered.group_types == tolist(["TLSFingerprint", "UA", "Referer"])
    error_message = "group_types should keep the configured filter list"
  }

  assert {
    condition     = data.tencentcloud_teo_custom_groups.filtered.group_total_count == 1
    error_message = "filtered group_total_count should be 1"
  }

  assert {
    condition     = length(data.tencentcloud_teo_custom_groups.filtered.custom_groups) == 0
    error_message = "filtered custom_groups should be an empty list when not mockable"
  }
}
