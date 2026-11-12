variable "region" {
  description = "Tencent Cloud region, e.g. ap-guangzhou."
  type        = string
  default     = "ap-guangzhou"
}

variable "secret_id" {
  description = "Tencent Cloud secret id (provided at execution time, never committed)."
  type        = string
}

variable "secret_key" {
  description = "Tencent Cloud secret key (provided at execution time, never committed)."
  type        = string
  sensitive   = true
}

variable "rule_identifier" {
  description = "Identifier of the system preset rule to query in detail, e.g. cam-user-mfa-enabled. Use ListSystemRules data source to discover valid identifiers."
  type        = string
}
