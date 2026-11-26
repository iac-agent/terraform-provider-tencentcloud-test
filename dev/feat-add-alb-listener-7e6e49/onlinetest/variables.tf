variable "region" {
  description = "Tencent Cloud region where the ALB load balancer lives, e.g. ap-guangzhou."
  type        = string
  default     = "ap-guangzhou"
}

variable "secret_id" {
  description = "Tencent Cloud secret id (injected at execution time; never stored in the repository)."
  type        = string
  default     = null
  sensitive   = true
}

variable "secret_key" {
  description = "Tencent Cloud secret key (injected at execution time; never stored in the repository)."
  type        = string
  default     = null
  sensitive   = true
}

variable "load_balancer_id" {
  description = "ID of a disposable test ALB instance (alb-xxxxxxxx) that hosts the listener. Must be owned by the execution credentials."
  type        = string
}

variable "listener_id" {
  description = "ID of a disposable test layer-7 listener (lst-xxxxxxxx) on the load balancer that hosts the new forwarding rule. Must be owned by the execution credentials."
  type        = string
}

variable "target_group_id" {
  description = "ID of a disposable test ALB target group (lbtg-xxxxxxxx) used as the final TargetGroup forwarding action. Must be owned by the execution credentials."
  type        = string
}

variable "rule_name_prefix" {
  description = "Name prefix of the forwarding rule; a unique suffix is appended to avoid conflicts with existing rules."
  type        = string
}

variable "rule_host" {
  description = "Host name matched by the Host condition of the forwarding rule, e.g. tf-agentflow.example.com."
  type        = string
}

variable "rule_path" {
  description = "Request path matched by the Path condition of the forwarding rule, e.g. /tfagentflow/."
  type        = string
}

variable "insert_header_key" {
  description = "HTTP header key inserted by the InsertHeader action, e.g. x-tf-agentflow."
  type        = string
}

variable "insert_header_value" {
  description = "HTTP header value inserted by the InsertHeader action, e.g. tf-agentflow."
  type        = string
}
