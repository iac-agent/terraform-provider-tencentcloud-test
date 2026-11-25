provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

resource "tencentcloud_teo_custom_group" "example" {
  zone_id    = "zone-27h0vbm5w1e"
  group_name = "tf-test-teo-custom-group"
  group_type = "TLSFingerprint"

  group_items = [
    {
      content   = "cd08b7ecb0e6f5a72c6f5a8ea17e2e5a"
      item_type = "JA3"
    },
    {
      content   = "t13d1714h2_8daaf6b1a14185f4"
      item_type = "JA4"
    },
  ]
}

import {
  to = tencentcloud_teo_custom_group.example
  id = "zone-27h0vbm5w1e#cg-2qbzqqti0e9z"
}
