# Mock tests for the tencentcloud_csip_check_view_risks data source
# (DescribeCheckViewRisks, CSIP v2022-11-21).
#
# Terraform 1.11's override_data cannot build a list-of-object value for a
# framework ListNestedAttribute (it always yields a tuple and fails with
# "expected object type, found tuple", and function calls such as tolist are
# not allowed inside override_data), so check_view_risk_list /
# standard_name_list / asset_type_list / provider_list are not mocked
# explicitly and stay empty lists. The scalar attributes (id and the query
# inputs) are asserted directly, and the list element mapping is covered by Go
# unit tests in the provider repository.

override_data {
  target = data.tencentcloud_csip_check_view_risks.all
  values = {
    id    = "mock-check-view-risks-all"
    order = "DESC"
    by    = "RiskCount"
  }
}

override_data {
  target = data.tencentcloud_csip_check_view_risks.filtered
  values = {
    id        = "mock-check-view-risks-filtered"
    member_id = ["mem-10000001"]
    order     = "ASC"
    by        = "Severity"
  }
}

run "query_all_check_view_risks" {
  command = apply

  assert {
    condition     = data.tencentcloud_csip_check_view_risks.all.id == "mock-check-view-risks-all"
    error_message = "data source id should be the mocked token"
  }

  assert {
    condition     = data.tencentcloud_csip_check_view_risks.all.order == "DESC" && data.tencentcloud_csip_check_view_risks.all.by == "RiskCount"
    error_message = "order / by should keep the configured sort options"
  }

  assert {
    condition     = length(data.tencentcloud_csip_check_view_risks.all.check_view_risk_list) == 0
    error_message = "check_view_risk_list should be an empty list when not mockable"
  }

  assert {
    condition     = length(data.tencentcloud_csip_check_view_risks.all.standard_name_list) == 0 && length(data.tencentcloud_csip_check_view_risks.all.asset_type_list) == 0 && length(data.tencentcloud_csip_check_view_risks.all.provider_list) == 0
    error_message = "standard_name_list / asset_type_list / provider_list should be empty lists when not mockable"
  }
}

run "query_filtered_check_view_risks" {
  command = apply

  assert {
    condition     = data.tencentcloud_csip_check_view_risks.filtered.id == "mock-check-view-risks-filtered"
    error_message = "filtered data source id should be the mocked token"
  }

  assert {
    condition     = data.tencentcloud_csip_check_view_risks.filtered.member_id == tolist(["mem-10000001"])
    error_message = "member_id should keep the configured member list"
  }

  assert {
    condition = data.tencentcloud_csip_check_view_risks.filtered.filters[0].name == "Status" && data.tencentcloud_csip_check_view_risks.filtered.filters[0].values == tolist(["SUCCESS"]) && data.tencentcloud_csip_check_view_risks.filtered.filters[0].exact_match == "1"
    error_message = "filters should keep the configured name / values / exact_match"
  }

  assert {
    condition     = data.tencentcloud_csip_check_view_risks.filtered.order == "ASC" && data.tencentcloud_csip_check_view_risks.filtered.by == "Severity"
    error_message = "filtered order / by should keep the configured sort options"
  }
}
