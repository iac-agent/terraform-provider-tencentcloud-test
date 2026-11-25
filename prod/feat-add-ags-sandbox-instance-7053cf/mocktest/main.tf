provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

resource "tencentcloud_ags_sandbox_instance" "full" {
  tool_name = "tf-example-tool"
  timeout   = "30m"
  auth_mode = "DEFAULT"

  mount_options = [{
    name       = "workspace"
    mount_path = "/workspace"
    sub_path   = "run-001"
    read_only  = false
  }]

  custom_configuration = {
    image               = "ccr.ccs.tencentyun.com/tf-example/go-httpbin:v2.16.1"
    image_registry_type = "personal"
    command             = ["/bin/go-httpbin"]
    args                = ["-port", "8080"]
    ports = [{
      name     = "http"
      port     = 8080
      protocol = "TCP"
    }]
    resources = {
      cpu     = "1"
      memory  = "1Gi"
      storage = "5Gi"
    }
    env = [{
      name  = "EXAMPLE_KEY"
      value = "example-value"
    }]
  }

  metadata = [{
    name  = "run_id"
    value = "tf-example"
  }]
}

resource "tencentcloud_ags_sandbox_instance" "clone" {
  tool_id            = "tool-mock0001"
  source_instance_id = "instance-source0001"
  timeout            = "300s"
}
