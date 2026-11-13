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

run "import_cls_ckafka_consumer" {
  command = apply

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.topic_id == "topic-12345678"
    error_message = "topic_id should be topic-12345678 after import"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.role_arn == "qcs::cam::uin/100000000001:roleName/tf-test-role"
    error_message = "role_arn should be the imported value"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.external_id == "tf-test-external-id"
    error_message = "external_id should be the imported value"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.dsl_filter == "level=ERROR"
    error_message = "dsl_filter should be the imported value"
  }

  assert {
    condition     = tencentcloud_cls_ckafka_consumer.example.compression == 3
    error_message = "compression should be the imported value"
  }
}
