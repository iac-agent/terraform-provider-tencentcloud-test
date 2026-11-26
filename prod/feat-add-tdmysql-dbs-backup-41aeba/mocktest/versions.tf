terraform {
  required_version = ">= 1.7.0"

  required_providers {
    tencentcloud = {
      source  = "registry.terraform.io/tencentcloudstack/tencentcloud"
      version = "0.0.1-beta.agentflow.iacpaf-7tibKBNYn9"
    }
  }
}
variable "region" {
  description = "Tencent Cloud region (placeholder; mock tests do not call the cloud API)."
  type        = string
  default     = "ap-guangzhou"
}

variable "secret_id" {
  description = "Tencent Cloud secret id (placeholder; mock tests do not call the cloud API)."
  type        = string
  default     = "tf-test-placeholder"
}

variable "secret_key" {
  description = "Tencent Cloud secret key (placeholder; mock tests do not call the cloud API)."
  type        = string
  default     = "tf-test-placeholder"
  sensitive   = true
}
