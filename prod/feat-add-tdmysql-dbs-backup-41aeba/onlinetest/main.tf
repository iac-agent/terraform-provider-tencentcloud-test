provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# Online test for the tencentcloud_tdmysql_dbs_backup resource
# (CreateDBSBackup / DescribeDBSBackupSets / ModifyDBSBackupSetComment /
# DeleteDBSBackupSets, tdmysql v2021-11-22).
#
# Manual backup sets are created on the instance given by var.instance_id:
#   - .manual  backup_name covers ModifyDBSBackupSetComment in the update run
#   - .no_name only the required attributes, keeping backup_name null
#
# Each resource maps to one real cloud backup set; terraform test destroys
# both at the end of the run, so no backup set remains on the instance.
# Backup names carry the var.backup_name_prefix to avoid clashing with any
# existing backups on the instance.

resource "tencentcloud_tdmysql_dbs_backup" "manual" {
  instance_id   = var.instance_id
  backup_method = "physical"
  backup_type   = "full"
  backup_name   = "${var.backup_name_prefix}_initial"
}

resource "tencentcloud_tdmysql_dbs_backup" "no_name" {
  instance_id   = var.instance_id
  backup_method = "physical"
  backup_type   = "full"
}
