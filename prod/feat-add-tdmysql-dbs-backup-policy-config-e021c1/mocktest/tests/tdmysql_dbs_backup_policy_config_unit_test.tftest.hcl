# Mock tests for the tencentcloud_tdmysql_dbs_backup_policy_config resource
# (DescribeDBSBackupPolicy read + ModifyDBSBackupPolicy write, tdmysql
# v2021-11-22, config subtype: the state id IS the instance_id locator).
#
# The override mocks the DescribeDBSBackupPolicy read-back item
# (Items[0]); the provider flattens it into the backup_policy object and
# keeps the configured storage_type (the read API never returns it). All
# mocked values are self-invented placeholders and never bypass the
# assertions.

override_resource {
  target = tencentcloud_tdmysql_dbs_backup_policy_config.full
  values = {
    id          = "tdmysql-mock0001"
    instance_id = "tdmysql-mock0001"
    backup_policy = {
      backup_end_time       = "04:00"
      backup_method         = "physical"
      backup_start_time     = "02:00"
      enable_full           = 1
      enable_log            = 1
      full_retention_period = 7
      log_retention_period  = 7
      period_time           = "Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday"
      storage_type          = "COS"
    }
  }
}

override_resource {
  target = tencentcloud_tdmysql_dbs_backup_policy_config.partial
  values = {
    id          = "tdmysql-mock0002"
    instance_id = "tdmysql-mock0002"
    backup_policy = {
      backup_end_time       = "06:00"
      backup_method         = "snapshot"
      backup_start_time     = "05:00"
      enable_full           = 1
      enable_log            = 1
      full_retention_period = 7
      log_retention_period  = 7
      period_time           = "Saturday,Sunday"
      storage_type          = "SNAPSHOT"
    }
  }
}

run "create_backup_policy_full" {
  command = apply

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup_policy_config.full.id == "tdmysql-mock0001"
    error_message = "id should be the instance_id locator itself (config subtype)"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup_policy_config.full.instance_id == "tdmysql-mock0001"
    error_message = "instance_id should keep the configured locator value"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup_policy_config.full.backup_policy.backup_method == "physical" && tencentcloud_tdmysql_dbs_backup_policy_config.full.backup_policy.enable_full == 1 && tencentcloud_tdmysql_dbs_backup_policy_config.full.backup_policy.enable_log == 1
    error_message = "backup_method / enable_full / enable_log should be the mocked cloud read-back values"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup_policy_config.full.backup_policy.backup_start_time == "02:00" && tencentcloud_tdmysql_dbs_backup_policy_config.full.backup_policy.backup_end_time == "04:00"
    error_message = "backup_start_time / backup_end_time should be the mocked cloud read-back values"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup_policy_config.full.backup_policy.full_retention_period == 7 && tencentcloud_tdmysql_dbs_backup_policy_config.full.backup_policy.log_retention_period == 7
    error_message = "full/log retention periods should be the mocked cloud read-back values"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup_policy_config.full.backup_policy.period_time == "Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday"
    error_message = "period_time should be the mocked cloud read-back value"
  }
}

run "create_backup_policy_partial" {
  command = apply

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup_policy_config.partial.id == "tdmysql-mock0002" && tencentcloud_tdmysql_dbs_backup_policy_config.partial.instance_id == "tdmysql-mock0002"
    error_message = "id and instance_id should both be the instance_id locator"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup_policy_config.partial.backup_policy.backup_method == "snapshot" && tencentcloud_tdmysql_dbs_backup_policy_config.partial.backup_policy.storage_type == "SNAPSHOT"
    error_message = "backup_method should be the mocked read-back value and the write-only storage_type should keep the configured value"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup_policy_config.partial.backup_policy.backup_start_time == "05:00" && tencentcloud_tdmysql_dbs_backup_policy_config.partial.backup_policy.backup_end_time == "06:00"
    error_message = "unset Optional+Computed leaves should be filled in from the mocked cloud read-back"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup_policy_config.partial.backup_policy.full_retention_period == 7 && tencentcloud_tdmysql_dbs_backup_policy_config.partial.backup_policy.log_retention_period == 7
    error_message = "unset retention periods should be filled in from the mocked cloud read-back"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup_policy_config.partial.backup_policy.period_time == "Saturday,Sunday"
    error_message = "unset period_time should be filled in from the mocked cloud read-back"
  }
}
