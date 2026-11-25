override_resource {
  target = tencentcloud_alb_listener.http
  values = {
    id = "lst-12345678"
  }
}

override_resource {
  target = tencentcloud_alb_listener.https
  values = {
    id = "lst-87654321"
  }
}

run "create_http_listener" {
  command = apply

  assert {
    condition     = tencentcloud_alb_listener.http.id == "lst-12345678"
    error_message = "listener id should be the mocked lst- id"
  }

  assert {
    condition     = tencentcloud_alb_listener.http.load_balancer_id == "alb-12345678" && tencentcloud_alb_listener.http.listener_port == 80 && tencentcloud_alb_listener.http.listener_protocol == "HTTP"
    error_message = "load_balancer_id / listener_port / listener_protocol should match the configuration"
  }

  assert {
    condition     = tencentcloud_alb_listener.http.listener_name == "tf-listener-mocktest"
    error_message = "listener_name should match the configuration"
  }

  assert {
    condition     = tencentcloud_alb_listener.http.default_actions[0].type == "TargetGroup" && tencentcloud_alb_listener.http.default_actions[0].target_group_config.target_groups[0].target_group_id == "lbtg-12345678" && tencentcloud_alb_listener.http.default_actions[0].target_group_config.target_groups[0].weight == 20
    error_message = "default action should forward to the configured target group with weight 20"
  }

  assert {
    condition     = tencentcloud_alb_listener.http.default_actions[0].target_group_config.target_group_sticky_session.enabled == true && tencentcloud_alb_listener.http.default_actions[0].target_group_config.target_group_sticky_session.timeout == 200
    error_message = "target group sticky session should keep the configured values"
  }
}

run "create_https_listener" {
  command = apply

  assert {
    condition     = tencentcloud_alb_listener.https.id == "lst-87654321"
    error_message = "listener id should be the mocked lst- id"
  }

  assert {
    condition     = tencentcloud_alb_listener.https.listener_port == 443 && tencentcloud_alb_listener.https.listener_protocol == "HTTPS"
    error_message = "https listener port/protocol should match the configuration"
  }

  assert {
    condition     = tencentcloud_alb_listener.https.default_actions[0].target_group_config.target_groups[0].target_group_id == "lbtg-87654321"
    error_message = "https listener should forward to the configured target group"
  }

  assert {
    condition     = tencentcloud_alb_listener.https.x_forwarded_for_config.x_forwarded_for_mode == "append" && tencentcloud_alb_listener.https.x_forwarded_for_config.x_forwarded_for_port_enabled == true
    error_message = "x_forwarded_for_config should keep the configured values"
  }
}
