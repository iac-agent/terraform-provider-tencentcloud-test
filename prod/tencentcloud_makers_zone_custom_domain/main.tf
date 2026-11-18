provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

resource "tencentcloud_makers_zone_custom_domain" "example" {
  zone_id    = "zone-12345678"
  project_id = "0"
  domain     = "www.example.com"
  env        = "Production"
}

import {
  to = tencentcloud_makers_zone_custom_domain.example
  id = "zone-12345678#0#www.example.com"
}
