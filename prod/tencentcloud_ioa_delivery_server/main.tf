provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

resource "tencentcloud_ioa_delivery_server" "example" {
  data = {
    name                   = "tf-test-delivery-server"
    type                   = 4
    description            = "created by terraform test"
    target_syslog_address  = "10.0.0.1"
    target_syslog_protocol = "TCP"
    target_syslog_port     = 514
    syslog_facility        = "LOCAL0"
    target_kafka_address   = "10.0.1.1:9092"
    target_kafka_topic     = "tf-test-topic"
    kafka_version          = "2.8.0"
    kafka_sasl_user_name   = "tf-test-user"
    kafka_sasl_password    = "tf-test-password"
    target_http_url        = "http://10.0.2.1:8080/logs"
    target_http_timeout    = 3000
    connector_group_id     = "cg-12345"
    connector_group_name   = "tf-test-connector-group"
    kafka_ssl_enable       = true
    ssl_skip_verify        = true
  }
}

import {
  to = tencentcloud_ioa_delivery_server.example
  id = "123456"
}
