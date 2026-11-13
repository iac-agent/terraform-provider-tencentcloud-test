provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

resource "tencentcloud_cls_ckafka_consumer" "example" {
  topic_id     = "topic-12345678"
  need_content = true

  content {
    enable_tag          = true
    meta_fields         = ["__SOURCE__", "__FILENAME__"]
    tag_json_not_tiled  = true
    timestamp_accuracy  = 2
    json_type           = 1
    auto_convert_number = true
  }

  role_arn    = "qcs::cam::uin/100000000001:roleName/tf-test-role"
  external_id = "tf-test-external-id"

  advanced_config {
    partition_hash_status = true
    partition_fields      = ["field_a", "field_b"]
  }

  dsl_filter = "level=ERROR"

  ckafka {
    vip           = "10.0.0.1"
    vport         = "9092"
    instance_id   = "ckafka-test-instance"
    instance_name = "tf-test-instance"
    topic_id      = "ckafka-topic-1234"
    topic_name    = "tf-test-topic"
  }

  compression = 3
}

import {
  to = tencentcloud_cls_ckafka_consumer.example
  id = "topic-12345678"
}
