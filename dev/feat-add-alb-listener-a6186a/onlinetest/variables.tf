variable "region" {
  description = "Tencent Cloud region where the ALB load balancer lives, for example ap-guangzhou."
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
  description = "ID of an existing application load balancer (alb-xxxxxxxx) whose listener hosts the new forwarding rule. Must be owned by the execution credentials."
  type        = string
}

variable "listener_id" {
  description = "ID of an existing layer-7 listener (lst-xxxxxxxx) on the load balancer that hosts the new forwarding rule. Must be owned by the execution credentials."
  type        = string
}

variable "target_group_id" {
  description = "ID of an existing ALB target group (lbtg-xxxxxxxx) used as the final TargetGroup forwarding action. Must belong to the same account."
  type        = string
}

variable "rule_name_prefix" {
  description = "Name prefix of the forwarding rule. A unique suffix is appended at runtime to avoid name conflicts."
  type        = string
  default     = "tf-agentflow"
}

variable "rule_host" {
  description = "Host name matched by the Host condition of the forwarding rule, e.g. tf-agentflow.example.com."
  type        = string
  default     = "tf-agentflow.example.com"
}

variable "rule_path" {
  description = "Request path matched by the Path condition of the forwarding rule, e.g. /tfagentflow/."
  type        = string
  default     = "/tfagentflow/"
}

variable "insert_header_key" {
  description = "HTTP header key inserted by the InsertHeader action, 1-40 characters from a-z A-Z 0-9 - _, e.g. x-tf-agentflow."
  type        = string
  default     = "x-tf-agentflow"
}

variable "insert_header_value" {
  description = "HTTP header value inserted by the InsertHeader action, up to 128 printable characters, e.g. tf-agentflow."
  type        = string
  default     = "tf-agentflow"
}
