override_resource {
  target = tencentcloud_cls_ckafka_consumer.example
  values = {
    topic_id     = "topic-12345678"
    need_content = true
    role_arn     = "qcs::cam::uin/100000000001:roleName/tf-test-role"
    external_id  = "tf-test-external-id"
    dsl_filter   = "level=ERROR"
    compression  = 3
  }
}

run "apply_cls_ckafka_consumer" {
  command = apply

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.topic_id == "topic-12345678"
    error_message = "topic_id should be topic-12345678"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.need_content == true
    error_message = "need_content should be true"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.role_arn == "qcs::cam::uin/100000000001:roleName/tf-test-role"
    error_message = "role_arn should be the configured value"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.external_id == "tf-test-external-id"
    error_message = "external_id should be tf-test-external-id"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.dsl_filter == "level=ERROR"
    error_message = "dsl_filter should be level=ERROR"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.compression == 3
    error_message = "compression should be 3"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.content[0].enable_tag == true
    error_message = "content enable_tag should be true"
  }

  assert {
    condition     = length(tencentcloud_cls_ckafka_consumer.example.content[0].meta_fields) == 2
    error_message = "content meta_fields should contain 2 items"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.content[0].tag_json_not_tiled == true
    error_message = "content tag_json_not_tiled should be true"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.content[0].timestamp_accuracy == 2
    error_message = "content timestamp_accuracy should be 2"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.content[0].json_type == 1
    error_message = "content json_type should be 1"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.content[0].auto_convert_number == true
    error_message = "content auto_convert_number should be true"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.advanced_config[0].partition_hash_status == true
    error_message = "advanced_config partition_hash_status should be true"
  }

  assert {
    condition     = length(tencentcloud_cls_ckafka_consumer.example.advanced_config[0].partition_fields) == 2
    error_message = "advanced_config partition_fields should contain 2 items"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.ckafka[0].vip == "10.0.0.1"
    error_message = "ckafka vip should be 10.0.0.1"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.ckafka[0].vport == "9092"
    error_message = "ckafka vport should be 9092"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.ckafka[0].instance_id == "ckafka-test-instance"
    error_message = "ckafka instance_id should be ckafka-test-instance"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.ckafka[0].instance_name == "tf-test-instance"
    error_message = "ckafka instance_name should be tf-test-instance"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.ckafka[0].topic_id == "ckafka-topic-1234"
    error_message = "ckafka topic_id should be ckafka-topic-1234"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.ckafka[0].topic_name == "tf-test-topic"
    error_message = "ckafka topic_name should be tf-test-topic"
  }
}
