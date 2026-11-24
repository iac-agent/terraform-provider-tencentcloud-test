provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

resource "tencentcloud_teo_security_policy_config" "example" {
  zone_id = "zone-mock001"
  entity  = "ZoneDefaultPolicy"

  security_policy {
    rate_limiting_rules {
      rules {
        name                  = "rate-limit-mock-1"
        condition             = "$${http.request.uri.path} eq '/login'"
        mode                  = "Throttle"
        max_request_threshold = 100
        counting_period       = "60s"
        enabled               = "on"
        action {
          name = "Monitor"
        }
      }
    }
  }
}
