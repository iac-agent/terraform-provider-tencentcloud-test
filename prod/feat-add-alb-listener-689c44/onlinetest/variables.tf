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
  description = "ID of the new-generation ALB instance (format alb-xxxxxxxx) that the test listener is created on. Must be owned by the execution credentials."
  type        = string
}

variable "target_group_id" {
  description = "ID of the ALB target group (format lbtg-xxxxxxxx) used as the default forwarding target. Must belong to the same account."
  type        = string
}

variable "listener_port" {
  description = "Front-end port of the test listener (1~65535). Defaults to 18080; override when the port is already occupied on the load balancer."
  type        = number
  default     = 18080
}

variable "listener_name" {
  description = "Custom name of the test listener. Leave empty to use the generated default name."
  type        = string
  default     = ""
}
