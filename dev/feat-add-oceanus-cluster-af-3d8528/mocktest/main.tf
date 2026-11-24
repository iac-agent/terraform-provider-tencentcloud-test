provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource block for the resource under test (tencentcloud_oceanus_cluster_af,
# oceanus v20190422: CreateOceanusCluster / DescribeClusters / ScaleOceanusCluster /
# DeleteOceanusCluster). Do not remove or modify the provider block above.
# ==============================================================================

resource "tencentcloud_oceanus_cluster_af" "example" {
  cluster_name       = "tf-mock-cluster"
  region_id          = 1
  zone_id            = 100001
  login_password     = "tf-mock-password"
  default_cos_bucket = "tf-mock-bucket"
  cu                 = 12
  remark             = "created by terraform"

  instance_charge_type = "POSTPAID_BY_SECOND"
  cluster_type         = "MULTI_AZ_CLUSTER"

  vpc_descriptions = [
    {
      vpc_id    = "vpc-1234abcd"
      subnet_id = "subnet-1234abcd"
    }
  ]

  timeouts {
    create = "15m"
    update = "15m"
    delete = "15m"
  }
}
