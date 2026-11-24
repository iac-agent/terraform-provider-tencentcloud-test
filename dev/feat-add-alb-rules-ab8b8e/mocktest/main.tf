provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

resource "tencentcloud_alb_rules" "example" {
  load_balancer_id = "alb-12345678"
  listener_id      = "lst-12345678"

  rules = [{
    priority  = 1
    direction = "Request"
    rule_name = "tf-rule-example"

    conditions = [
      {
        type        = "Host"
        host_config = ["www.example.com"]
      },
      {
        type        = "Path"
        path_config = ["/api"]
      }
    ]

    actions = [
      {
        order = 10
        type  = "InsertHeader"
        insert_header_config = [{
          key        = "x-tf-header"
          value      = "terraform"
          value_type = "UserDefined"
        }]
      },
      {
        order = 20
        type  = "TargetGroup"
        target_group_config = [{
          target_groups = [{
            target_group_id = "lbtg-12345678"
            weight          = 10
          }]
          target_group_sticky_session = [{
            enabled = false
          }]
        }]
      }
    ]

    tags = [{
      tag_key   = "env"
      tag_value = "test"
    }]
  }]
}
