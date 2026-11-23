variable "region" {
  description = "Tencent Cloud region where the ALB load balancer lives, for example ap-guangzhou."
  type        = string
  default     = "ap-guangzhou"
}

variable "secret_id" {
  description = "Tencent Cloud secret id (injected at execution time, never stored in the repo)."
  type        = string
  default     = null
  sensitive   = true
}

variable "secret_key" {
  description = "Tencent Cloud secret key (injected at execution time, never stored in the repo)."
  type        = string
  default     = null
  sensitive   = true
}

variable "load_balancer_id" {
  description = "ID of an existing ALB load balancer instance that the test listener is created on, in the format alb-xxxxxxxx. The listener is destroyed after the test; the load balancer itself is only referenced, never modified."
  type        = string
}

variable "target_group_id" {
  description = "ID of an existing ALB target group used as the default forwarding target, in the format lbtg-xxxxxxxx. Only referenced by the listener; not modified or destroyed."
  type        = string
}

variable "listener_port" {
  description = "Frontend port of the test listener, in the range 1-65535. Use a free port on the load balancer."
  type        = number
  default     = 18080
}

variable "listener_protocol" {
  description = "Listener protocol. Valid values: HTTP, HTTPS, QUIC. HTTP needs no certificate and is the safest choice."
  type        = string
  default     = "HTTP"
}

variable "listener_name_prefix" {
  description = "Name prefix of the test listener, 1-200 characters. A unique suffix is appended automatically to avoid conflicts."
  type        = string
  default     = "tf-agentflow"
}

variable "idle_timeout" {
  description = "Connection idle timeout in seconds, range 1-600."
  type        = number
  default     = 30
}

variable "request_timeout" {
  description = "Connection request timeout in seconds, range 1-600."
  type        = number
  default     = 60
}
