# Online test for the tencentcloud_csip_check_view_risks data source
# (DescribeCheckViewRisks, CSIP 2022-11-21). No mock override is used: both
# data sources are read from the real cloud of the executing account. The
# queries are read-only, so `terraform test` destroys nothing and leaves no
# residue.
#
# A fresh account may legitimately have no check-view risks, therefore the
# item-level asserts are written with `alltrue([... for ...])` so they hold
# for an empty list as well and only reject malformed items returned by the
# cloud.

run "query_all_check_view_risks" {
  command = apply

  # --- identity of the read ---
  assert {
    condition     = data.tencentcloud_csip_check_view_risks.all.id != ""
    error_message = "data source id should be a non-empty random token, got: ${data.tencentcloud_csip_check_view_risks.all.id}"
  }

  # --- query inputs are kept in state ---
  assert {
    condition     = data.tencentcloud_csip_check_view_risks.all.order == "DESC" && data.tencentcloud_csip_check_view_risks.all.by == "RiskCount"
    error_message = "order / by should keep the configured sort options"
  }

  # --- every risk item returned by the cloud is well-formed ---
  assert {
    condition     = alltrue([for r in data.tencentcloud_csip_check_view_risks.all.check_view_risk_list : r.risk_rule_id != ""])
    error_message = "each check-view risk should carry a non-empty risk_rule_id"
  }

  assert {
    condition     = alltrue([for r in data.tencentcloud_csip_check_view_risks.all.check_view_risk_list : r.risk_title != "" && r.severity != ""])
    error_message = "each check-view risk should carry a non-empty risk_title and severity"
  }

  assert {
    condition     = alltrue([for r in data.tencentcloud_csip_check_view_risks.all.check_view_risk_list : r.risk_count >= 0 && r.asset_count >= 0])
    error_message = "each check-view risk should carry non-negative risk_count / asset_count"
  }

  assert {
    condition     = alltrue([for r in data.tencentcloud_csip_check_view_risks.all.check_view_risk_list : r.create_time != "" && r.update_time != ""])
    error_message = "each check-view risk should carry non-empty create_time / update_time"
  }

  assert {
    condition     = alltrue([for r in data.tencentcloud_csip_check_view_risks.all.check_view_risk_list : r.provider != ""])
    error_message = "each check-view risk should carry a non-empty provider (cloud vendor)"
  }

  # --- cspm standard terms nested list is well-formed ---
  assert {
    condition     = alltrue([for r in data.tencentcloud_csip_check_view_risks.all.check_view_risk_list : alltrue([for t in r.standard_terms : t.tag != ""])])
    error_message = "each cspm standard term of a risk should carry a non-empty tag"
  }

  # --- auxiliary lists returned by the cloud are well-formed ---
  assert {
    condition     = alltrue([for s in data.tencentcloud_csip_check_view_risks.all.standard_name_list : s.id >= 0 && s.name != ""])
    error_message = "each cspm standard of the check view should carry a non-negative id and a non-empty name"
  }

  assert {
    condition     = alltrue([for a in data.tencentcloud_csip_check_view_risks.all.asset_type_list : a.text != "" && a.value != ""])
    error_message = "each asset type entry should carry non-empty text / value"
  }

  assert {
    condition     = alltrue([for p in data.tencentcloud_csip_check_view_risks.all.provider_list : p.text != "" && p.value != ""])
    error_message = "each cloud provider entry should carry non-empty text / value"
  }
}

run "query_filtered_check_view_risks" {
  command = apply

  # --- identity of the read ---
  assert {
    condition     = data.tencentcloud_csip_check_view_risks.filtered.id != ""
    error_message = "filtered data source id should be a non-empty random token, got: ${data.tencentcloud_csip_check_view_risks.filtered.id}"
  }

  # --- the Status filter with exact match is sent and kept in state ---
  assert {
    condition     = data.tencentcloud_csip_check_view_risks.filtered.filters[0].name == "Status"
    error_message = "filters[0].name should be Status"
  }

  assert {
    condition     = data.tencentcloud_csip_check_view_risks.filtered.filters[0].values == tolist([var.status_filter_value])
    error_message = "filters[0].values should keep the configured status value ${var.status_filter_value}"
  }

  assert {
    condition     = data.tencentcloud_csip_check_view_risks.filtered.filters[0].exact_match == "1"
    error_message = "filters[0].exact_match should keep the configured exact match flag"
  }

  assert {
    condition     = data.tencentcloud_csip_check_view_risks.filtered.order == "ASC" && data.tencentcloud_csip_check_view_risks.filtered.by == "Severity"
    error_message = "filtered order / by should keep the configured sort options"
  }

  # --- every risk item returned by the filtered read is well-formed ---
  assert {
    condition     = alltrue([for r in data.tencentcloud_csip_check_view_risks.filtered.check_view_risk_list : r.risk_rule_id != "" && r.risk_title != ""])
    error_message = "each filtered check-view risk should carry non-empty risk_rule_id / risk_title"
  }

  assert {
    condition     = alltrue([for r in data.tencentcloud_csip_check_view_risks.filtered.check_view_risk_list : r.severity != "" && r.risk_count >= 0])
    error_message = "each filtered check-view risk should carry a non-empty severity and a non-negative risk_count"
  }
}
