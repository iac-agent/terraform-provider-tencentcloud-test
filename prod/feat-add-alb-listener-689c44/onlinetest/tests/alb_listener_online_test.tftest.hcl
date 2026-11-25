run "apply_alb_listener" {
  command = apply

  assert {
    condition     = can(regex("^lst-[0-9A-Za-z]{8}$", tencentcloud_alb_listener.example.id))
    error_message = "listener id should be lst- followed by 8 alphanumeric characters, got: ${tencentcloud_alb_listener.example.id}"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.load_balancer_id == var.load_balancer_id
    error_message = "load_balancer_id should echo the configured load balancer"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_port == var.listener_port
    error_message = "listener_port should match the configured port, got: ${tencentcloud_alb_listener.example.listener_port}"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_protocol == "HTTP"
    error_message = "listener_protocol should be HTTP, got: ${tencentcloud_alb_listener.example.listener_protocol}"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_name == local.listener_name
    error_message = "listener_name should match the configured name, got: ${tencentcloud_alb_listener.example.listener_name}"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.gzip_enabled == true
    error_message = "gzip_enabled should be true, got: ${tencentcloud_alb_listener.example.gzip_enabled}"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.idle_timeout == 60
    error_message = "idle_timeout should be read back as 60, got: ${tencentcloud_alb_listener.example.idle_timeout}"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.request_timeout == 120
    error_message = "request_timeout should be read back as 120, got: ${tencentcloud_alb_listener.example.request_timeout}"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].type == "TargetGroup"
    error_message = "default_actions[0].type should be TargetGroup, got: ${tencentcloud_alb_listener.example.default_actions[0].type}"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].target_group_config.target_groups[0].target_group_id == var.target_group_id
    error_message = "default action should forward to the configured target group"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].target_group_config.target_groups[0].weight == 10
    error_message = "default action target group weight should be 10, got: ${tencentcloud_alb_listener.example.default_actions[0].target_group_config.target_groups[0].weight}"
  }

  assert {
    condition     = length(tencentcloud_alb_listener.example.tags) == 1 && tencentcloud_alb_listener.example.tags[0].tag_key == "createdBy" && tencentcloud_alb_listener.example.tags[0].tag_value == "tf-agentflow"
    error_message = "tags should contain the createdBy=tf-agentflow tag, got: ${jsonencode(tencentcloud_alb_listener.example.tags)}"
  }
}
