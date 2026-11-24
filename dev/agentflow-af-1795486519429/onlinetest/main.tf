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
  cluster_name       = var.cluster_name
  region_id          = var.region_id
  zone_id            = var.zone_id
  login_password     = var.login_password
  default_cos_bucket = var.default_cos_bucket
  cu                 = var.cu
  cu_memory          = var.cu_memory

  vpc_descriptions = [
    {
      vpc_id    = var.vpc_id
      subnet_id = var.subnet_id
    },
  ]

  instance_charge_type = var.instance_charge_type
}

data "tencentcloud_oceanus_clusters" "created" {
  cluster_ids = [tencentcloud_oceanus_oceanus_cluster.example.id]
}
