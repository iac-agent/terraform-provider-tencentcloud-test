variable "region" {
  description = "Tencent Cloud region where the TDSQL Boundless (tdmysql) instance lives (e.g. ap-guangzhou)."
  type        = string
  default     = "ap-guangzhou"
}

variable "secret_id" {
  description = "Tencent Cloud secret id (injected at execution time; never committed)."
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "Tencent Cloud secret key (injected at execution time; never committed)."
  type        = string
  sensitive   = true
}

variable "instance_id" {
  description = "ID of an existing TDSQL Boundless instance whose DBS backup policy the online test modifies (e.g. tdsql-xxxxxx). The instance must be running and owned by the credentials used at execution time; the policy on it is overwritten by the test apply and must not hold values that need to be preserved."
  type        = string
}

variable "backup_method" {
  description = "Backup method written by the online test: `physical` (physical backup) or `snapshot` (snapshot backup)."
  type        = string
  default     = "physical"
}

variable "backup_start_time" {
  description = "Backup start time written by the online test, format HH:MM (e.g. 02:00)."
  type        = string
  default     = "02:00"
}

variable "backup_end_time" {
  description = "Backup end time written by the online test, format HH:MM (e.g. 04:00)."
  type        = string
  default     = "04:00"
}

variable "enable_full" {
  description = "Whether to enable full backup: 1 (enabled, also the value asserted after the read-back) or 0."
  type        = number
  default     = 1
}

variable "enable_log" {
  description = "Whether to enable log backup: 1 (enabled, also the value asserted after the read-back) or 0."
  type        = number
  default     = 1
}

variable "full_retention_period" {
  description = "Full backup retention period in days. Currently can only be set to 7."
  type        = number
  default     = 7
}

variable "log_retention_period" {
  description = "Log backup retention period in days. Currently can only be set to 7."
  type        = number
  default     = 7
}

variable "period_time" {
  description = "Days of the week to perform backup, comma-separated English day names, e.g. `Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday`."
  type        = string
  default     = "Monday,Tuesday,Wednesday,Thursday,Friday,Saturday,Sunday"
}

variable "storage_type" {
  description = "Storage type of the backup: `COS` or `SNAPSHOT`. This is a write-only attribute — DescribeDBSBackupPolicy never returns it, so the value cannot be asserted from the read-back."
  type        = string
  default     = "COS"
}
