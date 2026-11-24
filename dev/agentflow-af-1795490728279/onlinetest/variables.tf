variable "region" {
  description = "Tencent Cloud region for the TEO zone (e.g. ap-guangzhou)."
  type        = string
  default     = "ap-guangzhou"
}

variable "secret_id" {
  description = "Tencent Cloud secret id (injected at execution time; never stored in the repo)."
  type        = string
}

variable "secret_key" {
  description = "Tencent Cloud secret key (injected at execution time; never stored in the repo)."
  type        = string
  sensitive   = true
}

variable "zone_id" {
  description = "TEO site ID to configure the security policy on, e.g. zone-xxxxx. Must be a site owned by the executing account."
  type        = string
}

variable "rate_limit_mode" {
  description = "Precise rate limit mode to configure and verify. Valid values: Block (block access source) or Throttle (only handle over-limit requests)."
  type        = string
}
