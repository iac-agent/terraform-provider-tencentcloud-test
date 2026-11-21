provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

resource "tencentcloud_alb_listener" "http_example" {
  load_balancer_id  = "alb-12345678"
  listener_port     = 80
  listener_protocol = "HTTP"
  listener_name     = "tf-mock-http"

  default_actions {
    type = "Forward"
    target_group_config {
      target_groups {
        target_group_id = "lbtg-12345678"
        weight          = 10
      }
    }
  }

  gzip_enabled = true
  idle_timeout = 15
}

resource "tencentcloud_alb_listener" "https_example" {
  load_balancer_id   = "alb-12345678"
  listener_port      = 443
  listener_protocol  = "HTTPS"
  listener_name      = "tf-mock-https"
  certificate_ids    = ["cert-12345678"]
  security_policy_id = "tls-12345678"
  http2enabled       = true

  default_actions {
    type = "Forward"
    target_group_config {
      target_groups {
        target_group_id = "lbtg-87654321"
        weight          = 20
      }
      target_group_sticky_session {
        enabled = true
        timeout = 1200
      }
    }
  }

  x_forwarded_for_config {
    x_forwarded_for_mode = "append"
    x_forwarded_for_host_enabled = true
  }
}
