# Mock tests for the tencentcloud_teo_custom_groups data source
# (DescribeCustomGroups, TEO v20220901).
#
# The data source would call the cloud API during plan; override_data returns
# fake values so no request is made. Terraform 1.11's override_data cannot
# build a list-of-object value for a framework ListNestedAttribute (it always
# yields a tuple and fails with "expected object type, found tuple"), so the
# custom_groups list is not mocked here; the scalar query inputs and
# group_total_count are asserted directly. The nested list mapping is covered
# by Go unit tests in the provider repository.

override_data {
  target = data.tencentcloud_teo_custom_groups.example
  values = {
    zone_id           = "zone-27h0vbm5w1e"
    group_types       = ["TLSFingerprint", "UA"]
    group_total_count = 2
  }
}

override_data {
  target = data.tencentcloud_teo_custom_groups.all
  values = {
    zone_id           = "zone-27h0vbm5w1e"
    group_total_count = 3
  }
}

override_data {
  target = data.tencentcloud_teo_custom_groups.referer
  values = {
    zone_id           = "zone-27h0vbm5w1e"
    group_types       = ["Referer"]
    group_total_count = 1
  }
}

run "plan_teo_custom_groups" {
  command = plan

  assert {
    condition     = data.tencentcloud_teo_custom_groups.example.zone_id == "zone-27h0vbm5w1e"
    error_message = "zone_id should be zone-27h0vbm5w1e"
  }

  assert {
    condition     = length(data.tencentcloud_teo_custom_groups.example.group_types) == 2
    error_message = "group_types should contain 2 entries"
  }

  assert {
    condition     = data.tencentcloud_teo_custom_groups.example.group_types[0] == "TLSFingerprint"
    error_message = "group_types[0] should be TLSFingerprint"
  }

  assert {
    condition     = data.tencentcloud_teo_custom_groups.example.group_types[1] == "UA"
    error_message = "group_types[1] should be UA"
  }

  assert {
    condition     = data.tencentcloud_teo_custom_groups.example.group_total_count == 2
    error_message = "group_total_count should be 2"
  }
}

run "plan_teo_custom_groups_all_types" {
  command = plan

  assert {
    condition     = data.tencentcloud_teo_custom_groups.all.zone_id == "zone-27h0vbm5w1e"
    error_message = "zone_id should be zone-27h0vbm5w1e"
  }

  assert {
    condition     = data.tencentcloud_teo_custom_groups.all.group_total_count == 3
    error_message = "group_total_count should be 3"
  }
}

run "plan_teo_custom_groups_referer_filter" {
  command = plan

  assert {
    condition     = data.tencentcloud_teo_custom_groups.referer.zone_id == "zone-27h0vbm5w1e"
    error_message = "zone_id should be zone-27h0vbm5w1e"
  }

  assert {
    condition     = length(data.tencentcloud_teo_custom_groups.referer.group_types) == 1
    error_message = "group_types should contain 1 entry"
  }

  assert {
    condition     = data.tencentcloud_teo_custom_groups.referer.group_types[0] == "Referer"
    error_message = "group_types[0] should be Referer"
  }

  assert {
    condition     = data.tencentcloud_teo_custom_groups.referer.group_total_count == 1
    error_message = "group_total_count should be 1"
  }
}
