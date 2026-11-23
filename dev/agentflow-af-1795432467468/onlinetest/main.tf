provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

resource "tencentcloud_alb_listener" "online" {
  load_balancer_id  = var.load_balancer_id
  listener_port     = var.listener_port
  listener_protocol = var.listener_protocol
  listener_name     = "${var.listener_name_prefix}-tfagentflow"
  idle_timeout      = var.idle_timeout
  request_timeout   = var.request_timeout

  default_actions {
    type = "TargetGroup"
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
}
