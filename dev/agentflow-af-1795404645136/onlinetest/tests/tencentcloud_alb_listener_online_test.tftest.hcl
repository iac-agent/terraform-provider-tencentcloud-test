run "apply_alb_listener" {
  command = apply

  assert {
    condition     = can(regex("^lst-[0-9a-zA-Z]{8}$", tencentcloud_alb_listener.example.listener_id))
    error_message = "listener_id should match lst- followed by 8 alphanumeric characters, got: ${tencentcloud_alb_listener.example.listener_id}"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.id == "${var.load_balancer_id}#${tencentcloud_alb_listener.example.listener_id}"
    error_message = "id should be the composite of load_balancer_id and listener_id joined by '#', got: ${tencentcloud_alb_listener.example.id}"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.load_balancer_id == var.load_balancer_id
    error_message = "load_balancer_id should echo the configured load balancer"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_port == var.listener_port
    error_message = "listener_port should echo the configured port"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_protocol == "HTTP"
    error_message = "listener_protocol should be HTTP"
  }

  assert {
    condition     = can(regex("^${var.listener_name_prefix}-tfagentflow-", tencentcloud_alb_listener.example.listener_name))
    error_message = "listener_name should start with the configured prefix, got: ${tencentcloud_alb_listener.example.listener_name}"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].type == "Forward"
    error_message = "default_actions[0].type should be Forward"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].target_group_config.target_groups[0].target_group_id == var.target_group_id
    error_message = "default_actions[0].target_group_config.target_groups[0].target_group_id should echo the configured target group"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].target_group_config.target_group_sticky_session.enabled == true
    error_message = "target_group_sticky_session.enabled should be true"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.idle_timeout == 30 && tencentcloud_alb_listener.example.request_timeout == 60
    error_message = "idle_timeout should be 30 and request_timeout should be 60"
  }
}
