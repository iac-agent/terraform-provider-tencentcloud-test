# Mock tests for the tencentcloud_tdmysql_sale_info data source
# (DescribeSaleInfo, TDSQL-C for MySQL v20211122).
#
# Terraform 1.11's override_data cannot build a list-of-object value for a
# framework ListNestedAttribute (it always yields a tuple and fails with
# "expected object type, found tuple"; function calls such as tolist() are
# rejected in override values), so region_list is not mocked explicitly and
# stays an empty list; the computed id token and the query-input attributes
# (instance_type / instance_id / src_region) are asserted directly. The nested
# region_list element mapping is covered by Go unit tests in the provider
# repository.

override_data {
  target = data.tencentcloud_tdmysql_sale_info.all
  values = {
    id = "tdmysql-sale-info-mock-all-0001"
  }
}

override_data {
  target = data.tencentcloud_tdmysql_sale_info.serverless
  values = {
    id = "tdmysql-sale-info-mock-serverless-0002"
  }
}

override_data {
  target = data.tencentcloud_tdmysql_sale_info.by_instance
  values = {
    id = "tdmysql-sale-info-mock-instance-0003"
  }
}

run "query_all_sale_info" {
  command = apply

  assert {
    condition     = data.tencentcloud_tdmysql_sale_info.all.id == "tdmysql-sale-info-mock-all-0001"
    error_message = "the data source id should be the mocked token"
  }

  assert {
    condition     = length(data.tencentcloud_tdmysql_sale_info.all.region_list) == 0
    error_message = "region_list should be an empty list when it is not mocked"
  }
}

run "query_serverless_sale_info" {
  command = apply

  assert {
    condition     = data.tencentcloud_tdmysql_sale_info.serverless.id == "tdmysql-sale-info-mock-serverless-0002"
    error_message = "the data source id should be the mocked token"
  }

  assert {
    condition     = data.tencentcloud_tdmysql_sale_info.serverless.instance_type == "serverless"
    error_message = "the instance_type query filter should be kept as configured"
  }

  assert {
    condition     = length(data.tencentcloud_tdmysql_sale_info.serverless.region_list) == 0
    error_message = "region_list should be an empty list when it is not mocked"
  }
}

run "query_sale_info_by_instance" {
  command = apply

  assert {
    condition     = data.tencentcloud_tdmysql_sale_info.by_instance.id == "tdmysql-sale-info-mock-instance-0003"
    error_message = "the data source id should be the mocked token"
  }

  assert {
    condition     = data.tencentcloud_tdmysql_sale_info.by_instance.instance_id == "tdsqlc-mock0001" && data.tencentcloud_tdmysql_sale_info.by_instance.src_region == "ap-guangzhou"
    error_message = "the instance_id / src_region query inputs should be kept as configured"
  }

  assert {
    condition     = length(data.tencentcloud_tdmysql_sale_info.by_instance.region_list) == 0
    error_message = "region_list should be an empty list when it is not mocked"
  }
}
