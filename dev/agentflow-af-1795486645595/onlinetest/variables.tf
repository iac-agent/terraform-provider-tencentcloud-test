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

variable "tool_name" {
  description = "Name of the sandbox tool used to start the instance. It must be unique under the same AppId, length 1-50 characters."
  type        = string
}

variable "image" {
  description = "Image address of the sandbox instance custom configuration, e.g. ccr.ccs.tencentyun.com/<namespace>/<repo>:<tag> from a personal CCR registry."
  type        = string
}

variable "timeout" {
  description = "Timeout after which the sandbox instance is recycled automatically, e.g. 10m. Default 10m."
  type        = string
  default     = "10m"
}
