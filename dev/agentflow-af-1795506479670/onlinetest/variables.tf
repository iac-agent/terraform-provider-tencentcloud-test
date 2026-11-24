variable "region" {
  description = "Tencent Cloud region."
  type        = string
  default     = "ap-guangzhou"
}

variable "secret_id" {
  description = "Tencent Cloud secret id (injected at execution time; never committed)."
  type        = string
}

variable "secret_key" {
  description = "Tencent Cloud secret key (injected at execution time; never committed)."
  type        = string
  sensitive   = true
}

variable "tool_id" {
  description = "Id of an existing AGS sandbox tool used to start the instance, e.g. tool-1234abcd. The tool must exist under the account of the injected credentials."
  type        = string
}

variable "instance_timeout" {
  description = "Timeout after which the sandbox instance is automatically reclaimed, e.g. 5m. Minimum 30s, maximum 24h. A short value keeps the test fully self-reclaiming."
  type        = string
  default     = "5m"
}

variable "image" {
  description = "Image address of the sandbox instance custom configuration, e.g. ccr.ccs.tencentyun.com/test/go-httpbin:v2.16.1."
  type        = string
  default     = "ccr.ccs.tencentyun.com/test/go-httpbin:v2.16.1"
}

variable "image_registry_type" {
  description = "Image registry type of the custom configuration. Valid values: enterprise, personal, custom."
  type        = string
  default     = "personal"
}

variable "metadata_name" {
  description = "Metadata name attached to the sandbox instance, e.g. createdBy."
  type        = string
  default     = "createdBy"
}

variable "metadata_value" {
  description = "Metadata value attached to the sandbox instance, e.g. tf-agentflow."
  type        = string
  default     = "tf-agentflow"
}
