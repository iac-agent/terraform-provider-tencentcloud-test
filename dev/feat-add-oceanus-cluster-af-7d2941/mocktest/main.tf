provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource block for the resource under test (tencentcloud_oceanus_cluster_af,
# oceanus CreateOceanusCluster/DescribeClusters/ScaleOceanusCluster/
# DeleteOceanusCluster, oceanus v20190422). Do not remove or modify the
# provider block above.
# ==============================================================================

resource "tencentcloud_oceanus_cluster_af" "example" {
  cluster_name        = "tf-mock-oceanus-cluster"
  region_id           = 1
  zone_id             = 100001
  login_password      = "MockPassword123"
  default_cos_bucket  = "tf-mock-oceanus-1250000000"
  cu                  = 12
  remark              = "tf mock cluster"
  instance_charge_type = "POSTPAID_BY_SECOND"
  flink_web_ui_network_access_type = "NetworkAccess_EXTERNAL"

  vpc_descriptions = [
    {
      vpc_id    = "vpc-mock1234"
      subnet_id = "subnet-mock1234"
    }
  ]

  timeouts {
    create = "10m"
  }
}
