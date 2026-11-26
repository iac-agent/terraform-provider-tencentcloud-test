# Online tests for the tencentcloud_tdmysql_user resource
# (CreateUsers / DescribeUsers / DeleteUsers, tdmysql v2021-11-22).
#
# No override_resource / mock values are used: the run blocks apply the two
# users against the real cloud API and assert the actual DescribeUsers
# read-back. Both users are created on the instance given by var.instance_id
# and destroyed again at the end of the test, so nothing remains on the
# instance.

run "create_user_plain" {
  command = apply

  assert {
    condition     = tencentcloud_tdmysql_user.plain.id != ""
    error_message = "id should be a non-empty composite id after the create"
  }

  assert {
    condition     = tencentcloud_tdmysql_user.plain.id == "${var.instance_id}#${local.user_plain}#${local.host}"
    error_message = "id should be the composite instance_id#user_name#host built by the provider"
  }

  assert {
    condition     = tencentcloud_tdmysql_user.plain.instance_id == var.instance_id && tencentcloud_tdmysql_user.plain.user_name == local.user_plain && tencentcloud_tdmysql_user.plain.host == local.host
    error_message = "instance_id / user_name / host should keep the configured values after the real cloud read-back"
  }

  assert {
    condition     = tencentcloud_tdmysql_user.plain.description == null
    error_message = "description should stay null when it is not configured"
  }

  assert {
    condition     = tencentcloud_tdmysql_user.plain.create_time != null && tencentcloud_tdmysql_user.plain.create_time != ""
    error_message = "create_time should be the real cloud creation time, non-empty"
  }

  assert {
    condition     = tencentcloud_tdmysql_user.plain.update_time != null && tencentcloud_tdmysql_user.plain.update_time != ""
    error_message = "update_time should be the real cloud update time, non-empty"
  }
}

run "create_user_with_description" {
  command = apply

  assert {
    condition     = tencentcloud_tdmysql_user.described.id == "${var.instance_id}#${local.user_desc}#${local.host}"
    error_message = "id should be the composite instance_id#user_name#host built by the provider"
  }

  assert {
    condition     = tencentcloud_tdmysql_user.described.description == var.user_description
    error_message = "description should keep the configured value after the real cloud read-back"
  }

  assert {
    condition     = tencentcloud_tdmysql_user.described.create_time != null && tencentcloud_tdmysql_user.described.create_time != ""
    error_message = "create_time should be the real cloud creation time, non-empty"
  }

  assert {
    condition     = tencentcloud_tdmysql_user.described.update_time != null && tencentcloud_tdmysql_user.described.update_time != ""
    error_message = "update_time should be the real cloud update time, non-empty"
  }
}
