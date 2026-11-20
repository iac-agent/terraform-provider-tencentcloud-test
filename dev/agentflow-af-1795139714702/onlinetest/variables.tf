variable "region" {
  description = "Tencent Cloud region where AGS is available, for example ap-guangzhou."
  type        = string
  default     = "ap-guangzhou"
}

variable "secret_id" {
  description = "Tencent Cloud secret id (injected at execution time, never stored in the repo)."
  type        = string
  default     = null
  sensitive   = true
}

variable "secret_key" {
  description = "Tencent Cloud secret key (injected at execution time, never stored in the repo)."
  type        = string
  default     = null
  sensitive   = true
}

variable "gpu_type" {
  description = "GPU type identifier used to filter sellable GPU specs, for example 5090d. Leave null to query all sellable specs."
  type        = string
  default     = null
}

variable "cpu" {
  description = "Number of CPU cores used to filter specs. Must be provided together with gpu_type, memory and gpu_num, or all omitted."
  type        = number
  default     = null
}

variable "memory" {
  description = "Host memory in GiB used to filter specs. Must be provided together with gpu_type, cpu and gpu_num, or all omitted."
  type        = number
  default     = null
}

variable "gpu_num" {
  description = "Number of GPU cards per instance used to filter specs. Must be provided together with gpu_type, cpu and memory, or all omitted."
  type        = number
  default     = null
}

variable "offset" {
  description = "Pagination offset for the spec query, default 0."
  type        = number
  default     = 0
}

variable "limit" {
  description = "Page size for the spec query, in the range 1-500; default 100 when omitted."
  type        = number
  default     = 100
}
