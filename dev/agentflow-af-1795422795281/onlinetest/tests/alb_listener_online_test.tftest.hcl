run "apply_alb_listener_online" {
  command = apply

  assert {
    condition     = tencentcloud_alb_listener.example.id != ""
    error_message = "listener id should not be empty"
  }

  assert {
    condition     = can(regex("^lst-[0-9a-zA-Z]{8}$", tencentcloud_alb_listener.example.id))
    error_message = "listener id should be in format lst-xxxxxxxx, got ${tencentcloud_alb_listener.example.id}"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_name == "${var.name_prefix}-tfagentflow"
    error_message = "listener_name should match <name_prefix>-tfagentflow"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_port == var.listener_port
    error_message = "listener_port should match the configured port"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_protocol == var.listener_protocol
    error_message = "listener_protocol should match the configured protocol"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].target_group_config[0].target_groups[0].target_group_id == var.target_group_id
    error_message = "default action target group id should match the configured target group"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.idle_timeout == 60
    error_message = "idle_timeout should be 60"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.request_timeout == 120
    error_message = "request_timeout should be 120"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.tags[0].tag_key == "createdBy"
    error_message = "tags[0].tag_key should be createdBy"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.tags[0].tag_value == "tfagentflow"
    error_message = "tags[0].tag_value should be tfagentflow"
  }
}
