provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# Query the sellable component specs of TDSQL Boundless without any filter:
# DescribeSpecs is called with no request field set and must return the full
# sellable spec catalog of the region. This data source is read-only — it
# creates nothing on the cloud, so `terraform test` leaves no residue.
data "tencentcloud_tdmysql_specs" "all" {}

# Query the sellable component specs with all documented filter inputs set:
# the availability zone combination, the all-round node replica number and
# the exclusive instance flag. The filters are echoed into state unchanged
# and the cloud must still return spec lists for the filtered view.
data "tencentcloud_tdmysql_specs" "filtered" {
  zones                 = var.zones
  full_replications     = var.full_replications
  is_exclusive_instance = var.is_exclusive_instance
}
