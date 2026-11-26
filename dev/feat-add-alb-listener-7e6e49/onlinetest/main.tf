provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

locals {
  # Unique suffix keeps the rule name distinct from any pre-existing rule.
  rule_name_suffix = formatdate("MMDDhhmmss", timestamp())
  rule_name        = "${var.rule_name_prefix}-tfagentflow-${local.rule_name_suffix}"
}

# Only the forwarding rule is created and destroyed by this test. The load
# balancer, listener and target group are disposable prerequisites supplied via
# variables; this configuration neither modifies nor deletes them.
resource "tencentcloud_alb_listener" "tfagentflow" {
  listener_id      = var.listener_id
  load_balancer_id = var.load_balancer_id

  rules = [{
    priority  = 20001
    direction = "Request"
    rule_name = local.rule_name

    conditions = [
      {
        type        = "Host"
        host_config = [var.rule_host]
      },
      {
        type        = "Path"
        path_config = [var.rule_path]
      }
    ]

    actions = [
      {
        order = 1
        type  = "InsertHeader"
        insert_header_config = {
          key        = var.insert_header_key
          value      = var.insert_header_value
          value_type = "UserDefined"
        }
      },
      {
        order = 20
        type  = "TargetGroup"
        target_group_config = {
          target_groups = [{
            target_group_id = var.target_group_id
            weight          = 10
          }]
          target_group_sticky_session = {
            enabled = false
          }
        }
      }
    ]

    tags = [{
      tag_key   = "createdBy"
      tag_value = "tf-agentflow"
    }]
  }]
}
