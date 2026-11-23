provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource block(s) for the resource under test are appended below by the
# agent. Do not remove or modify the provider block above.
# ==============================================================================

resource "tencentcloud_alb_listener" "example" {
  load_balancer_id  = var.load_balancer_id
  listener_port     = var.listener_port
  listener_protocol = "HTTP"
  listener_name     = "${var.listener_name_prefix}-tfagentflow-${formatdate("MMDDhhmm", timestamp())}"
  idle_timeout      = 30
  request_timeout   = 60
  gzip_enabled      = false

  default_actions = [
    {
      type = "Forward"
      target_group_config = {
        target_groups = [
          {
            target_group_id = var.target_group_id
            weight          = 10
          }
        ]
        target_group_sticky_session = {
          enabled = true
          timeout = 1000
        }
      }
    }
  ]

  x_forwarded_for_config = {
    x_forwarded_for_mode = "append"
  }

  tags = [
    {
      tag_key   = "createdBy"
      tag_value = "tf-agentflow"
    }
  ]
}
