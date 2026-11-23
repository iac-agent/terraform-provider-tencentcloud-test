override_resource {
  target = tencentcloud_alb_listener.example
  values = {
    id               = "alb-12345678#lst-87654321"
    load_balancer_id = "alb-12345678"
    listener_port    = 80
    listener_protocol = "HTTP"
    listener_name    = "tf-example"
    idle_timeout     = 30
    request_timeout  = 60
    gzip_enabled     = true
    listener_status  = "Active"
    create_time      = "2025-09-20T10:00:00Z"
    modify_time      = "2025-09-20T10:00:00Z"
  }
}

run "apply_alb_listener" {
  command = apply

  assert {
    condition     = tencentcloud_alb_listener.example.id == "alb-12345678#lst-87654321"
    error_message = "id should be alb-12345678#lst-87654321"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.load_balancer_id == "alb-12345678"
    error_message = "load_balancer_id should be alb-12345678"
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
    condition     = tencentcloud_alb_listener.example.listener_name == "tf-example"
    error_message = "listener_name should be tf-example"
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
    condition     = tencentcloud_alb_listener.example.gzip_enabled == true
    error_message = "gzip_enabled should be true"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_status == "Active"
    error_message = "listener_status should be Active"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.create_time == "2025-09-20T10:00:00Z"
    error_message = "create_time should be 2025-09-20T10:00:00Z"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].type == "Forward"
    error_message = "default_actions[0].type should be Forward"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].target_group_config.target_groups[0].target_group_id == "lbtg-11111111"
    error_message = "target_group_id should be lbtg-11111111"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.tags["createdBy"] == "terraform"
    error_message = "tags[createdBy] should be terraform"
  }
}
