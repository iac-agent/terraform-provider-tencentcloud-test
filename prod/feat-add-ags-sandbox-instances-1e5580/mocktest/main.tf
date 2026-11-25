provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# Query all sandbox instances (instance_ids not set).
data "tencentcloud_ags_sandbox_instances" "all" {}

# Query sandbox instances filtered by an explicit id list.
data "tencentcloud_ags_sandbox_instances" "filtered" {
  instance_ids = ["instance-mock0001", "instance-mock0002"]
}
