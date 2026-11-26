provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# TDSQL Boundless DBS backup policy configuration on an instance. Create and
# update both call ModifyDBSBackupPolicy; read calls DescribeDBSBackupPolicy.
resource "tencentcloud_tdmysql_dbs_backup_policy_config" "full" {
  instance_id = "tdmysql-mock0001"

  backup_policy = {
    backup_method         = "physical"
    backup_start_time     = "02:00"
    backup_end_time       = "04:00"
    enable_full           = 1
    enable_log            = 1
    full_retention_period = 7
    log_retention_period  = 7
    period_time           = "Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday"
    storage_type          = "COS"
  }
}

# Backup policy with only a subset of the leaves configured; the rest are
# Optional+Computed and filled in from the mocked cloud read-back.
resource "tencentcloud_tdmysql_dbs_backup_policy_config" "partial" {
  instance_id = "tdmysql-mock0002"

  backup_policy = {
    backup_method = "snapshot"
    enable_full   = 1
    enable_log    = 1
    storage_type  = "SNAPSHOT"
  }
}
