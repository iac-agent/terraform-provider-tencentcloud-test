provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Online test for tencentcloud_oceanus_cluster_af (oceanus v20190422, framework
# stack: CreateOceanusCluster / DescribeClusters / ScaleOceanusCluster /
# DeleteOceanusCluster).
#
# Everything the cluster needs is created here (VPC + subnet + COS bucket) so the
# case is fully self-contained and fully destroyable. No pre-existing cloud
# resource is referenced.
# ==============================================================================

data "tencentcloud_user_info" "this" {}

locals {
  # Unique suffix keeps the cluster / bucket names from colliding with clusters
  # left in the account by other runs or by real users.
  suffix  = formatdate("MMDDhhmm", timestamp())
  tag     = "tfagentflow"
  name    = "${var.cluster_name_prefix}-${local.tag}-${local.suffix}"
  # COS bucket names must be "<custom name>-<APPID>".
  bucket  = "${var.cluster_name_prefix}-${local.suffix}-${data.tencentcloud_user_info.this.app_id}"
}

resource "tencentcloud_vpc" "example" {
  name       = "${local.name}-vpc"
  cidr_block = var.vpc_cidr
}

resource "tencentcloud_subnet" "example" {
  vpc_id            = tencentcloud_vpc.example.id
  name              = "${local.name}-subnet"
  availability_zone = var.zone
  cidr_block        = var.subnet_cidr
}

resource "tencentcloud_cos_bucket" "example" {
  bucket = local.bucket
  acl    = "private"
  # The cluster writes checkpoints / jars / logs into the bucket, so the bucket
  # must be emptied before it can be destroyed at teardown.
  force_clean = true
}

resource "tencentcloud_oceanus_cluster_af" "example" {
  cluster_name       = local.name
  region_id          = var.region_id
  zone_id            = var.zone_id
  login_password     = var.login_password
  default_cos_bucket = local.bucket
  cu                 = var.cu
  remark             = local.name
  # Pay-as-you-go keeps the case cheap and destroyable.
  instance_charge_type = "POSTPAID_BY_SECOND"
  # Intranet-only Flink UI: no public endpoint is opened for the test cluster.
  flink_web_ui_network_access_type = "NetworkAccess_INTERNAL"

  vpc_descriptions = [
    {
      vpc_id    = tencentcloud_vpc.example.id
      subnet_id = tencentcloud_subnet.example.id
    }
  ]

  timeouts {
    create = var.create_timeout
  }

  depends_on = [tencentcloud_cos_bucket.example]
}
