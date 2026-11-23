override_resource {
  target = tencentcloud_alb_listener.example
  values = {
    id               = "lst-87654321"
    listener_id      = "lst-87654321"
    listener_status  = "Active"
    listener_port    = 80
    listener_protocol = "HTTP"
    listener_name    = "tf-test-alb-listener"
    gzip_enabled     = true
    idle_timeout     = 15
    request_timeout  = 60
  }
}

run "create_alb_listener" {
  command = apply

  assert {
    condition     = tencentcloud_alb_listener.example.id == "lst-87654321"
    error_message = "listener id should be lst-87654321"
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
    condition     = tencentcloud_alb_listener.example.listener_name == "tf-test-alb-listener"
    error_message = "listener_name should be the configured value"
  }
}
