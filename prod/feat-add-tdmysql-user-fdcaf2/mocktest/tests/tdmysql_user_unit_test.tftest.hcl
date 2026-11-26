# Mock tests for the tencentcloud_tdmysql_user resource
# (CreateUsers / DescribeUsers / DeleteUsers, tdmysql v2021-11-22).
#
# The override mocks the DescribeUsers read-back item for the user matched by
# (user_name, host); id is the composite "instance_id#user_name#host" the
# provider builds after create. All mocked values are self-invented placeholders
# and never bypass the assertions.

override_resource {
  target = tencentcloud_tdmysql_user.plain
  values = {
    id          = "tdsqlc-mock0001#tf_user#10.0.0.%"
    instance_id = "tdsqlc-mock0001"
    user_name   = "tf_user"
    host        = "10.0.0.%"
    description = null
    create_time = "2025-09-20 10:00:00"
    update_time = "2025-09-20 10:00:00"
  }
}

override_resource {
  target = tencentcloud_tdmysql_user.described
  values = {
    id          = "tdsqlc-mock0002#tf_user_desc#192.168.1.10"
    instance_id = "tdsqlc-mock0002"
    user_name   = "tf_user_desc"
    host        = "192.168.1.10"
    description = "created by terraform mock test"
    create_time = "2025-09-20 11:00:00"
    update_time = "2025-09-20 11:05:00"
  }
}

run "create_user_plain" {
  command = apply

  assert {
    condition     = tencentcloud_tdmysql_user.plain.id == "tdsqlc-mock0001#tf_user#10.0.0.%"
    error_message = "id should be the composite instance_id#user_name#host built by the provider"
  }

  assert {
    condition     = tencentcloud_tdmysql_user.plain.instance_id == "tdsqlc-mock0001" && tencentcloud_tdmysql_user.plain.user_name == "tf_user" && tencentcloud_tdmysql_user.plain.host == "10.0.0.%"
    error_message = "instance_id / user_name / host should keep the configured values"
  }

  assert {
    condition     = tencentcloud_tdmysql_user.plain.description == null
    error_message = "description should stay null when it is not configured"
  }

  assert {
    condition     = tencentcloud_tdmysql_user.plain.create_time == "2025-09-20 10:00:00" && tencentcloud_tdmysql_user.plain.update_time == "2025-09-20 10:00:00"
    error_message = "create_time / update_time should be the mocked cloud values"
  }

  assert {
    condition     = tencentcloud_tdmysql_user.plain.password == "MockPassw0rd!"
    error_message = "password should keep the configured (sensitive) value in state"
  }
}

run "create_user_with_description" {
  command = apply

  assert {
    condition     = tencentcloud_tdmysql_user.described.id == "tdsqlc-mock0002#tf_user_desc#192.168.1.10"
    error_message = "id should be the composite instance_id#user_name#host built by the provider"
  }

  assert {
    condition     = tencentcloud_tdmysql_user.described.description == "created by terraform mock test"
    error_message = "description should keep the configured value after the read-back"
  }

  assert {
    condition     = tencentcloud_tdmysql_user.described.create_time == "2025-09-20 11:00:00" && tencentcloud_tdmysql_user.described.update_time == "2025-09-20 11:05:00"
    error_message = "create_time / update_time should be the mocked cloud values"
  }
}
