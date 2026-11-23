run "create_alb_listener_online" {
  command = apply

  assert {
    condition     = can(regex("^lst-[0-9a-zA-Z]{8}$", tencentcloud_alb_listener.tfagentflow.id))
    error_message = "listener id should match lst- followed by 8 alphanumeric characters, got ${tencentcloud_alb_listener.tfagentflow.id}"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.listener_id == tencentcloud_alb_listener.tfagentflow.id
    error_message = "listener_id should equal the resource id"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.listener_name == "${var.listener_name_prefix}-lst"
    error_message = "listener_name should be the configured value ${var.listener_name_prefix}-lst"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.listener_port == var.listener_port
    error_message = "listener_port should equal the configured port"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.listener_protocol == var.listener_protocol
    error_message = "listener_protocol should equal the configured protocol"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.load_balancer_id == var.load_balancer_id
    error_message = "load_balancer_id should equal the configured instance id"
  }

  assert {
    condition     = tencentcloud_alb_listener.tfagentflow.listener_status == "Active" || tencentcloud_alb_listener.tfagentflow.listener_status == "Provisioning"
    error_message = "listener_status should be Active or Provisioning, got ${tencentcloud_alb_listener.tfagentflow.listener_status}"
  }
}
