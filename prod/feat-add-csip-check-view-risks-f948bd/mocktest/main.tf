provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

data "tencentcloud_csip_check_view_risks" "all" {
  order = "DESC"
  by    = "RiskCount"
}

data "tencentcloud_csip_check_view_risks" "filtered" {
  member_id = ["mem-10000001"]

  filters = [
    {
      name        = "Status"
      values      = ["SUCCESS"]
      exact_match = "1"
    }
  ]

  order = "ASC"
  by    = "Severity"
}
