variable "region" {
  description = "Tencent Cloud region used to query the TDSQL Boundless (tdmysql) sellable specs, e.g. `ap-guangzhou`."
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

variable "zones" {
  description = "Availability zone combination used to filter the sellable specs, e.g. [\"ap-guangzhou-1\", \"ap-guangzhou-2\"]. Each entry must be a valid zone of the selected region."
  type        = list(string)
}

variable "full_replications" {
  description = "Number of replicas of the all-round (hybrid) node used to filter the sellable specs, currently supported range: 1-3, default is 3 on the cloud side."
  type        = number
}

variable "is_exclusive_instance" {
  description = "Whether to query specs for exclusive instances only: `1` for exclusive, `0` for shared."
  type        = number
}
