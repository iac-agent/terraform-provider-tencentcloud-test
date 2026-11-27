variable "region" {
  description = "Tencent Cloud region where the AGS sandbox instances live."
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

variable "instance_ids" {
  description = "Optional list of sandbox instance ids used by the filtered query run. Leave empty to only run the unfiltered query."
  type        = list(string)
  default     = []
}
