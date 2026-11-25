variable "region" {
  description = "Tencent Cloud region used for the CSIP query (CSIP data is queried through the regional endpoint of the executing account)."
  type        = string
  default     = "ap-guangzhou"
}

variable "secret_id" {
  description = "Tencent Cloud secret id (injected at execution time; never committed)."
  type        = string
  default     = null
  sensitive   = true
}

variable "secret_key" {
  description = "Tencent Cloud secret key (injected at execution time; never committed)."
  type        = string
  default     = null
  sensitive   = true
}

variable "status_filter_value" {
  description = "Value of the `Status` filter (execution result of the check items): `SUCCESS`, `FAILED`, `USER_CANCELED` or `CHECKING`. Used by the filtered query of the online test."
  type        = string
}
