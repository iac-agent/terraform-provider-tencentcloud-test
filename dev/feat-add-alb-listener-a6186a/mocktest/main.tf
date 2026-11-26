provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# tencentcloud_alb_listener manages the forwarding rules of an existing ALB
# listener. The resource id is the RuleId returned by DescribeRules.
resource "tencentcloud_alb_listener" "example" {
  listener_id      = "lst-a1b2c3d4"
  load_balancer_id = "alb-e5f6g7h8"

  rules = [{
    priority  = 10
    rule_name = "tf-mock-rule"
    direction = "Request"

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

    conditions = [{ type = "Host", host_config = ["www.example.com"] }]

    tags = [{ tag_key = "env", tag_value = "mocktest" }]
  }]
}

# Second listener: a Redirect action rule, covering ModifyRulesAttributes and
# DeleteRules targeting a distinct RuleId.
resource "tencentcloud_alb_listener" "redirect" {
  listener_id      = "lst-z9y8x7w6"
  load_balancer_id = "alb-m5n6o7p8"

  rules = [{
    priority  = 20
    rule_name = "tf-mock-redirect-rule"

    actions = [{
      order = 1
      type  = "Redirect"
      redirect_config = {
        http_code = 302
        host      = "www.example.com"
        path      = "/new"
        port      = "443"
        protocol  = "HTTPS"
      }
    }]

    conditions = [{ type = "Path", path_config = ["/old"] }]
  }]
}
