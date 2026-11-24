provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# Configure the site-level (ZoneDefaultPolicy) security policy with one precise
# rate limiting rule whose `mode` field is the parameter under test
# (agentflow-af-1795490728279, source API DescribeSecurityPolicy).
resource "tencentcloud_teo_security_policy_config" "example" {
  zone_id = var.zone_id
  entity  = "ZoneDefaultPolicy"

  security_policy {
    rate_limiting_rules {
      rules {
        name                  = "tf-agentflow-rate-limit-mode"
        condition             = "$${http.request.uri.path} eq '/tf-agentflow-probe'"
        mode                  = var.rate_limit_mode
        max_request_threshold = 100
        counting_period       = "60s"
        enabled               = "on"
        priority              = 0
        action {
          name = "Monitor"
        }
      }
    }
  }
}
