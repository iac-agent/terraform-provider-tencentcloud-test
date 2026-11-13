override_resource {
  target = tencentcloud_cdn_domain.example
  values = {
    domain       = "example-cdn-domain.com"
    service_type = "web"
    project_id   = 0
    area         = "mainland"
    cname        = "example-cdn-domain.com.cdn.dnsv1.com"
    status       = "online"
  }
}

run "apply_cdn_domain" {
  command = apply

  assert {
    condition     = tencentcloud_cdn_domain.example.domain == "example-cdn-domain.com"
    error_message = "domain should be example-cdn-domain.com"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.service_type == "web"
    error_message = "service_type should be web"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.project_id == 0
    error_message = "project_id should be 0"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.area == "mainland"
    error_message = "area should be mainland"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.range_origin_switch == "on"
    error_message = "range_origin_switch should be on"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.follow_redirect_switch == "on"
    error_message = "follow_redirect_switch should be on"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.origin[0].origin_type == "ip"
    error_message = "origin[0].origin_type should be ip"
  }

  assert {
    condition     = length(tencentcloud_cdn_domain.example.origin[0].origin_list) == 2
    error_message = "origin[0].origin_list should have 2 items"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.origin[0].server_name == "example-origin.com"
    error_message = "origin[0].server_name should be example-origin.com"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.origin[0].origin_pull_protocol == "http"
    error_message = "origin[0].origin_pull_protocol should be http"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.origin[0].backup_origin_type == "domain"
    error_message = "origin[0].backup_origin_type should be domain"
  }

  assert {
    condition     = length(tencentcloud_cdn_domain.example.origin[0].path_rules) == 1
    error_message = "origin[0].path_rules should have 1 item"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.origin[0].path_rules[0].path == "/images/*"
    error_message = "origin[0].path_rules[0].path should be /images/*"
  }

  assert {
    condition     = length(tencentcloud_cdn_domain.example.origin[0].path_based_origin) == 2
    error_message = "origin[0].path_based_origin should have 2 items"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.origin[0].path_based_origin[0].rule_type == "directory"
    error_message = "path_based_origin[0].rule_type should be directory"
  }

  assert {
    condition     = length(tencentcloud_cdn_domain.example.origin[0].path_based_origin[0].rule_paths) == 1
    error_message = "path_based_origin[0].rule_paths should have 1 item"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.origin[0].path_based_origin[0].rule_paths[0] == "/static/"
    error_message = "path_based_origin[0].rule_paths[0] should be /static/"
  }

  assert {
    condition     = length(tencentcloud_cdn_domain.example.origin[0].path_based_origin[0].origin) == 1
    error_message = "path_based_origin[0].origin should have 1 item"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.origin[0].path_based_origin[0].origin[0] == "1.2.3.4"
    error_message = "path_based_origin[0].origin[0] should be 1.2.3.4"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.origin[0].path_based_origin[1].rule_type == "file"
    error_message = "path_based_origin[1].rule_type should be file"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.origin[0].path_based_origin[1].rule_paths[0] == "jpg"
    error_message = "path_based_origin[1].rule_paths[0] should be jpg"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.origin[0].path_based_origin[1].origin[0] == "5.6.7.8"
    error_message = "path_based_origin[1].origin[0] should be 5.6.7.8"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.https_config[0].https_switch == "on"
    error_message = "https_config[0].https_switch should be on"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.https_config[0].server_certificate_config[0].certificate_id == "cert-123456"
    error_message = "https_config[0].server_certificate_config[0].certificate_id should be cert-123456"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.https_config[0].force_redirect[0].redirect_status_code == 301
    error_message = "https_config[0].force_redirect[0].redirect_status_code should be 301"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.cname == "example-cdn-domain.com.cdn.dnsv1.com"
    error_message = "cname should be example-cdn-domain.com.cdn.dnsv1.com"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.status == "online"
    error_message = "status should be online"
  }
}
