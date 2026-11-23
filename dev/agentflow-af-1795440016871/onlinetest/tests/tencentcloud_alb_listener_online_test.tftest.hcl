run "create_alb_listener_online" {
  command = apply

  assert {
    condition     = length(tencentcloud_alb_listener.example.id) > 0
    error_message = "listener id should not be empty after creation"
  }

  assert {
    condition     = can(regex("^alb-[0-9a-zA-Z]{8}#lst-[0-9a-zA-Z]{8}$", tencentcloud_alb_listener.example.id))
    error_message = "listener id should match load_balancer_id#listener_id format (alb-xxxxxxxx#lst-xxxxxxxx)"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_port == var.listener_port
    error_message = "listener port should match the configured value"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_protocol == var.listener_protocol
    error_message = "listener protocol should match the configured value"
  }

  assert {
    condition     = can(regex("^${var.listener_name}-", tencentcloud_alb_listener.example.listener_name))
    error_message = "listener name should start with the configured prefix"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.idle_timeout == var.idle_timeout
    error_message = "idle_timeout should match the configured value"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].target_group_config[0].target_groups[0].target_group_id == var.target_group_id
    error_message = "default action should forward to the configured target group"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.load_balancer_id == var.load_balancer_id
    error_message = "load_balancer_id should match the configured value"
  }
}
