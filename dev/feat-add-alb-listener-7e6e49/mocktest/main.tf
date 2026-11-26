provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# tencentcloud_alb_listener manages listener forwarding rules. Its state id is
# the RuleId of the first rule created by CreateRules and read back by
# DescribeRules.
resource "tencentcloud_alb_listener" "example" {
  listener_id      = "lst-a1b2c3d4"
  load_balancer_id = "alb-e5f6g7h8"
  client_token     = "tf-mock-token-7e6e49"
  dry_run          = false

  rules = [{
    priority  = 10
    direction = "Request"
    rule_name = "tf-mock-rule"

    actions = [
      {
        order = 10
        type  = "InsertHeader"
        insert_header_config = {
          key        = "x-tf-mock"
          value      = "agentflow"
          value_type = "UserDefined"
        }
      },
      {
        order = 20
        type  = "TargetGroup"
        target_group_config = {
          target_groups = [{
            target_group_id = "lbtg-1234abcd"
            weight          = 20
          }]
          target_group_sticky_session = {
            enabled = false
            timeout = 1000
          }
        }
      }
    ]

    conditions = [{
      type        = "Host"
      host_config = ["www.example.com"]
    }]

    tags = [{
      tag_key   = "env"
      tag_value = "mocktest"
    }]
  }]
}

# Minimal configuration: only Required attributes are set; Optional+Computed
# priority/direction and Optional conditions/tags/client_token/dry_run omitted.
resource "tencentcloud_alb_listener" "minimal" {
  listener_id      = "lst-z9y8x7w6"
  load_balancer_id = "alb-m5n6o7p8"

  rules = [{
    actions = [{
      order     = 1
      type      = "FixedResponse"
      fixed_response_config = {
        http_code    = 404
        content      = "not found"
        content_type = "text/plain"
      }
    }]
  }]
}

output "example_rule_id" {
  value = tencentcloud_alb_listener.example.id
}

output "minimal_rule_ids" {
  value = [for r in tencentcloud_alb_listener.minimal.rules : r.rule_id]
}
