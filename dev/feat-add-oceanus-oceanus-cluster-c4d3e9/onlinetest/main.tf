provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Online test for tencentcloud_oceanus_oceanus_cluster (oceanus v20190422,
# framework stack: CreateOceanusCluster -> ClusterId, DescribeClusters read
# back, ScaleOceanusCluster on cu change, DeleteOceanusCluster on destroy).
#
# Everything the cluster needs is created here (VPC + subnet + COS bucket), so
# the case is self-contained and fully destroyable: no pre-existing cloud
# resource is referenced, no deletion protection is touched.
# ==============================================================================

data "tencentcloud_user_info" "this" {}

locals {
  # Unique suffix keeps the cluster / bucket names from colliding with clusters
  # left in the account by other runs or by real users.
  suffix = formatdate("MMDDhhmm", timestamp())
  name   = "${var.cluster_name_prefix}-tfagentflow-${local.suffix}"
  # COS bucket names are "<custom name>-<APPID>", so the APPID comes from the
  # executing credential.
  bucket = "${var.cluster_name_prefix}-${local.suffix}-${data.tencentcloud_user_info.this.app_id}"
  # vpc_descriptions.owner_uin is the master account UIN, derivable from the
  # executing credential, hence the optional form field.
  owner_uin = coalesce(var.owner_uin, data.tencentcloud_user_info.this.owner_uin)
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
  # The cluster writes checkpoints / jar packages / logs into the bucket, so it
  # must be emptied before it can be destroyed at teardown.
  force_clean = true
}

resource "tencentcloud_oceanus_oceanus_cluster" "example" {
  cluster_name       = local.name
  region_id          = var.region_id
  zone_id            = var.zone_id
  login_password     = var.cluster_password
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
      owner_uin = local.owner_uin
    }
  ]

  depends_on = [tencentcloud_cos_bucket.example]
}
