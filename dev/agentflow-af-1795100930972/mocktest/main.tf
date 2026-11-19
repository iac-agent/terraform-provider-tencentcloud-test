provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# tencentcloud_ags_gpu_resource_group is an import-only resource: GPU resource
# groups are purchased in the AGS console and cannot be created or released via
# a public API. In mock mode the resource is created by the override, and the
# name update flows through ModifyGPUResourceGroup (also mocked).
resource "tencentcloud_ags_gpu_resource_group" "example" {
  name = "tf-test-gpu-group"
}
