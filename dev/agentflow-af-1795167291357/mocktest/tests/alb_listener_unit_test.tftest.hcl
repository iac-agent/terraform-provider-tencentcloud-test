override_resource {
  target = tencentcloud_alb_listener.http_example
  values = {
    id                = "alb-12345678#lst-aaaa1111"
    load_balancer_id  = "alb-12345678"
    listener_port     = 80
    listener_protocol = "HTTP"
    listener_name     = "tf-mock-http"
    gzip_enabled      = true
    idle_timeout      = 15
  }
}

override_resource {
  target = tencentcloud_alb_listener.https_example
  values = {
    id                 = "alb-12345678#lst-bbbb2222"
    load_balancer_id   = "alb-12345678"
    listener_port      = 443
    listener_protocol  = "HTTPS"
    listener_name      = "tf-mock-https"
    certificate_ids    = ["cert-12345678"]
    security_policy_id = "tls-12345678"
    http2enabled       = true
  }
}

run "apply_http_listener" {
  command = apply

  assert {
    condition     = tencentcloud_alb_listener.http_example.id == "alb-12345678#lst-aaaa1111"
    error_message = "id should be loadBalancerId#listenerId combined form"
  }

  assert {
    condition     = tencentcloud_alb_listener.http_example.listener_port == 80 && tencentcloud_alb_listener.http_example.listener_protocol == "HTTP"
    error_message = "listener_port/listener_protocol should keep configured values"
  }

  assert {
    condition     = tencentcloud_alb_listener.http_example.default_actions[0].type == "Forward"
    error_message = "default action type should be Forward"
  }

  assert {
    condition     = tencentcloud_alb_listener.http_example.default_actions[0].target_group_config[0].target_groups[0].target_group_id == "lbtg-12345678"
    error_message = "target_group_id should be lbtg-12345678"
  }

  assert {
    condition     = tencentcloud_alb_listener.http_example.gzip_enabled == true
    error_message = "gzip_enabled should be true"
  }
}

run "apply_https_listener" {
  command = apply

  assert {
    condition     = tencentcloud_alb_listener.https_example.id == "alb-12345678#lst-bbbb2222"
    error_message = "id should be alb-12345678#lst-bbbb2222"
  }

  assert {
    condition     = length(tencentcloud_alb_listener.https_example.certificate_ids) == 1 && tencentcloud_alb_listener.https_example.certificate_ids[0] == "cert-12345678"
    error_message = "certificate_ids should contain cert-12345678"
  }

  assert {
    condition     = tencentcloud_alb_listener.https_example.security_policy_id == "tls-12345678"
    error_message = "security_policy_id should be tls-12345678"
  }

  assert {
    condition     = tencentcloud_alb_listener.https_example.default_actions[0].target_group_config[0].target_group_sticky_session[0].enabled == true && tencentcloud_alb_listener.https_example.default_actions[0].target_group_config[0].target_group_sticky_session[0].timeout == 1200
    error_message = "sticky session should be enabled with timeout 1200"
  }

  assert {
    condition     = tencentcloud_alb_listener.https_example.x_forwarded_for_config[0].x_forwarded_for_mode == "append"
    error_message = "x_forwarded_for_mode should be append"
  }
}
