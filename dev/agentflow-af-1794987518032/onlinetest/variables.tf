variable "region" {
  description = "Tencent Cloud region (placeholder; mock tests do not call the cloud API)."
  type        = string
  default     = "ap-guangzhou"
}

variable "secret_id" {
  description = "Tencent Cloud secret id (placeholder; mock tests do not call the cloud API)."
  type        = string
  default     = "tf-test-placeholder"
}

variable "secret_key" {
  description = "Tencent Cloud secret key (placeholder; mock tests do not call the cloud API)."
  type        = string
  default     = "tf-test-placeholder"
  sensitive   = true
}

variable "aggregator_name" {
  description = "Base name of the config aggregator (account group). A unique suffix is appended automatically."
  type        = string
  default     = "tf-agentflow-aggregator"
}

variable "aggregator_description" {
  description = "Description of the config aggregator at creation time."
  type        = string
  default     = "Online test aggregator for agentflow af-1794987518032 (UpdateAggregator)"
}

variable "owner_uin" {
  description = "Creator UIN of the aggregator. Defaults to the UIN of the current credential's master account."
  type        = string
  default     = null
}
