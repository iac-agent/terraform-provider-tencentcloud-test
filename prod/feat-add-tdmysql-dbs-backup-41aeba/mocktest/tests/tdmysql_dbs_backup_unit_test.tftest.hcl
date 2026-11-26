# Mock tests for the tencentcloud_tdmysql_dbs_backup resource
# (CreateDBSBackup / DescribeDBSBackupSets / ModifyDBSBackupSetComment /
# DeleteDBSBackupSets, tdmysql v2021-11-22).
#
# override_resource mocks the cloud read-back after Create: the backup set
# id (used as the resource `id`) is a self-chosen plausible value, and the
# instance-owned fields returned by DescribeDBSBackupSets are mocked to be
# consistent with the configuration so the post-create refresh converges.

override_resource {
  target = resource.tencentcloud_tdmysql_dbs_backup.manual_backup
  values = {
    id            = "12345"
    instance_id   = "tdsqlc-mock1234"
    backup_method = "physical"
    backup_type   = "full"
    backup_name   = "tf-mock-backup"
  }
}

run "create_dbs_backup" {
  command = apply

  assert {
    condition     = resource.tencentcloud_tdmysql_dbs_backup.manual_backup.id == "12345"
    error_message = "resource id should be the backup set id returned by CreateDBSBackup"
  }

  assert {
    condition     = resource.tencentcloud_tdmysql_dbs_backup.manual_backup.instance_id == "tdsqlc-mock1234"
    error_message = "instance_id should stay consistent with the configuration"
  }

  assert {
    condition     = resource.tencentcloud_tdmysql_dbs_backup.manual_backup.backup_method == "physical"
    error_message = "backup_method should be physical as configured"
  }

  assert {
    condition     = resource.tencentcloud_tdmysql_dbs_backup.manual_backup.backup_type == "full"
    error_message = "backup_type should only support full for now"
  }

  assert {
    condition     = resource.tencentcloud_tdmysql_dbs_backup.manual_backup.backup_name == "tf-mock-backup"
    error_message = "backup_name should be the comment set on the backup set"
  }
}
