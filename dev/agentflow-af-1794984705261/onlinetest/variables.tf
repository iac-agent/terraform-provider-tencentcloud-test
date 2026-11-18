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
  description = "Name of the config aggregator (account group) to create and update. A unique suffix is appended automatically."
  type        = string
  default     = "tf-agentflow-aggregator"
}

variable "owner_uin" {
  description = "Creator UIN of the aggregator. Defaults to the UIN of the current credential's master account."
  type        = string
  default     = null
}
