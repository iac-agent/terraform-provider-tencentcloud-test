provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

locals {
  listener_name = coalesce(var.listener_name, "tf-agentflow-listener-tfagentflow")
}

# The new-generation ALB product currently only exposes the listener resource
# in the provider, so the parent ALB instance and the forwarding target group
# are injected as variables. Only the listener below is created (and then
# destroyed by `terraform test`), leaving no residue on the cloud.
resource "tencentcloud_alb_listener" "example" {
  load_balancer_id  = var.load_balancer_id
  listener_port     = var.listener_port
  listener_protocol = "HTTP"
  listener_name     = local.listener_name
  gzip_enabled      = true
  idle_timeout      = 60
  request_timeout   = 120

  default_actions = [
    {
      type = "TargetGroup"
      target_group_config = {
        target_groups = [
          {
            target_group_id = var.target_group_id
            weight          = 10
          }
        ]
      }
    },
  ]

  tags = [
    {
      tag_key   = "createdBy"
      tag_value = "tf-agentflow"
    }
  ]
}
