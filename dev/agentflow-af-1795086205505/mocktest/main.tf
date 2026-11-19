provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

resource "tencentcloud_teo_inference_domain" "example" {
  zone_id     = "zone-3v0yhgt4m1z9"
  service_id  = "inf-vs06pb1cdz61"
  domain      = "test-ai.eo.cn"
  auth_switch = "On"
}
