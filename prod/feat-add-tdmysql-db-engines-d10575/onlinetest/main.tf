provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# Online test for the tencentcloud_tdmysql_db_engines data source
# (DescribeDBEngines, tdmysql v2021-11-22).
#
# DescribeDBEngines is a read-only query with no request parameters and no
# cloud-side side effects, so no resources are created or destroyed; the test
# only applies the data block and asserts against real cloud responses.
data "tencentcloud_tdmysql_db_engines" "all" {}
