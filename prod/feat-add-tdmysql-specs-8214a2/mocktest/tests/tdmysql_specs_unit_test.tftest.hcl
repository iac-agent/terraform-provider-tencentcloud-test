# Mock tests for the tencentcloud_tdmysql_specs data source
# (DescribeSpecs, TDSQL Boundless tdmysql v2021-11-22).
#
# Terraform 1.11's override_data cannot build a list-of-object value for a
# framework ListNestedAttribute (it always yields a tuple and fails with
# "expected object type, found tuple"; function calls such as tolist() are
# rejected in override values), so hybrid_node_specs / serverless_ccu_spec /
# serverless_node_num_spec are not mocked explicitly and stay empty lists;
# the scalar query-input attributes and the id are asserted directly. The
# list element mapping is covered by Go unit tests in the provider
# repository.

override_data {
  target = data.tencentcloud_tdmysql_specs.all
  values = {
    id = "mock-tdmysql-specs-all"
  }
}

override_data {
  target = data.tencentcloud_tdmysql_specs.filtered
  values = {
    id                     = "mock-tdmysql-specs-filtered"
    zones                  = ["ap-guangzhou-1", "ap-guangzhou-2"]
    full_replications      = 3
    is_exclusive_instance  = 0
    instance_id            = "tdsqlmock-abcdef"
  }
}

run "query_all_specs" {
  command = apply

  assert {
    condition     = data.tencentcloud_tdmysql_specs.all.id == "mock-tdmysql-specs-all"
    error_message = "data source id should be the mocked token"
  }

  assert {
    condition     = length(data.tencentcloud_tdmysql_specs.all.hybrid_node_specs) == 0
    error_message = "hybrid_node_specs should be an empty list when it is not mocked"
  }

  assert {
    condition     = length(data.tencentcloud_tdmysql_specs.all.serverless_ccu_spec) == 0
    error_message = "serverless_ccu_spec should be an empty list when it is not mocked"
  }

  assert {
    condition     = length(data.tencentcloud_tdmysql_specs.all.serverless_node_num_spec) == 0
    error_message = "serverless_node_num_spec should be an empty list when it is not mocked"
  }
}

run "query_filtered_specs" {
  command = apply

  assert {
    condition     = data.tencentcloud_tdmysql_specs.filtered.id == "mock-tdmysql-specs-filtered"
    error_message = "filtered data source id should be the mocked token"
  }

  assert {
    condition     = data.tencentcloud_tdmysql_specs.filtered.zones == tolist(["ap-guangzhou-1", "ap-guangzhou-2"])
    error_message = "zones should keep the configured availability zone combination"
  }

  assert {
    condition     = data.tencentcloud_tdmysql_specs.filtered.full_replications == 3
    error_message = "full_replications should keep the configured replica number"
  }

  assert {
    condition     = data.tencentcloud_tdmysql_specs.filtered.is_exclusive_instance == 0
    error_message = "is_exclusive_instance should keep the configured exclusive flag"
  }

  assert {
    condition     = data.tencentcloud_tdmysql_specs.filtered.instance_id == "tdsqlmock-abcdef"
    error_message = "instance_id should keep the configured instance id"
  }
}
