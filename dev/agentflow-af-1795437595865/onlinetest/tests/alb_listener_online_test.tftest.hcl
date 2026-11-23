run "apply_alb_listener" {
  command = apply

  assert {
    condition     = length(tencentcloud_alb_listener.example.id) > 0
    error_message = "listener id should not be empty"
  }

  assert {
    condition     = strcontains(tencentcloud_alb_listener.example.id, var.load_balancer_id)
    error_message = "listener id should contain the load balancer id"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_status == "Active"
    error_message = "listener_status should be Active after creation"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_name == local.listener_name
    error_message = "listener_name should match the configured name"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_port == var.listener_port
    error_message = "listener_port should match the configured port"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_protocol == "HTTP"
    error_message = "listener_protocol should be HTTP"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.idle_timeout == 30
    error_message = "idle_timeout should be 30"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.request_timeout == 60
    error_message = "request_timeout should be 60"
  }
}
