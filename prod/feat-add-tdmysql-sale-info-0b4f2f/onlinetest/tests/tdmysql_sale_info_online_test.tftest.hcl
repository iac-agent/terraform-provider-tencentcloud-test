# Online tests for the tencentcloud_tdmysql_sale_info data source
# (DescribeSaleInfo, TDSQL-C for MySQL v20211122).
#
# The data source is read-only: it only queries DescribeSaleInfo and creates
# no cloud resources, so these tests produce no residue and need no destroy.
# Assertions target the real cloud responses:
#   - unfiltered query returns a well-formed region_list;
#   - instance_type-filtered query (serverless) returns only regions that
#     support serverless;
#   - src_region / instance_id-filtered query returns a well-formed result.
# When the filter variables are left empty the filtered runs only assert
# well-formedness, since the API treats unset values as "no filter".

run "query_all_sale_regions" {
  command = apply

  assert {
    condition     = length(data.tencentcloud_tdmysql_sale_info.all.id) > 0
    error_message = "the data source id (random token) should not be empty"
  }

  assert {
    condition     = can([for it in data.tencentcloud_tdmysql_sale_info.all.region_list : it.region]) && can([for it in data.tencentcloud_tdmysql_sale_info.all.region_list : it.region_name])
    error_message = "every returned region should expose region and region_name"
  }

  assert {
    condition     = alltrue([for it in data.tencentcloud_tdmysql_sale_info.all.region_list : contains([0, 1], it.enable)])
    error_message = "every returned region enable flag should be 0 or 1"
  }

  assert {
    condition     = alltrue([for it in data.tencentcloud_tdmysql_sale_info.all.region_list : can([for z in it.zone_list : z.zone])])
    error_message = "every returned region should carry a well-formed zone_list with zone names"
  }

  assert {
    condition     = alltrue([for it in data.tencentcloud_tdmysql_sale_info.all.region_list : alltrue([for z in it.zone_list : contains([0, 1], z.enable)])])
    error_message = "every returned zone enable flag should be 0 or 1"
  }

  assert {
    condition     = alltrue([for it in data.tencentcloud_tdmysql_sale_info.all.region_list : can([for g in it.zone_group : g.zone_num])])
    error_message = "every returned region should carry a well-formed zone_group with zone_num"
  }
}

run "query_sale_regions_by_instance_type" {
  command = apply

  assert {
    condition     = length(data.tencentcloud_tdmysql_sale_info.by_type.id) > 0
    error_message = "the instance_type-filtered data source id (random token) should not be empty"
  }

  # When no instance type is supplied the API treats the empty value as
  # "no filter" and returns the full set; the run then only asserts
  # well-formedness.
  assert {
    condition     = length(var.instance_type) == 0 || alltrue([for it in data.tencentcloud_tdmysql_sale_info.by_type.region_list : it.is_support_serverless])
    error_message = "when filtering by instance_type=serverless, every returned region should support serverless"
  }

  assert {
    condition     = alltrue([for it in data.tencentcloud_tdmysql_sale_info.by_type.region_list : can([for z in it.zone_list : z.zone])])
    error_message = "every returned region should carry a well-formed zone_list"
  }
}

run "query_sale_regions_by_filters" {
  command = apply

  assert {
    condition     = length(data.tencentcloud_tdmysql_sale_info.by_filters.id) > 0
    error_message = "the filtered data source id (random token) should not be empty"
  }

  # src_region / instance_id are sent only when non-empty, so the run stays
  # valid and well-formed even when the caller leaves both unset.
  assert {
    condition     = alltrue([for it in data.tencentcloud_tdmysql_sale_info.by_filters.region_list : can([for z in it.zone_list : z.zone])])
    error_message = "every returned region should carry a well-formed zone_list"
  }
}
