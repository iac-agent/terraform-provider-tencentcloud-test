provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

locals {
  listener_name = coalesce(var.listener_name, "tf-agentflow-listener")
}

resource "tencentcloud_alb_listener" "example" {
  load_balancer_id  = var.load_balancer_id
  listener_port     = var.listener_port
  listener_protocol = "HTTP"
  listener_name     = local.listener_name
  idle_timeout      = 30
  request_timeout   = 60
  gzip_enabled      = true

  default_actions = [
    {
      type = "Forward"
      target_group_config = {
        target_groups = [
          {
            target_group_id = var.target_group_id
            weight          = 10
          },
        ]
      }
    },
  ]

  tags = {
    createdBy = "tf-agentflow"
  }
}
