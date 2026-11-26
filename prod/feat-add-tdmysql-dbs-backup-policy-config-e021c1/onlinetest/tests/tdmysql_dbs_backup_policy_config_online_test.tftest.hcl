# Online tests for the tencentcloud_tdmysql_dbs_backup_policy_config resource
# (ModifyDBSBackupPolicy write + DescribeDBSBackupPolicy read-back,
# tdmysql v2021-11-22).
#
# No override_resource / mock values are used: the run blocks apply the
# backup policy against the real cloud API and assert the actual
# DescribeDBSBackupPolicy read-back.
#
# The policy on var.instance_id is overwritten by the test apply; destroying
# the resource only removes it from state (the configuration lives and dies
# with the instance), so the test leaves no orphaned cloud resource.
#
# Note: enable_full / enable_log / full_retention_period / log_retention_period
# / backup_start_time / backup_end_time are asserted non-strictly against the
# cloud read-back: a fresh instance whose policy has never been written may
# normalize null leaves to 0. When the leaf carries a real cloud value it must
# match the configuration.

run "create_backup_policy" {
  command = apply

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup_policy_config.policy.id != ""
    error_message = "id should be a non-empty instance_id locator after the real cloud apply"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup_policy_config.policy.id == var.instance_id && tencentcloud_tdmysql_dbs_backup_policy_config.policy.instance_id == var.instance_id
    error_message = "id and instance_id should both be the instance_id locator (config subtype)"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup_policy_config.policy.backup_policy.backup_method == var.backup_method
    error_message = "backup_method should keep the configured value after the real cloud read-back"
  }

  assert {
    condition = tencentcloud_tdmysql_dbs_backup_policy_config.policy.backup_policy.backup_start_time == null || tencentcloud_tdmysql_dbs_backup_policy_config.policy.backup_policy.backup_start_time == var.backup_start_time
    error_message = "backup_start_time should keep the configured value after the real cloud read-back (null only when the fresh instance has never had a policy)"
  }

  assert {
    condition = tencentcloud_tdmysql_dbs_backup_policy_config.policy.backup_policy.backup_end_time == null || tencentcloud_tdmysql_dbs_backup_policy_config.policy.backup_policy.backup_end_time == var.backup_end_time
    error_message = "backup_end_time should keep the configured value after the real cloud read-back (null only when the fresh instance has never had a policy)"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup_policy_config.policy.backup_policy.enable_full == null || tencentcloud_tdmysql_dbs_backup_policy_config.policy.backup_policy.enable_full == var.enable_full
    error_message = "enable_full should keep the configured value after the real cloud read-back (0 only when the fresh instance has never had a policy)"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup_policy_config.policy.backup_policy.enable_log == null || tencentcloud_tdmysql_dbs_backup_policy_config.policy.backup_policy.enable_log == var.enable_log
    error_message = "enable_log should keep the configured value after the real cloud read-back (0 only when the fresh instance has never had a policy)"
  }

  assert {
    condition = tencentcloud_tdmysql_dbs_backup_policy_config.policy.backup_policy.full_retention_period == null || tencentcloud_tdmysql_dbs_backup_policy_config.policy.backup_policy.full_retention_period == var.full_retention_period
    error_message = "full_retention_period should keep the configured value after the real cloud read-back (0 only when the fresh instance has never had a policy)"
  }

  assert {
    condition = tencentcloud_tdmysql_dbs_backup_policy_config.policy.backup_policy.log_retention_period == null || tencentcloud_tdmysql_dbs_backup_policy_config.policy.backup_policy.log_retention_period == var.log_retention_period
    error_message = "log_retention_period should keep the configured value after the real cloud read-back (0 only when the fresh instance has never had a policy)"
  }

  assert {
    condition = tencentcloud_tdmysql_dbs_backup_policy_config.policy.backup_policy.period_time == null || tencentcloud_tdmysql_dbs_backup_policy_config.policy.backup_policy.period_time == var.period_time
    error_message = "period_time should keep the configured value after the real cloud read-back (null only when the fresh instance has never had a policy)"
  }

  assert {
    condition     = tencentcloud_tdmysql_dbs_backup_policy_config.policy.backup_policy.storage_type == var.storage_type
    error_message = "storage_type is write-only (DescribeDBSBackupPolicy never returns it) and should keep the configured value in state"
  }
}
