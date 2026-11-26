# Mock tests for the tencentcloud_tdmysql_db_engines data source
# (DescribeDBEngines, tdmysql v2021-11-22).
#
# Terraform 1.11's override_data cannot build a list-of-object value for a
# framework ListNestedAttribute (it always yields a tuple and fails with
# "expected object type, found tuple", and function calls such as tolist are
# not allowed inside override_data), so the items list is not mocked explicitly
# and stays an empty list; the random-token id is asserted to be non-empty.
# The Items element mapping (type / version / name / description / new /
# sql_mode / is_support_* flags) is covered by Go unit tests in the provider
# repository.

override_data {
  target = data.tencentcloud_tdmysql_db_engines.all
  values = {}
}

run "query_db_engines" {
  command = apply

  assert {
    condition     = data.tencentcloud_tdmysql_db_engines.all.id != ""
    error_message = "data source id should be a non-empty random token"
  }

  assert {
    condition     = can(regex("^[a-z0-9]{8,}$", data.tencentcloud_tdmysql_db_engines.all.id))
    error_message = "data source id should look like a generated alphanumeric token"
  }

  assert {
    condition     = length(data.tencentcloud_tdmysql_db_engines.all.items) == 0
    error_message = "items should be an empty list when it is not mockable via override_data"
  }
}
