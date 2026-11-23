override_resource {
  target = tencentcloud_alb_listener.example
  values = {
    id                = "alb-12345678#lst-87654321"
    load_balancer_id  = "alb-12345678"
    listener_protocol = "HTTP"
    listener_port     = 80
    listener_name     = "tf-mock-listener"
    idle_timeout      = 30
    request_timeout   = 60
    gzip_enabled      = true
    ca_enabled        = false

    default_actions = [
      {
        type = "Forward"
        target_group_config = [
          {
            target_groups = [
              {
                target_group_id = "lbtg-12345678"
                weight          = 10
              },
            ]
            target_group_sticky_session = [
              {
                enabled = true
                timeout = 1000
              },
            ]
          },
        ]
      },
    ]

    x_forwarded_for_config = [
      {
        x_forwarded_for_mode         = "append"
        x_forwarded_for_host_enabled = true
      },
    ]

    tags = [
      {
        tag_key   = "env"
        tag_value = "test"
      },
    ]
  }
}

run "create_alb_listener_mock" {
  command = apply

  assert {
    condition     = tencentcloud_alb_listener.example.id == "alb-12345678#lst-87654321"
    error_message = "listener id should be alb-12345678#lst-87654321"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.load_balancer_id == "alb-12345678"
    error_message = "load_balancer_id should be alb-12345678"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_protocol == "HTTP" && tencentcloud_alb_listener.example.listener_port == 80
    error_message = "listener protocol/port should be HTTP:80"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].target_group_config[0].target_groups[0].target_group_id == "lbtg-12345678"
    error_message = "default_actions target_group_id should be lbtg-12345678"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].target_group_config[0].target_group_sticky_session[0].enabled == true
    error_message = "target_group_sticky_session.enabled should be true"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.x_forwarded_for_config[0].x_forwarded_for_mode == "append"
    error_message = "x_forwarded_for_mode should be append"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.tags[0].tag_key == "env" && tencentcloud_alb_listener.example.tags[0].tag_value == "test"
    error_message = "tags should be env=test"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.idle_timeout == 30 && tencentcloud_alb_listener.example.request_timeout == 60
    error_message = "idle_timeout/request_timeout should be 30/60"
  }
}
