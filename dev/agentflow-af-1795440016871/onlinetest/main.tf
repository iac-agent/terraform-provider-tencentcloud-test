provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

locals {
  unique_suffix = format("%s", substr(sha1(timestamp()), 0, 6))
}

resource "tencentcloud_alb_listener" "example" {
  load_balancer_id  = var.load_balancer_id
  listener_protocol = var.listener_protocol
  listener_port     = var.listener_port
  listener_name     = "${var.listener_name}-${local.unique_suffix}"
  idle_timeout      = var.idle_timeout
  request_timeout   = var.request_timeout
  gzip_enabled      = true

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
    tag_key   = "createdBy"
    tag_value = "tf-agentflow"
  }
}
