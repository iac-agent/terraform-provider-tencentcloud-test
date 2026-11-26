# Online tests for the tencentcloud_tdmysql_db_engines data source
# (DescribeDBEngines, tdmysql v2021-11-22).
#
# No override_data / mock values are used: the run blocks apply the data block
# against the real cloud API and assert the actual DescribeDBEngines response.
# DescribeDBEngines takes no request parameters, takes no region-sensitive
# inputs, and is a pure read, so a single run covers both the query path and
# the Items element mapping.

run "query_db_engines" {
  command = apply

  assert {
    condition     = length(data.tencentcloud_tdmysql_db_engines.all.items) > 0
    error_message = "DescribeDBEngines should return at least one DB engine version from the real cloud"
  }

  assert {
    condition     = data.tencentcloud_tdmysql_db_engines.all.id != ""
    error_message = "data source id should be a non-empty random token"
  }

  assert {
    condition = alltrue([
      for item in data.tencentcloud_tdmysql_db_engines.all.items :
      item.type != null && item.version != null && item.type != "" && item.version != ""
    ])
    error_message = "every DB engine item should expose non-empty type and version"
  }

  assert {
    condition     = anytrue([for item in data.tencentcloud_tdmysql_db_engines.all.items : item.new])
    error_message = "at least one DB engine version should be flagged as the latest (new = true)"
  }

  assert {
    condition = alltrue([
      for item in data.tencentcloud_tdmysql_db_engines.all.items :
      can(item.name) && can(item.description) && can(item.sql_mode) &&
      can(item.is_support_param_template) && can(item.is_support_serverless) &&
      can(item.is_support_tde) && can(item.is_support_password_complexity)
    ])
    error_message = "every DB engine item should expose the full attribute set: name, description, sql_mode and is_support_* flags"
  }

  assert {
    condition = alltrue([
      for item in data.tencentcloud_tdmysql_db_engines.all.items :
      can(tobool(item.is_support_param_template)) &&
      can(tobool(item.is_support_serverless)) &&
      can(tobool(item.is_support_tde)) &&
      can(tobool(item.is_support_password_complexity))
    ])
    error_message = "is_support_* flags should be real booleans for every DB engine item"
  }

  assert {
    condition = alltrue([
      for item in data.tencentcloud_tdmysql_db_engines.all.items :
      length(item.sql_mode) > 0
    ])
    error_message = "sql_mode should be a non-empty list for every DB engine item"
  }
}
