provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource block(s) for the resource under test. Only new resources created by
# this test are referenced; nothing existing is touched and everything is
# destroyed when the test finishes.
# ==============================================================================

resource "tencentcloud_alb_listener" "tfagentflow" {
  load_balancer_id  = var.load_balancer_id
  listener_port     = var.listener_port
  listener_protocol = var.listener_protocol
  listener_name     = "${var.listener_name_prefix}-lst"

  default_actions {
    type = "Forward"
    target_group_config {
      target_groups {
        target_group_id = var.target_group_id
        weight          = 10
      }
    }
  }

  tags {
    tag_key   = "terraform-test"
    tag_value = "agentflow"
  }
}
