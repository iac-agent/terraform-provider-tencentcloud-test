provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# Global privileges scope: db_name = "*" maps to GlobalPrivileges (*.*).
resource "tencentcloud_tdmysql_user_privilege" "global" {
  instance_id = "tdsql3-mock0001"
  host        = "10.0.0.%"
  user_name   = "tf_user"
  db_name     = "*"
  privileges  = ["SELECT", "INSERT"]
}

# Database-level privileges scope: db_name is concrete and object_type = "*"
# maps to DatabasePrivileges (db.*).
resource "tencentcloud_tdmysql_user_privilege" "database" {
  instance_id = "tdsql3-mock0001"
  host        = "10.0.0.%"
  user_name   = "tf_user"
  db_name     = "tf_db"
  object_type = "*"
  privileges  = ["SELECT", "UPDATE", "DELETE"]
}

# Table-level privileges scope: db_name + object_type = "table" + object
# map to TablePrivileges (db.table).
resource "tencentcloud_tdmysql_user_privilege" "table" {
  instance_id = "tdsql3-mock0002"
  host        = "192.168.1.10"
  user_name   = "tf_table_user"
  db_name     = "tf_db"
  object_type = "table"
  object      = "tf_table"
  privileges  = ["SELECT", "INSERT"]
}
