variable "region" {
  description = "Tencent Cloud region for the ALB instance."
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
  description = "ID of the target ALB instance (format alb-xxxxxxxx) the listener will attach to. The listener is destroyed after the test, the instance is not touched otherwise."
  type        = string
}

variable "target_group_id" {
  description = "ID of the target group (format lbtg-xxxxxxxx) the listener forwards to. The target group itself is not created or modified by this test."
  type        = string
}

variable "listener_port" {
  description = "Front-end port of the listener, 1~65535."
  type        = number
  default     = 8080
}

variable "listener_protocol" {
  description = "Listener protocol: HTTP, HTTPS or QUIC."
  type        = string
  default     = "HTTP"
}

variable "listener_name" {
  description = "Name prefix of the listener; a unique suffix is appended automatically."
  type        = string
  default     = "tf-agentflow-listener"
}

variable "idle_timeout" {
  description = "Connection idle timeout in seconds, 1~600."
  type        = number
  default     = 30
}

variable "request_timeout" {
  description = "Connection request timeout in seconds, 1~600."
  type        = number
  default     = 60
}
