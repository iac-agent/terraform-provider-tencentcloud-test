variable "region" {
  description = "Tencent Cloud region where the TDSQL-C for MySQL instance lives (e.g. ap-guangzhou)."
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
  description = "ID of an existing TDSQL-C for MySQL instance the online test creates users on (e.g. tdsqlc-xxxxxx). The instance must be running and reachable with the credentials used at execution time."
  type        = string
}

variable "user_name_prefix" {
  description = "Prefix for the user names created by the online test. Final user names are '<prefix>_plain' and '<prefix>_desc' (e.g. tfagentflow gives tfagentflow_plain / tfagentflow_desc)."
  type        = string
  default     = "tfagentflow"
}

variable "user_password" {
  description = "Password for the users created by the online test. Must satisfy the instance password complexity policy (length, upper/lower case, digits and special characters)."
  type        = string
  default     = "TfAgentflow0rd!"
  sensitive   = true
}

variable "user_description" {
  description = "Description set on the second user (tencentcloud_tdmysql_user.described) and asserted after the read-back."
  type        = string
  default     = "created by terraform online test"
}
