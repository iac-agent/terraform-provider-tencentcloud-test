variable "region" {
  description = "Tencent Cloud region where the AGS GPU resource group lives, e.g. ap-guangzhou."
  type        = string
  default     = "ap-guangzhou"
}

variable "secret_id" {
  description = "Tencent Cloud secret id (injected at execution time; never committed)."
  type        = string
  default     = ""
}

variable "secret_key" {
  description = "Tencent Cloud secret key (injected at execution time; never committed)."
  type        = string
  default     = ""
}

variable "resource_group_id" {
  description = "Id of an existing empty AGS GPU resource group to import and verify (purchased in the AGS console; must be releasable, e.g. rg-xxxxxxxx)."
  type        = string
}

variable "initial_name" {
  description = "Name to set on the GPU resource group first, e.g. tf-agentflow-gpu-group-initial. Keep it unique to avoid clashing with existing groups."
  type        = string
}

variable "updated_name" {
  description = "Second name applied via ModifyGPUResourceGroup to verify the rename path, e.g. tf-agentflow-gpu-group-updated."
  type        = string
}

variable "release_group_after_test" {
  description = "Whether to call DeleteGPUResourceGroup after assertions. The group must be empty (no GPU instances, occupations or bound sandbox tools) or the delete fails."
  type        = bool
  default     = false
}
