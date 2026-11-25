provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

# NOTE: the pinned mirror build 0.0.1-beta.feat.add.oceanus.oceanus.cluster was
# compiled before the resource was renamed, so the binary still registers the
# type name tencentcloud_oceanus_oceanus_cluster with the region_id/zone_id
# schema and vpc objects that carry app_id/owner_uin. The block below matches
# that binary.
resource "tencentcloud_oceanus_oceanus_cluster" "example" {
  cluster_name                     = "tf-oceanus-mock-cluster"
  region_id                        = 1
  zone_id                          = 100003
  login_password                   = "Password@123"
  default_cos_bucket               = "tf-oceanus-test-1308726196"
  cu                               = 12
  cu_memory                        = 4
  remark                           = "created by terraform mock test"
  period                           = 1
  instance_charge_type             = "PREPAID"
  cluster_type                     = "MULTI_AZ_CLUSTER"
  renew_flag                       = "NOTIFY_AND_MANUAL_RENEW"
  flink_web_ui_network_access_type = "NetworkAccess_EXTERNAL"

  vpc_descriptions = [
    {
      vpc_id    = "vpc-mock1234"
      subnet_id = "subnet-mock1234"
      app_id    = 1250000000
      owner_uin = "100000000000"
    },
  ]

  slave_vpc_descriptions = [
    {
      vpc_id    = "vpc-mock5678"
      subnet_id = "subnet-mock5678"
      app_id    = 1250000000
      owner_uin = "100000000000"
    },
  ]
}

import {
  to = tencentcloud_oceanus_oceanus_cluster.example
  id = "cluster-mock1234"
}
