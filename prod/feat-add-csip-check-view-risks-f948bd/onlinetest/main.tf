provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# Read-only online test for the tencentcloud_csip_check_view_risks data source
# (DescribeCheckViewRisks, CSIP 2022-11-21). Both blocks only query the real
# cloud — nothing is created, so `terraform test` leaves no residue behind.
#
# The first block queries every check-view risk of the executing account with
# a deterministic sort; the second one exercises the `Status` filter and the
# exact-match flag with a value provided at execution time.

data "tencentcloud_csip_check_view_risks" "all" {
  order = "DESC"
  by    = "RiskCount"
}

data "tencentcloud_csip_check_view_risks" "filtered" {
  filters = [
    {
      name        = "Status"
      values      = [var.status_filter_value]
      exact_match = "1"
    },
  ]

  order = "ASC"
  by    = "Severity"
}
