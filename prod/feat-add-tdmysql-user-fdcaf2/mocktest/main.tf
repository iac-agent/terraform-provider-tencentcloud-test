provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# TDSQL-C for MySQL user without a description (only required attributes).
resource "tencentcloud_tdmysql_user" "plain" {
  instance_id = "tdsqlc-mock0001"
  user_name   = "tf_user"
  host        = "10.0.0.%"
  password    = "MockPassw0rd!"
}

# TDSQL-C for MySQL user with an explicit description.
resource "tencentcloud_tdmysql_user" "described" {
  instance_id = "tdsqlc-mock0002"
  user_name   = "tf_user_desc"
  host        = "192.168.1.10"
  password    = "MockPassw0rd!"
  description = "created by terraform mock test"
}
