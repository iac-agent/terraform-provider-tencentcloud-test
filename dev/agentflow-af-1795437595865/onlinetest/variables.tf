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
  description = "ID of an existing ALB instance (format alb-xxxxxxxx) the test listener is created on. The instance must belong to the executing account and be deletable afterwards."
  type        = string
}

variable "target_group_id" {
  description = "ID of an existing ALB target group (format lbtg-xxxxxxxx) used as the default forwarding target. It must belong to the same account."
  type        = string
}

variable "listener_port" {
  description = "Front-end port of the test listener (1~65535). Uses a low-collision default; override when the port is already occupied."
  type        = number
  default     = 18080
}

variable "listener_name" {
  description = "Name of the test listener. A unique test suffix is appended automatically; keep it empty to use the generated name."
  type        = string
  default     = ""
}
