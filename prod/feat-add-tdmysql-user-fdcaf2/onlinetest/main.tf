provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# Online test for the tencentcloud_tdmysql_user resource
# (CreateUsers / DescribeUsers / DeleteUsers, tdmysql v2021-11-22).
#
# Two users are created on the instance given by var.instance_id:
#   - .plain   only the required attributes (password, no description)
#   - .described  password + an explicit description
#
# Each resource maps to one real cloud user; terraform test destroys both at
# the end of the run, so no user remains on the instance. Hosts use an IP
# range ending with %, which does not collide with the cloud root account.
# User names carry the var.user_name_prefix to avoid clashing with any
# existing users on the instance.

locals {
  user_plain  = "${var.user_name_prefix}_plain"
  user_desc   = "${var.user_name_prefix}_desc"
  host        = "10.168.0.%"
}

resource "tencentcloud_tdmysql_user" "plain" {
  instance_id = var.instance_id
  user_name   = local.user_plain
  host        = local.host
  password    = var.user_password
}

resource "tencentcloud_tdmysql_user" "described" {
  instance_id = var.instance_id
  user_name   = local.user_desc
  host        = local.host
  password    = var.user_password
  description = var.user_description
}
