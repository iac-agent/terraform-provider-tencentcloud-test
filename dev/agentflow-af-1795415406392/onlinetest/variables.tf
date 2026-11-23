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

variable "load_balancer_id" {
  description = "ID of an existing ALB instance the test listener will attach to, format alb-xxxxxxxx. Must be a test instance that can be safely used."
  type        = string
}

variable "target_group_id" {
  description = "ID of an existing ALB target group for the default forwarding action, format lbtg-xxxxxxxx. Must be a test target group."
  type        = string
}

variable "listener_port" {
  description = "Listener frontend port, 1~65535."
  type        = number
  default     = 8901
}

variable "listener_protocol" {
  description = "Listener protocol: HTTP, HTTPS or QUIC."
  type        = string
  default     = "HTTP"
}

variable "listener_name_prefix" {
  description = "Listener name prefix; a unique suffix is appended automatically."
  type        = string
  default     = "tf-agentflow"
}
