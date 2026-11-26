provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# Query the sale info of all regions (no filters).
data "tencentcloud_tdmysql_sale_info" "all" {}

# Query only regions supporting serverless instances.
data "tencentcloud_tdmysql_sale_info" "serverless" {
  instance_type = "serverless"
}

# Query the sale info of the region/zones where a given instance is located,
# from the perspective of a disaster recovery primary region.
data "tencentcloud_tdmysql_sale_info" "by_instance" {
  instance_id = "tdsqlc-mock0001"
  src_region  = "ap-guangzhou"
}
