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
  description = "ID of an existing application load balancer (alb-xxxxxxxx) to attach the new listener to. Must be owned by the execution credentials."
  type        = string
}

variable "listener_port" {
  description = "Frontend port of the new listener, 1-65535. Pick a free port on the load balancer (e.g. 8080)."
  type        = number
  default     = 8080
}

variable "target_group_id" {
  description = "Existing target group ID (lbtg-xxxxxxxx) the listener forwards traffic to. Must be owned by the execution credentials."
  type        = string
}

variable "listener_name_prefix" {
  description = "Name prefix for the new listener. A unique suffix is appended at runtime to avoid name conflicts."
  type        = string
  default     = "tf-agentflow"
}
