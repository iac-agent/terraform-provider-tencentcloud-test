provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

resource "tencentcloud_alb_listener" "example" {
  load_balancer_id  = "alb-12345678"
  listener_port     = 80
  listener_protocol = "HTTP"
  listener_name     = "tf-example"
  idle_timeout      = 30
  request_timeout   = 60
  gzip_enabled      = true

  default_actions = [
    {
      type = "Forward"
      target_group_config = {
        target_groups = [
          {
            target_group_id = "lbtg-11111111"
            weight          = 10
          },
        ]
      }
    },
  ]

  tags = {
    createdBy = "terraform"
  }
}
