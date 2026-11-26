provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# Query TDSQL-C for MySQL sale info (DescribeSaleInfo) without any filter:
# returns the sale region/zone list of all regions.
data "tencentcloud_tdmysql_sale_info" "all" {}

# Query with the optional instance_type filter (only 'serverless' is
# currently supported). An empty value is sent as no filter, so the run
# stays valid even when the caller leaves it unset.
data "tencentcloud_tdmysql_sale_info" "by_type" {
  instance_type = var.instance_type
}

# Query with the optional src_region / instance_id filters. Both are sent
# only when non-empty, so unset values keep the run valid.
data "tencentcloud_tdmysql_sale_info" "by_filters" {
  src_region  = var.src_region
  instance_id = var.instance_id
}
