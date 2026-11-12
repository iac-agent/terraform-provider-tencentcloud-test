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
