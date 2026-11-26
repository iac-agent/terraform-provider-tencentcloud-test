# Online tests for the tencentcloud_tdmysql_dbs_backup resource
# (CreateDBSBackup / DescribeDBSBackupSets / ModifyDBSBackupSetComment /
# DeleteDBSBackupSets, tdmysql v2021-11-22).
#
# No override_resource / mock values are used: the run blocks apply the two
# manual backup sets against the real cloud API and assert the actual
# DescribeDBSBackupSets read-back. Both backup sets are created on the
# instance given by var.instance_id and deleted again at the end of the test
# through DeleteDBSBackupSets, so nothing remains on the instance.

run "create_dbs_backup_with_name" {
  command = apply

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup.manual.id != "" && can(tonumber(tencentcloud_tdmysql_dbs_backup.manual.id))
    error_message = "id should be a non-empty numeric backup set id returned by CreateDBSBackup"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup.manual.instance_id == var.instance_id
    error_message = "instance_id should keep the configured instance the backup set belongs to"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup.manual.backup_method == "physical"
    error_message = "backup_method should be physical as configured after the real cloud read-back"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup.manual.backup_type == "full"
    error_message = "backup_type should only support full for now"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup.manual.backup_name == "${var.backup_name_prefix}_initial"
    error_message = "backup_name should be the comment read back from the real backup set"
  }
}

run "create_dbs_backup_without_name" {
  command = apply

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup.no_name.id != "" && can(tonumber(tencentcloud_tdmysql_dbs_backup.no_name.id))
    error_message = "id should be a non-empty numeric backup set id returned by CreateDBSBackup"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup.no_name.instance_id == var.instance_id
    error_message = "instance_id should keep the configured instance the backup set belongs to"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup.no_name.backup_method == "physical"
    error_message = "backup_method should be physical as configured after the real cloud read-back"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup.no_name.backup_type == "full"
    error_message = "backup_type should only support full for now"
  }
}

run "update_backup_name" {
  command = apply

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup.manual.backup_name == var.backup_name_renamed
    error_message = "backup_name should be the new comment applied through ModifyDBSBackupSetComment and read back from the real cloud"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup.manual.id != "" && can(tonumber(tencentcloud_tdmysql_dbs_backup.manual.id))
    error_message = "renaming the comment must not replace the backup set, so the id stays the same backup set id"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup.no_name.backup_name == null
    error_message = "backup_name should stay null when it is not configured and never updated"
  }
}
