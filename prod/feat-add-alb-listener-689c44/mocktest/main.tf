provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

resource "tencentcloud_alb_listener" "http" {
  load_balancer_id  = "alb-12345678"
  listener_port     = 80
  listener_protocol = "HTTP"
  listener_name     = "tf-listener-mocktest"
  gzip_enabled      = true
  idle_timeout      = 60
  request_timeout   = 120

  default_actions = [{
    type = "TargetGroup"
    target_group_config = {
      target_groups = [{
        target_group_id = "lbtg-12345678"
        weight          = 20
      }]
      target_group_sticky_session = {
        enabled = true
        timeout = 200
      }
    }
  }]

  tags = [{
    tag_key   = "env"
    tag_value = "mocktest"
  }]
}

resource "tencentcloud_alb_listener" "https" {
  load_balancer_id   = "alb-12345678"
  listener_port      = 443
  listener_protocol  = "HTTPS"
  listener_name      = "tf-listener-https-mocktest"
  http2_enabled      = true
  security_policy_id = "tls-12345678"
  certificate_ids    = ["cert-12345678"]

  default_actions = [{
    type = "TargetGroup"
    target_group_config = {
      target_groups = [{
        target_group_id = "lbtg-87654321"
      }]
    }
  }]

  x_forwarded_for_config = {
    x_forwarded_for_mode      = "append"
    x_forwarded_for_port_enabled = true
  }
}
