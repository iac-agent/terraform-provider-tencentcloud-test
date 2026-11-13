override_resource {
  target = tencentcloud_ioa_delivery_server.example
  values = {
    id = "123456"
    data = {
      id                     = 123456
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
      target_http_url        = "http://10.0.2.1:8080/logs"
      target_http_timeout    = 3000
      connector_group_id     = "cg-12345"
      connector_group_name   = "tf-test-connector-group"
      kafka_ssl_enable       = true
      ssl_skip_verify        = true
    }
  }
}

run "apply_ioa_delivery_server" {
  command = apply

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.id == "123456"
    error_message = "id should be 123456"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.data.id == null
    error_message = "computed-only nested data.id cannot be overridden and should stay null"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.data.name == "tf-test-delivery-server"
    error_message = "data.name should be tf-test-delivery-server"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.data.type == 4
    error_message = "data.type should be 4"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.data.description == "created by terraform test"
    error_message = "data.description should be created by terraform test"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.data.target_syslog_address == "10.0.0.1"
    error_message = "data.target_syslog_address should be 10.0.0.1"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.data.target_syslog_protocol == "TCP"
    error_message = "data.target_syslog_protocol should be TCP"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.data.target_syslog_port == 514
    error_message = "data.target_syslog_port should be 514"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.data.syslog_facility == "LOCAL0"
    error_message = "data.syslog_facility should be LOCAL0"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.data.target_kafka_address == "10.0.1.1:9092"
    error_message = "data.target_kafka_address should be 10.0.1.1:9092"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.data.target_kafka_topic == "tf-test-topic"
    error_message = "data.target_kafka_topic should be tf-test-topic"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.data.kafka_version == "2.8.0"
    error_message = "data.kafka_version should be 2.8.0"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.data.kafka_sasl_user_name == "tf-test-user"
    error_message = "data.kafka_sasl_user_name should be tf-test-user"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.data.kafka_sasl_password == "tf-test-password"
    error_message = "write-only data.kafka_sasl_password keeps its config value during terraform test runs"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.data.target_http_url == "http://10.0.2.1:8080/logs"
    error_message = "data.target_http_url should be http://10.0.2.1:8080/logs"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.data.target_http_timeout == 3000
    error_message = "data.target_http_timeout should be 3000"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.data.connector_group_id == "cg-12345"
    error_message = "data.connector_group_id should be cg-12345"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.data.connector_group_name == "tf-test-connector-group"
    error_message = "data.connector_group_name should be tf-test-connector-group"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.data.kafka_ssl_enable == true
    error_message = "data.kafka_ssl_enable should be true"
  }

  assert {
    condition     = tencentcloud_ioa_delivery_server.example.data.ssl_skip_verify == true
    error_message = "data.ssl_skip_verify should be true"
  }
}
