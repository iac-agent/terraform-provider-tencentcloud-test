variable "region" {
  description = "Tencent Cloud region."
  type        = string
  default     = "ap-guangzhou"
}

variable "secret_id" {
  description = "Tencent Cloud secret id (injected at execution time, never stored in the repo)."
  type        = string
}

variable "secret_key" {
  description = "Tencent Cloud secret key (injected at execution time, never stored in the repo)."
  type        = string
  sensitive   = true
}

variable "owner_uin" {
  description = "Creator UIN of the account group aggregator, e.g. 100012345678. Needed because the aggregator resource requires it for Describe/Update/Delete."
  type        = string
}

variable "rule_name_prefix" {
  description = "Unique rule/aggregator name prefix used to avoid clashing with existing cloud resources, e.g. tf-agentflow."
  type        = string
}
