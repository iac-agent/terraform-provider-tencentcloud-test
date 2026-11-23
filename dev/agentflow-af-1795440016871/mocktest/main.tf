provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

resource "tencentcloud_alb_listener" "example" {
  load_balancer_id  = "alb-12345678"
  listener_protocol = "HTTP"
  listener_port     = 80
  listener_name     = "tf-mock-listener"
  idle_timeout      = 30
  request_timeout   = 60
  gzip_enabled      = true

  default_actions {
    type = "Forward"
    target_group_config {
      target_groups {
        target_group_id = "lbtg-12345678"
        weight          = 10
      }
      target_group_sticky_session {
        enabled = true
        timeout = 1000
      }
    }
  }

  x_forwarded_for_config {
    x_forwarded_for_mode      = "append"
    x_forwarded_for_host_enabled = true
  }

  tags {
    tag_key   = "env"
    tag_value = "test"
  }
}
