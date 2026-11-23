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
  load_balancer_id  = "alb-1234abcd"
  listener_port     = 80
  listener_protocol = "HTTP"
  listener_name     = "tf-mock-listener"
  idle_timeout      = 30
  request_timeout   = 60
  gzip_enabled      = false

  default_actions = [
    {
      type = "Forward"
      target_group_config = {
        target_groups = [
          {
            target_group_id = "lbtg-1234abcd"
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
      tag_value = "terraform"
    }
  ]
}
