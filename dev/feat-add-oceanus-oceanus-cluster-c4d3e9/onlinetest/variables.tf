variable "region" {
  description = "Tencent Cloud region where the cluster, VPC, subnet and COS bucket are created, e.g. ap-guangzhou. Must match var.region_id."
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

variable "cluster_name_prefix" {
  description = "Prefix of the Oceanus cluster name; '-tfagentflow-<timestamp>' is appended automatically. Keep it within 30 characters and use only lower-case letters, digits, '-' or '_' (the API allows 1-50 letters/digits/hyphens/underscores, and the same prefix is also used for the COS bucket name)."
  type        = string
}

variable "cluster_password" {
  description = "Flink UI login password of the cluster (user name is admin). Must satisfy the Oceanus password policy: 8-32 characters containing at least three of upper case, lower case, digits and special characters."
  type        = string
  sensitive   = true
}

variable "region_id" {
  description = "Numeric region id passed to CreateOceanusCluster (the numeric form of var.region), e.g. 1 for ap-guangzhou. It must agree with var.region, otherwise the cluster lands in a different region than the VPC/subnet/COS bucket."
  type        = number
}

variable "zone" {
  description = "Availability zone name used by the VPC subnet, e.g. ap-guangzhou-3. Must belong to var.region."
  type        = string
}

variable "zone_id" {
  description = "Numeric availability zone id passed to CreateOceanusCluster, matching var.zone, e.g. 100003 for ap-guangzhou-3."
  type        = number
}

variable "cu" {
  description = "Number of CUs of the cluster. 12 is the minimum billable unit of Oceanus; 1 CU = 1 CPU + 4 GB memory."
  type        = number
}

variable "owner_uin" {
  description = "Owner UIN written into vpc_descriptions. Leave empty to use the owner UIN of the master account that owns the execution credential."
  type        = string
  default     = null
}

variable "vpc_cidr" {
  description = "CIDR block of the VPC created for the cluster, inside 10.0.0.0/16, 172.16.0.0/12 or 192.168.0.0/16."
  type        = string
  default     = "10.10.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block of the subnet created for the cluster. Oceanus occupies subnet IPs, so keep the subnet large enough (e.g. a /24)."
  type        = string
  default     = "10.10.1.0/24"
}
