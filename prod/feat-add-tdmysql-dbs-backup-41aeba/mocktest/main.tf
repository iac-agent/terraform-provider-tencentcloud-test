provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# Create a manual backup set (DBS backup) for a TDSQL Boundless (tdmysql)
# instance via CreateDBSBackup, read back through DescribeDBSBackupSets,
# with backup_name covered by ModifyDBSBackupSetComment and deletion by
# DeleteDBSBackupSets. All cloud responses are mocked via override_resource.
resource "tencentcloud_tdmysql_dbs_backup" "manual_backup" {
  instance_id   = "tdsqlc-mock1234"
  backup_method = "physical"
  backup_type   = "full"
  backup_name   = "tf-mock-backup"
}
