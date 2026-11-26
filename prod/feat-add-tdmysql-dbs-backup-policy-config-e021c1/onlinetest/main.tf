provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# Online test for the tencentcloud_tdmysql_dbs_backup_policy_config resource
# (ModifyDBSBackupPolicy write + DescribeDBSBackupPolicy read-back,
# tdmysql v2021-11-22).
#
# The resource is a config subtype hanging off an existing TDSQL Boundless
# instance: the state id IS the instance_id locator. Writing the policy is a
# synchronous ModifyDBSBackupPolicy call followed by a DescribeDBSBackupPolicy
# read-back, so every leaf of backup_policy carries the cloud-reported value
# in state. Destroying this resource only removes it from Terraform state —
# the cloud-side configuration lives and dies with the instance, so no cloud
# resource is created or left behind by the test.
#
# storage_type is asserted against the configured value (it is write-only and
# never refreshed from the cloud); all other leaves are asserted against the
# real cloud read-back.

resource "tencentcloud_tdmysql_dbs_backup_policy_config" "policy" {
  instance_id = var.instance_id

  backup_policy = {
    backup_method         = var.backup_method
    backup_start_time     = var.backup_start_time
    backup_end_time       = var.backup_end_time
    enable_full           = var.enable_full
    enable_log            = var.enable_log
    full_retention_period = var.full_retention_period
    log_retention_period  = var.log_retention_period
    period_time           = var.period_time
    storage_type          = var.storage_type
  }
}
