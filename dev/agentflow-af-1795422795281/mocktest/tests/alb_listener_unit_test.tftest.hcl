override_resource {
  target = tencentcloud_alb_listener.example
  values = {
    id                 = "alb-mock0001#lst-mock001"
    load_balancer_id   = "alb-mock0001"
    listener_port      = 80
    listener_protocol  = "HTTP"
    listener_name      = "tf-test-listener"
    gzip_enabled       = true
    http2enabled       = false
    idle_timeout       = 60
    request_timeout    = 120
    ca_enabled         = false
    security_policy_id = "tls-mock0001"
    tags = [
      {
        tag_key   = "env"
        tag_value = "test"
      },
    ]
  }
}

run "apply_alb_listener" {
  command = apply

  assert {
    condition     = tencentcloud_alb_listener.example.id == "alb-mock0001#lst-mock001"
    error_message = "id should be alb-mock0001#lst-mock001"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.load_balancer_id == "alb-mock0001"
    error_message = "load_balancer_id should be alb-mock0001"
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
    condition     = tencentcloud_alb_listener.example.listener_name == "tf-test-listener"
    error_message = "listener_name should be tf-test-listener"
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
    condition     = tencentcloud_alb_listener.example.default_actions[0].type == "Forward"
    error_message = "default_actions[0].type should be Forward"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].target_group_config[0].target_groups[0].target_group_id == "lbtg-mock001"
    error_message = "target_group_id should be lbtg-mock001"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].target_group_config[0].target_groups[0].weight == 20
    error_message = "weight should be 20"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].target_group_config[0].target_group_sticky_session[0].enabled == true
    error_message = "sticky session enabled should be true"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].target_group_config[0].target_group_sticky_session[0].timeout == 1000
    error_message = "sticky session timeout should be 1000"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.x_forwarded_for_config[0].x_forwarded_for_mode == "append"
    error_message = "x_forwarded_for_mode should be append"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.tags[0].tag_key == "env"
    error_message = "tags[0].tag_key should be env"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.tags[0].tag_value == "test"
    error_message = "tags[0].tag_value should be test"
  }
}
