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
  description = "ID of an existing running TDSQL Boundless (tdmysql) instance the online test creates manual backup sets on (e.g. tdsqlc-xxxxxx). The instance must be running and reachable with the credentials used at execution time."
  type        = string
}

variable "backup_name_prefix" {
  description = "Prefix for the backup comments set by the online test. Final backup names are '<prefix>_initial' and '<prefix>_renamed' (e.g. tfagentflow gives tfagentflow_initial / tfagentflow_renamed)."
  type        = string
  default     = "tfagentflow"
}

variable "backup_name_renamed" {
  description = "New backup comment applied by the update run through ModifyDBSBackupSetComment."
  type        = string
  default     = "tfagentflow_renamed"
}
