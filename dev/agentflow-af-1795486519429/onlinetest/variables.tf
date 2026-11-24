variable "region" {
  description = "Tencent Cloud region where the Oceanus cluster is created, e.g. ap-guangzhou."
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

variable "cluster_name" {
  description = "Oceanus cluster name, 1-50 chars of letters/Chinese/digits/hyphen/underscore. Example: tf-agentflow-cluster"
  type        = string
}

variable "region_id" {
  description = "Oceanus region ID (numeric), queryable via DescribeRegions with Product=oceanus. Example: 1"
  type        = number
}

variable "zone_id" {
  description = "Oceanus zone ID (numeric), queryable via DescribeZones with Product=oceanus. Example: 100003"
  type        = number
}

variable "login_password" {
  description = "Flink UI login password for the cluster (username: admin). Example: Password@123"
  type        = string
  sensitive   = true
}

variable "default_cos_bucket" {
  description = "Existing COS bucket for checkpoints/jars/logs, must be in the same region. Example: tf-agentflow-bucket-1250000000"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the cluster, e.g. vpc-xxxxxxxx. Must have enough free subnet IPs."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the cluster, e.g. subnet-xxxxxxxx."
  type        = string
}

variable "instance_charge_type" {
  description = "Cluster billing type: POSTPAID_BY_SECOND (default) or PREPAID."
  type        = string
  default     = "POSTPAID_BY_SECOND"
}

variable "cu" {
  description = "Number of cluster CUs, minimum 12. Example: 12"
  type        = number
  default     = 12
}

variable "cu_memory" {
  description = "Core-memory ratio, only [0, 2, 4, 8] are supported. Example: 2"
  type        = number
  default     = 2
}
