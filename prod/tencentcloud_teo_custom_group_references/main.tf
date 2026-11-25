provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

data "tencentcloud_teo_custom_group_references" "example" {
  zone_id  = "zone-3fkff38fyw8s"
  group_id = "cg-2q1pkwfyagzz"
}

data "tencentcloud_teo_custom_group_references" "second" {
  zone_id  = "zone-9k3gq2xvpl0m"
  group_id = "cg-8r5tjzcewm2y"
}
