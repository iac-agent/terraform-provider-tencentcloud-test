variable "region" {
  description = "Tencent Cloud region where the ALB instance lives."
  type        = string
  default     = "ap-guangzhou"
}

variable "secret_id" {
  description = "Tencent Cloud secret id (injected at execution time; never committed)."
  type        = string
  default     = null
  sensitive   = true
}

variable "secret_key" {
  description = "Tencent Cloud secret key (injected at execution time; never committed)."
  type        = string
  default     = null
  sensitive   = true
}

variable "load_balancer_id" {
  description = "ID of an existing application load balancer (alb-xxxxxxxx) whose listener hosts the new forwarding rule. Must be owned by the execution credentials."
  type        = string
}

variable "listener_id" {
  description = "ID of an existing layer-7 listener (lst-xxxxxxxx) on the load balancer that hosts the new forwarding rule. Must be owned by the execution credentials."
  type        = string
}

variable "target_group_id" {
  description = "Existing target group ID (lbtg-xxxxxxxx) the forwarding rule forwards matched traffic to. Must be owned by the execution credentials."
  type        = string
}

variable "rule_name_prefix" {
  description = "Name prefix for the new forwarding rule. A unique suffix is appended at runtime to avoid name conflicts."
  type        = string
  default     = "tf-agentflow"
}

variable "rule_host" {
  description = "Host name matched by the forwarding rule condition, e.g. tf-agentflow.example.com."
  type        = string
  default     = "tf-agentflow.example.com"
}

variable "rule_path" {
  description = "Request path matched by the forwarding rule condition, e.g. /api."
  type        = string
  default     = "/api"
}

variable "insert_header_key" {
  description = "HTTP header key inserted into matched requests, charset a-z A-Z 0-9 - _, e.g. x-tf-agentflow."
  type        = string
  default     = "x-tf-agentflow"
}

variable "insert_header_value" {
  description = "HTTP header value inserted into matched requests, up to 128 printable characters."
  type        = string
  default     = "tf-agentflow"
}
