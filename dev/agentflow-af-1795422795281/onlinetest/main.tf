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
# Resource block(s) for the online test. The ALB listener depends on an existing
# ALB instance and target group, whose IDs are provided at execution time via
# variables (no hardcoded/existing resource references in the repo).
# ==============================================================================

resource "tencentcloud_alb_listener" "example" {
  load_balancer_id  = var.load_balancer_id
  listener_port     = var.listener_port
  listener_protocol = var.listener_protocol
  listener_name     = "${var.name_prefix}-tfagentflow"
  idle_timeout      = 60
  request_timeout   = 120
  gzip_enabled      = true
  http2enabled      = var.listener_protocol == "HTTPS" ? true : false

  default_actions {
    type = "Forward"
    target_group_config {
      target_groups {
        target_group_id = var.target_group_id
        weight          = 10
      }
      target_group_sticky_session {
        enabled = false
        timeout = 1000
      }
    }
  }

  tags {
    tag_key   = "createdBy"
    tag_value = "tfagentflow"
  }
}
