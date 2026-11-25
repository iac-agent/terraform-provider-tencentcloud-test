provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource block for the resource under test:
# tencentcloud_oceanus_oceanus_cluster (oceanus v20190422, framework stack,
# CreateOceanusCluster / DescribeClusters / ScaleOceanusCluster /
# DeleteOceanusCluster). Do not remove or modify the provider block above.
# ==============================================================================

resource "tencentcloud_oceanus_oceanus_cluster" "example" {
  cluster_name                     = "tf_mock_oceanus_cluster"
  region_id                        = 1
  zone_id                          = 100003
  login_password                   = "MockPassw0rd!"
  default_cos_bucket               = "tf-mock-bucket-1250000000"
  cu                               = 12
  remark                           = "created by terraform mock test"
  instance_charge_type             = "POSTPAID_BY_SECOND"
  flink_web_ui_network_access_type = "NetworkAccess_EXTERNAL"
  cu_memory                        = 2

  vpc_descriptions = [
    {
      vpc_id    = "vpc-mock1234"
      subnet_id = "subnet-mock1234"
      app_id    = 1250000000
      owner_uin = "100000000000"
    },
  ]
}
