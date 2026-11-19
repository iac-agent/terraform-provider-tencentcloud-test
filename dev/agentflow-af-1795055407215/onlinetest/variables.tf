variable "region" {
  description = "Tencent Cloud region."
  type        = string
  default     = "ap-guangzhou"
}

variable "secret_id" {
  description = "Tencent Cloud secret id (injected at execution time)."
  type        = string
}

variable "secret_key" {
  description = "Tencent Cloud secret key (injected at execution time)."
  type        = string
  sensitive   = true
}

variable "account_group_id" {
  description = "ID of the existing Config account group (aggregator) the rule belongs to, e.g. agr-xxxx."
  type        = string
}

variable "rule_name_prefix" {
  description = "Prefix of the aggregate config rule name created by this test."
  type        = string
  default     = "tf-agentflow-aggregate-rule"
}

variable "identifier" {
  description = "System preset rule template identifier, e.g. cam-user-group-bound."
  type        = string
  default     = "cam-user-group-bound"
}

variable "resource_type" {
  description = "Resource type list the rule applies to, e.g. [\"QCS::CAM::User\"]."
  type        = list(string)
  default     = ["QCS::CAM::User"]
}

variable "risk_level" {
  description = "Rule risk level: 1 (high), 2 (medium), 3 (low)."
  type        = number
  default     = 3
}
