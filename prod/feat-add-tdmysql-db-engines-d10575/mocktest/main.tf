provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# Query the list of TDSQL Boundless (tdmysql) DB engine versions.
# DescribeDBEngines has no request parameters, so a single data block is enough.
data "tencentcloud_tdmysql_db_engines" "all" {}
