override_resource {
  target = tencentcloud_cdn_domain.example
  values = {
    domain       = "example-cdn-domain.com"
    service_type = "web"
    area         = "mainland"
    cname        = "example-cdn-domain.com.cdn.dnsv1.com"
    status       = "online"
  }
}

run "import_cdn_domain" {
  command = apply

  assert {
    condition     = tencentcloud_cdn_domain.example.domain == "example-cdn-domain.com"
    error_message = "domain should be example-cdn-domain.com"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.origin[0].path_based_origin[0].rule_type == "directory"
    error_message = "path_based_origin[0].rule_type should be directory"
  }

  assert {
    condition     = tencentcloud_cdn_domain.example.origin[0].path_based_origin[0].rule_paths[0] == "/static/"
    error_message = "path_based_origin[0].rule_paths[0] should be /static/"
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
    condition     = tencentcloud_cdn_domain.example.origin[0].path_based_origin[1].origin[0] == "5.6.7.8"
    error_message = "path_based_origin[1].origin[0] should be 5.6.7.8"
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
