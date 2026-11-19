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

variable "from_mode" {
  description = "Call source mode passed to OpenConfigRecorder. 1 = called from the control center."
  type        = number
  default     = 1
}

variable "resource_types" {
  description = "Resource types to monitor, e.g. [\"QCS::CAM::Group\", \"QCS::CVM::Instance\"]."
  type        = list(string)
  default     = ["QCS::CAM::Group", "QCS::CVM::Instance"]
}
