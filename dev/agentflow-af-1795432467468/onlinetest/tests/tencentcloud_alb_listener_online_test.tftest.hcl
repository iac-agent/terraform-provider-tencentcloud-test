# Online tests for tencentcloud_alb_listener (real cloud API, no mocks).
#
# Creates an HTTP listener on the user-provided ALB load balancer forwarding to
# the user-provided target group, asserts the CreateListener/DescribeListeners
# responses, and destroys the listener afterwards (no residue left).

run "create_alb_listener" {
  command = apply

  assert {
    condition     = can(regex("^lst-[0-9a-zA-Z]{8}$", tencentcloud_alb_listener.online.id))
    error_message = "listener id should be a ListenerId in the format lst- followed by 8 alphanumeric characters"
  }

  assert {
    condition     = tencentcloud_alb_listener.online.load_balancer_id == var.load_balancer_id
    error_message = "load_balancer_id should match the configured load balancer"
  }

  assert {
    condition     = tencentcloud_alb_listener.online.listener_port == var.listener_port
    error_message = "listener_port should match the configured port"
  }

  assert {
    condition     = tencentcloud_alb_listener.online.listener_protocol == var.listener_protocol
    error_message = "listener_protocol should match the configured protocol"
  }

  assert {
    condition     = tencentcloud_alb_listener.online.listener_name == "${var.listener_name_prefix}-tfagentflow"
    error_message = "listener_name should match the configured name with unique suffix"
  }

  assert {
    condition     = tencentcloud_alb_listener.online.idle_timeout == var.idle_timeout
    error_message = "idle_timeout should match the configured idle timeout"
  }

  assert {
    condition     = tencentcloud_alb_listener.online.request_timeout == var.request_timeout
    error_message = "request_timeout should match the configured request timeout"
  }

  assert {
    condition     = length(tencentcloud_alb_listener.online.default_actions) == 1 && tencentcloud_alb_listener.online.default_actions[0].type == "TargetGroup"
    error_message = "default_actions should contain one action of type TargetGroup"
  }
}
