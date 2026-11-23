terraform {
  required_version = ">= 1.7.0"

  required_providers {
    tencentcloud = {
      source  = "registry.terraform.io/tencentcloudstack/tencentcloud"
      version = "0.0.1-beta.agentflow.af-1795422795281"
    }
  }
}
provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

resource "tencentcloud_alb_listener" "example" {
  load_balancer_id  = "alb-mock0001"
  listener_port     = 80
  listener_protocol = "HTTP"
  listener_name     = "tf-test-listener"
  gzip_enabled      = true
  idle_timeout      = 60
  request_timeout   = 120

  default_actions {
    type = "Forward"
    target_group_config {
      target_groups {
        target_group_id = "lbtg-mock001"
        weight          = 20
      }
      target_group_sticky_session {
        enabled = true
        timeout = 1000
      }
    }
  }

  x_forwarded_for_config {
    x_forwarded_for_mode         = "append"
    x_forwarded_for_host_enabled = true
  }

  tags {
    tag_key   = "env"
    tag_value = "test"
  }
}
