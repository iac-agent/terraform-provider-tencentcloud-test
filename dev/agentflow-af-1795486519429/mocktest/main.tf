provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

resource "tencentcloud_oceanus_oceanus_cluster" "example" {
  cluster_name       = "tf_mock_cluster"
  region_id          = 1
  zone_id            = 100003
  login_password     = "Password@123"
  default_cos_bucket = "tf-mock-bucket-1250000000"
  cu                 = 12
  remark             = "created by terraform mock test"

  vpc_descriptions {
    vpc_id    = "vpc-mock1234"
    subnet_id = "subnet-mock1234"
  }

  instance_charge_type             = "POSTPAID_BY_SECOND"
  flink_web_ui_network_access_type = "NetworkAccess_EXTERNAL"
  cu_memory                        = 2
}
