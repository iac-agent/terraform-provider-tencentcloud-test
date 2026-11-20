provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Data block(s) for the interface under test are appended below by the agent.
# Do not remove or modify the provider block above.
# ==============================================================================

data "tencentcloud_ags_gpu_resource_specs" "all" {
  offset = var.offset
  limit  = var.limit
}

data "tencentcloud_ags_gpu_resource_specs" "filtered" {
  gpu_type = var.gpu_type
  cpu      = var.cpu
  memory   = var.memory
  gpu_num  = var.gpu_num
}
