provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# Query the sellable component specs without any filter.
data "tencentcloud_tdmysql_specs" "all" {}

# Query the sellable component specs filtered by an availability zone
# combination, the all-round node replica number and an exclusive instance.
data "tencentcloud_tdmysql_specs" "filtered" {
  zones                  = ["ap-guangzhou-1", "ap-guangzhou-2"]
  full_replications      = 3
  is_exclusive_instance  = 0
  instance_id            = "tdsqlmock-abcdef"
}
