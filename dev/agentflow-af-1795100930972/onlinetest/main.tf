provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# tencentcloud_ags_gpu_resource_group is an import-only resource: GPU resource
# groups are purchased in the AGS console and have no public create/release
# API. The online test imports an existing EMPTY group provided by the user.
# Setting `name` to a value different from the current cloud name exercises the
# ModifyGPUResourceGroup rename path at apply time; assertions below check the
# real cloud read-back.
#
# NOTE: because the provider intentionally rejects Delete (no public release
# API), `terraform test` teardown will report a destroy error for this
# resource. The GPU resource group itself stays intact and must be released in
# the AGS console after the test.
import {
  to = tencentcloud_ags_gpu_resource_group.example
  id = var.resource_group_id
}

resource "tencentcloud_ags_gpu_resource_group" "example" {
  name = var.initial_name
}
