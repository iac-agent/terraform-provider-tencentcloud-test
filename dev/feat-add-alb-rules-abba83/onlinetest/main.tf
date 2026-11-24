provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource block(s) for the resource under test are appended below by the
# agent. Do not remove or modify the provider block above.
# ==============================================================================

resource "tencentcloud_alb_rules" "example" {
  load_balancer_id = var.load_balancer_id
  listener_id      = var.listener_id

  rules = [
    {
      priority  = 20001
      direction = "Request"
      rule_name = "${var.rule_name_prefix}-tfagentflow-${formatdate("MMDDhhmm", timestamp())}"

      conditions = [
        {
          type        = "Path"
          path_config = ["/tfagentflow/"]
        }
      ]

      actions = [
        {
          order = 1
          type  = "InsertHeader"

          insert_header_config = {
            key        = "X-Custom-Env"
            value      = "tfagentflow"
            value_type = "UserDefined"
          }
        },
        {
          order = 2
          type  = "TargetGroup"

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

      tags = [
        {
          tag_key   = "createdBy"
          tag_value = "tf-agentflow"
        }
      ]
    }
  ]
}
