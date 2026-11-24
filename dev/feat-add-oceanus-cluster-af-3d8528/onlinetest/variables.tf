variable "region" {
  description = "Tencent Cloud region where the cluster, VPC, subnet and COS bucket are created (e.g. ap-guangzhou)."
  type        = string
  default     = "ap-guangzhou"
}

variable "secret_id" {
  description = "Tencent Cloud secret id (injected at execution time; never committed)."
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "Tencent Cloud secret key (injected at execution time; never committed)."
  type        = string
  sensitive   = true
}

variable "cluster_name_prefix" {
  description = "Prefix of the Oceanus cluster name; a unique timestamp suffix plus '-tfagentflow' is appended automatically. Keep the prefix within 30 characters (the API allows 1-50 in total, only letters, Chinese characters, digits, '-' and '_')."
  type        = string
}

variable "region_id" {
  description = "Numeric region id of the Oceanus cluster (the numeric form of var.region as accepted by CreateOceanusCluster), e.g. 1 for ap-guangzhou."
  type        = number
}

variable "zone" {
  description = "Availability zone name used by the VPC subnet, e.g. ap-guangzhou-3. Must belong to var.region."
  type        = string
}

variable "zone_id" {
  description = "Numeric availability zone id of the Oceanus cluster, matching var.zone, e.g. 100003 for ap-guangzhou-3."
  type        = number
}

variable "login_password" {
  description = "Flink UI login password for the cluster (user name is admin). Must satisfy the Oceanus password policy (8-32 characters, containing at least 3 of upper case, lower case, digit and special character)."
  type        = string
  sensitive   = true
}

variable "cu" {
  description = "Number of CUs of the cluster created in the first run. 12 is the minimum billable unit of Oceanus."
  type        = number
}

variable "cu_scaled" {
  description = "Number of CUs the cluster is scaled to in the second run (ScaleOceanusCluster). Must differ from var.cu and satisfy 12 + 7*n (n >= 0), e.g. 19."
  type        = number
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC created for the cluster, inside 10.0.0.0/16, 172.16.0.0/12 or 192.168.0.0/16."
  type        = string
  default     = "10.10.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block of the subnet created for the cluster. Oceanus occupies subnet IPs, keep the subnet large enough (e.g. a /24)."
  type        = string
  default     = "10.10.1.0/24"
}

variable "create_timeout" {
  description = "How long to wait for the asynchronous cluster creation, e.g. 30m."
  type        = string
  default     = "30m"
}
