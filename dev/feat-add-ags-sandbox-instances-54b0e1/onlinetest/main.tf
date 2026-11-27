provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# Query all sandbox instances under the current account (no filter).
data "tencentcloud_ags_sandbox_instances" "all" {}

# Query sandbox instances filtered by an explicit instance id list.
# An empty list is sent as no filter by the API, so it stays valid even when
# the caller does not provide any instance ids.
data "tencentcloud_ags_sandbox_instances" "filtered" {
  instance_ids = var.instance_ids
}
