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
  description = "ID of an existing application load balancer (alb-xxxxxxxx) whose listener the new forwarding rules attach to. Must be owned by the execution credentials."
  type        = string
}

variable "listener_id" {
  description = "ID of an existing HTTP/HTTPS listener (lst-xxxxxxxx) on the load balancer. Must be owned by the execution credentials."
  type        = string
}

variable "target_group_id" {
  description = "Existing target group ID (lbtg-xxxxxxxx) the TargetGroup forwarding action forwards traffic to. Must be owned by the execution credentials."
  type        = string
}

variable "rule_name_prefix" {
  description = "Name prefix for the new forwarding rule. A unique suffix is appended at runtime to avoid name conflicts."
  type        = string
  default     = "tf-agentflow"
}
