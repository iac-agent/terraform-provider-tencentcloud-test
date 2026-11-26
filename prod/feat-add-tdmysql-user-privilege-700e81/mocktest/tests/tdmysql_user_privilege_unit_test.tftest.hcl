# Mock tests for the tencentcloud_tdmysql_user_privilege config resource
# (ModifyUserPrivileges write path / DescribeUserPrivileges read-back,
# tdmysql v2021-11-22).
#
# The overrides mock the DescribeUserPrivileges read-back: the provider builds
# the composite id "instance_id#host#user_name#db_name" after create and always
# refreshes the privileges list from the cloud. Mocked values are self-invented
# placeholders and never bypass the assertions.

override_resource {
  target = tencentcloud_tdmysql_user_privilege.global
  values = {
    id          = "tdsql3-mock0001#10.0.0.%#tf_user#*"
    instance_id = "tdsql3-mock0001"
    host        = "10.0.0.%"
    user_name   = "tf_user"
    db_name     = "*"
    privileges  = ["SELECT", "INSERT"]
  }
}

override_resource {
  target = tencentcloud_tdmysql_user_privilege.database
  values = {
    id          = "tdsql3-mock0001#10.0.0.%#tf_user#tf_db"
    instance_id = "tdsql3-mock0001"
    host        = "10.0.0.%"
    user_name   = "tf_user"
    db_name     = "tf_db"
    object_type = "*"
    privileges  = ["SELECT", "UPDATE", "DELETE"]
  }
}

override_resource {
  target = tencentcloud_tdmysql_user_privilege.table
  values = {
    id          = "tdsql3-mock0002#192.168.1.10#tf_table_user#tf_db"
    instance_id = "tdsql3-mock0002"
    host        = "192.168.1.10"
    user_name   = "tf_table_user"
    db_name     = "tf_db"
    object_type = "table"
    object      = "tf_table"
    privileges  = ["SELECT", "INSERT"]
  }
}

run "create_global_privileges" {
  command = apply

  assert {
    condition     = tencentcloud_tdmysql_user_privilege.global.id == "tdsql3-mock0001#10.0.0.%#tf_user#*"
    error_message = "id should be the composite instance_id#host#user_name#db_name built by the provider"
  }

  assert {
    condition     = tencentcloud_tdmysql_user_privilege.global.instance_id == "tdsql3-mock0001" && tencentcloud_tdmysql_user_privilege.global.host == "10.0.0.%" && tencentcloud_tdmysql_user_privilege.global.user_name == "tf_user"
    error_message = "instance_id / host / user_name should keep the configured values"
  }

  assert {
    condition     = tencentcloud_tdmysql_user_privilege.global.db_name == "*"
    error_message = "db_name should stay \"*\" for the global privileges scope (*.*)"
  }

  assert {
    condition     = tencentcloud_tdmysql_user_privilege.global.privileges == tolist(["SELECT", "INSERT"])
    error_message = "privileges should be the mocked cloud read-back list for the global scope"
  }
}

run "create_database_privileges" {
  command = apply

  assert {
    condition     = tencentcloud_tdmysql_user_privilege.database.id == "tdsql3-mock0001#10.0.0.%#tf_user#tf_db"
    error_message = "id should be the composite instance_id#host#user_name#db_name built by the provider"
  }

  assert {
    condition     = tencentcloud_tdmysql_user_privilege.database.db_name == "tf_db" && tencentcloud_tdmysql_user_privilege.database.object_type == "*"
    error_message = "db_name and object_type should keep the configured values for the database scope (db.*)"
  }

  assert {
    condition     = tencentcloud_tdmysql_user_privilege.database.privileges == tolist(["SELECT", "UPDATE", "DELETE"])
    error_message = "privileges should be the mocked cloud read-back list for the database scope"
  }
}

run "create_table_privileges" {
  command = apply

  assert {
    condition     = tencentcloud_tdmysql_user_privilege.table.id == "tdsql3-mock0002#192.168.1.10#tf_table_user#tf_db"
    error_message = "id should be the composite instance_id#host#user_name#db_name built by the provider"
  }

  assert {
    condition     = tencentcloud_tdmysql_user_privilege.table.object_type == "table" && tencentcloud_tdmysql_user_privilege.table.object == "tf_table"
    error_message = "object_type and object should keep the configured values for the table scope"
  }

  assert {
    condition     = tencentcloud_tdmysql_user_privilege.table.privileges == tolist(["SELECT", "INSERT"])
    error_message = "privileges should be the mocked cloud read-back list for the table scope"
  }
}
