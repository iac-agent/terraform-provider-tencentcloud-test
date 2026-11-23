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
  description = "ID of an existing ALB instance (format alb-xxxxxxxx) to attach the listener to. Must be deletable and belong to the test account."
  type        = string
}

variable "target_group_id" {
  description = "ID of an existing target group (format lbtg-xxxxxxxx) for the default forward action. Its protocol must match the listener protocol."
  type        = string
}

variable "listener_protocol" {
  description = "Listener protocol. Valid values: HTTP, HTTPS, QUIC."
  type        = string
  default     = "HTTP"
}

variable "listener_port" {
  description = "Front-end listener port, 1-65535."
  type        = number
  default     = 8080
}

variable "name_prefix" {
  description = "Prefix for the listener name (final name: <name_prefix>-tfagentflow)."
  type        = string
}
