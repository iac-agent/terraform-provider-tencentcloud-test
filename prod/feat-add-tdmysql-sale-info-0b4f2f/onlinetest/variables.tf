variable "region" {
  description = "Tencent Cloud region where the sale info query is issued."
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

variable "instance_type" {
  description = "Optional instance type filter. Currently only 'serverless' is supported; leaving it empty (default) returns the sale info of all regions."
  type        = string
  default     = ""
}

variable "src_region" {
  description = "Optional disaster recovery primary instance region, e.g. ap-guangzhou. Leave empty (default) to not apply the filter."
  type        = string
  default     = ""
}

variable "instance_id" {
  description = "Optional instance id; passing it returns the sale info of the region and zones where this instance is located. Leave empty (default) to not apply the filter."
  type        = string
  default     = ""
}
