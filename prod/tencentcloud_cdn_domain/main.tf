provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

resource "tencentcloud_cdn_domain" "example" {
  domain                 = "example-cdn-domain.com"
  service_type           = "web"
  project_id             = 0
  area                   = "mainland"
  range_origin_switch    = "on"
  ipv6_access_switch     = "off"
  follow_redirect_switch = "on"

  tags = {
    "createdBy" = "terraform"
  }

  origin {
    origin_type          = "ip"
    origin_list          = ["1.2.3.4", "5.6.7.8"]
    server_name          = "example-origin.com"
    cos_private_access   = "off"
    origin_pull_protocol = "http"

    backup_origin_type = "domain"
    backup_origin_list = ["backup.example-origin.com"]
    backup_server_name = "backup.example-origin.com"

    path_rules {
      full_match  = false
      path        = "/images/*"
      server_name = "path-origin.example.com"
      forward_uri = "/newimages/$1"
    }

    path_based_origin {
      rule_type  = "directory"
      rule_paths = ["/static/"]
      origin     = ["1.2.3.4"]
    }

    path_based_origin {
      rule_type  = "file"
      rule_paths = ["jpg", "png"]
      origin     = ["5.6.7.8"]
    }
  }

  https_config {
    https_switch         = "on"
    http2_switch         = "on"
    ocsp_stapling_switch = "off"
    verify_client        = "off"

    server_certificate_config {
      certificate_id      = "cert-123456"
      certificate_content = "-----BEGIN CERTIFICATE-----\nMIIB\n-----END CERTIFICATE-----"
      private_key         = "-----BEGIN PRIVATE KEY-----\nMIIB\n-----END PRIVATE KEY-----"
      message             = "test certificate"
    }

    force_redirect {
      switch               = "on"
      redirect_type        = "https"
      redirect_status_code = 301
      carry_headers        = "off"
    }

    tls_versions = ["TLSv1", "TLSv1.1", "TLSv1.2", "TLSv1.3"]
  }
}

import {
  to = tencentcloud_cdn_domain.example
  id = "example-cdn-domain.com"
}
