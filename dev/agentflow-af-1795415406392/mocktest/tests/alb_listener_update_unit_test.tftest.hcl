override_resource {
  target = tencentcloud_alb_listener.example
  values = {
    id              = "lst-87654321"
    listener_id     = "lst-87654321"
    listener_status = "Active"
  }
}

run "update_alb_listener" {
  command = apply

  assert {
    condition     = tencentcloud_alb_listener.example.id == "lst-87654321"
    error_message = "listener id should stay lst-87654321 after update"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_id == "lst-87654321"
    error_message = "listener_id should stay lst-87654321 after update"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_status == "Active"
    error_message = "listener_status should be Active after update"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.load_balancer_id == "alb-12345678"
    error_message = "load_balancer_id should be alb-12345678"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.listener_port == 80
    error_message = "listener_port should be 80"
  }
}
