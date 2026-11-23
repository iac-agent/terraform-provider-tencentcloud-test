override_resource {
  target = tencentcloud_alb_listener.example
  values = {
    id                = "alb-1234abcd#lst-8765dcba"
    load_balancer_id  = "alb-1234abcd"
    listener_id       = "lst-8765dcba"
    listener_port     = 80
    listener_protocol = "HTTP"
    listener_name     = "tf-mock-listener"
    idle_timeout      = 30
    request_timeout   = 60
    gzip_enabled      = false
  }
}

run "apply_alb_listener" {
  command = apply

  assert {
    condition     = tencentcloud_alb_listener.example.id == "alb-1234abcd#lst-8765dcba"
    error_message = "id should be `load_balancer_id#listener_id` composite id"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_id == "lst-8765dcba"
    error_message = "listener_id should be lst-8765dcba"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.load_balancer_id == "alb-1234abcd"
    error_message = "load_balancer_id should be alb-1234abcd"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_port == 80
    error_message = "listener_port should be 80"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_protocol == "HTTP"
    error_message = "listener_protocol should be HTTP"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_name == "tf-mock-listener"
    error_message = "listener_name should be tf-mock-listener"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].type == "Forward"
    error_message = "default_actions[0].type should be Forward"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].target_group_config.target_groups[0].target_group_id == "lbtg-1234abcd"
    error_message = "default_actions[0].target_group_config.target_groups[0].target_group_id should be lbtg-1234abcd"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].target_group_config.target_group_sticky_session.enabled == true
    error_message = "target_group_sticky_session.enabled should be true"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.idle_timeout == 30
    error_message = "idle_timeout should be 30"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.request_timeout == 60
    error_message = "request_timeout should be 60"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.tags[0].tag_key == "createdBy"
    error_message = "tags[0].tag_key should be createdBy"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.tags[0].tag_value == "terraform"
    error_message = "tags[0].tag_value should be terraform"
  }
}
