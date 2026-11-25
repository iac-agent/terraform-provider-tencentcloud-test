variable "region" {
  description = "Tencent Cloud region used to start the sandbox instance (AGS must be available in that region)."
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

variable "tool_name_prefix" {
  description = "Prefix of the sandbox tool name created for this run, e.g. `ags-tfagentflow-0821`. The final tool name is `<prefix>-tfagentflow`; AGS tool names are unique per AppId, so change the prefix when the name is already taken."
  type        = string
}

variable "sandbox_image" {
  description = "Container image used by the custom sandbox tool (and inherited by the sandbox instance), e.g. `ccr.ccs.tencentyun.com/<namespace>/go-httpbin:v2.16.1`. It must be pullable by AGS."
  type        = string
}

variable "image_registry_type" {
  description = "Type of the image registry: `enterprise` (TCR enterprise), `personal` (CCR personal) or `custom`."
  type        = string
  default     = "personal"
}

variable "container_port" {
  description = "Service port exposed by the sandbox image, e.g. `8080`."
  type        = number
}

variable "instance_timeout_minutes" {
  description = "Sandbox instance timeout in minutes (1~1440). It is sent as `<n>m` and the cloud reports it back in `timeout_seconds`."
  type        = number
}

variable "cpu" {
  description = "CPU resources of the sandbox, e.g. `1` or `2`."
  type        = string
}

variable "memory" {
  description = "Memory resources of the sandbox, e.g. `1Gi` or `2Gi`."
  type        = string
}
