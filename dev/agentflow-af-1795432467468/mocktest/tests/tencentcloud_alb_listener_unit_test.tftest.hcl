# Mock tests for the tencentcloud_alb_listener resource (alb v20251030).
#
# The resource id is the ListenerId returned by CreateListener (lst-xxxx).
# override_resource supplies the read-back state that would normally come from
# DescribeListeners; assert checks are self-consistent with those mock values.

override_resource {
  target = tencentcloud_alb_listener.example
  values = {
    id                = "lst-8765dcba"
    load_balancer_id  = "alb-1234abcd"
    listener_port     = 80
    listener_protocol = "HTTP"
    listener_name     = "tf-mock-listener"
    idle_timeout      = 30
    request_timeout   = 60
    gzip_enabled      = false
    tags = [
      {
        tag_key   = "createdBy"
        tag_value = "terraform"
      }
    ]
  }
}

run "apply_alb_listener" {
  command = apply

  assert {
    condition     = tencentcloud_alb_listener.example.id == "lst-8765dcba"
    error_message = "listener id should be the ListenerId lst-8765dcba returned by CreateListener"
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
    condition     = tencentcloud_alb_listener.example.default_actions[0].type == "TargetGroup"
    error_message = "default_actions[0].type should be TargetGroup"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].target_group_config[0].target_groups[0].target_group_id == "lbtg-1234abcd"
    error_message = "default_actions[0].target_group_config[0].target_groups[0].target_group_id should be lbtg-1234abcd"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].target_group_config[0].target_groups[0].weight == 10
    error_message = "default_actions[0].target_group_config[0].target_groups[0].weight should be 10"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].target_group_config[0].target_group_sticky_session[0].enabled == true
    error_message = "target_group_sticky_session[0].enabled should be true"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.default_actions[0].target_group_config[0].target_group_sticky_session[0].timeout == 1000
    error_message = "target_group_sticky_session[0].timeout should be 1000"
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
    condition     = tencentcloud_alb_listener.example.x_forwarded_for_config[0].x_forwarded_for_mode == "append"
    error_message = "x_forwarded_for_config[0].x_forwarded_for_mode should be append"
  }

  assert {
    condition     = tencentcloud_alb_listener.example.tags[0].tag_key == "createdBy" && tencentcloud_alb_listener.example.tags[0].tag_value == "terraform"
    error_message = "tags[0] should be createdBy=terraform"
  }
}
