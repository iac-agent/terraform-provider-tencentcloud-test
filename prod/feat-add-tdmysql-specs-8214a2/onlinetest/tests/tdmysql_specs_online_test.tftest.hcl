# Online test: `terraform test` runs against the real cloud, so every assert
# below checks values returned by DescribeSpecs (TDSQL Boundless tdmysql
# v2021-11-22) — no mock override here. The data source is read-only and
# creates nothing on the cloud, so the run leaves no residue and needs no
# destroy-specific handling.

run "query_all_tdmysql_specs" {
  command = apply

  # --- identity of the data source read ---
  assert {
    condition     = data.tencentcloud_tdmysql_specs.all.id != null && data.tencentcloud_tdmysql_specs.all.id != ""
    error_message = "the data source id should be a non-empty random token generated at read time, got: ${data.tencentcloud_tdmysql_specs.all.id}"
  }

  # --- hybrid node specs are returned by the real cloud ---
  assert {
    condition     = length(data.tencentcloud_tdmysql_specs.all.hybrid_node_specs) > 0
    error_message = "the region should expose at least one sellable hybrid node spec, got ${length(data.tencentcloud_tdmysql_specs.all.hybrid_node_specs)} entries"
  }

  assert {
    condition = alltrue([
      for spec in data.tencentcloud_tdmysql_specs.all.hybrid_node_specs :
      spec.spec_code != null && spec.spec_code != ""
    ])
    error_message = "every returned hybrid node spec should carry a non-empty spec_code, got: ${jsonencode([for spec in data.tencentcloud_tdmysql_specs.all.hybrid_node_specs : spec.spec_code])}"
  }

  assert {
    condition = alltrue([
      for spec in data.tencentcloud_tdmysql_specs.all.hybrid_node_specs :
      spec.storage_node_cpu > 0 && spec.storage_node_mem > 0
    ])
    error_message = "every returned hybrid node spec should have positive storage node cpu and memory, got: ${jsonencode([for spec in data.tencentcloud_tdmysql_specs.all.hybrid_node_specs : { cpu = spec.storage_node_cpu, mem = spec.storage_node_mem }])}"
  }

  assert {
    condition = alltrue([
      for spec in data.tencentcloud_tdmysql_specs.all.hybrid_node_specs :
      spec.storage_node_min_num > 0 && spec.storage_node_max_num >= spec.storage_node_min_num
    ])
    error_message = "every returned hybrid node spec should satisfy max_num >= min_num > 0, got: ${jsonencode([for spec in data.tencentcloud_tdmysql_specs.all.hybrid_node_specs : { min = spec.storage_node_min_num, max = spec.storage_node_max_num }])}"
  }

  assert {
    condition = alltrue([
      for spec in data.tencentcloud_tdmysql_specs.all.hybrid_node_specs :
      spec.storage_node_min_disk > 0 && spec.storage_node_max_disk >= spec.storage_node_min_disk
    ])
    error_message = "every returned hybrid node spec should satisfy max_disk >= min_disk > 0, got: ${jsonencode([for spec in data.tencentcloud_tdmysql_specs.all.hybrid_node_specs : { min = spec.storage_node_min_disk, max = spec.storage_node_max_disk }])}"
  }

  assert {
    condition = alltrue([
      for spec in data.tencentcloud_tdmysql_specs.all.hybrid_node_specs :
      spec.storage_type != null && spec.storage_type != ""
    ])
    error_message = "every returned hybrid node spec should carry a non-empty storage_type, got: ${jsonencode([for spec in data.tencentcloud_tdmysql_specs.all.hybrid_node_specs : spec.storage_type])}"
  }

  assert {
    condition = alltrue([
      for spec in data.tencentcloud_tdmysql_specs.all.hybrid_node_specs :
      contains(["CLOUD_DISK", "LOCAL_DISK"], spec.disk_type_category)
    ])
    error_message = "disk_type_category should be one of CLOUD_DISK / LOCAL_DISK, got: ${jsonencode([for spec in data.tencentcloud_tdmysql_specs.all.hybrid_node_specs : spec.disk_type_category])}"
  }

  assert {
    condition = alltrue([
      for spec in data.tencentcloud_tdmysql_specs.all.hybrid_node_specs :
      length(spec.instance_mode) > 0
    ])
    error_message = "every returned hybrid node spec should list at least one supported billing mode, got: ${jsonencode([for spec in data.tencentcloud_tdmysql_specs.all.hybrid_node_specs : spec.instance_mode])}"
  }

  # --- serverless ccu specs are returned by the real cloud ---
  assert {
    condition     = length(data.tencentcloud_tdmysql_specs.all.serverless_ccu_spec) > 0
    error_message = "the region should expose at least one serverless CCU spec, got ${length(data.tencentcloud_tdmysql_specs.all.serverless_ccu_spec)} entries"
  }

  assert {
    condition = alltrue([
      for spec in data.tencentcloud_tdmysql_specs.all.serverless_ccu_spec :
      spec.min_ccu > 0 && length(spec.max_ccu) > 0 && alltrue([for m in spec.max_ccu : m > 0])
    ])
    error_message = "every returned serverless CCU spec should have a positive min_ccu and a non-empty positive max_ccu range, got: ${jsonencode(data.tencentcloud_tdmysql_specs.all.serverless_ccu_spec)}"
  }

  # --- serverless node number spec is returned by the real cloud ---
  assert {
    condition     = length(data.tencentcloud_tdmysql_specs.all.serverless_node_num_spec) == 1
    error_message = "the cloud-side single ServerlessNodeNumSpec object should be exposed as a zero-or-one element list, got ${length(data.tencentcloud_tdmysql_specs.all.serverless_node_num_spec)} entries"
  }

  assert {
    condition = (
      length(data.tencentcloud_tdmysql_specs.all.serverless_node_num_spec) == 1 &&
      data.tencentcloud_tdmysql_specs.all.serverless_node_num_spec[0].min_node_num > 0 &&
      data.tencentcloud_tdmysql_specs.all.serverless_node_num_spec[0].max_node_num >= data.tencentcloud_tdmysql_specs.all.serverless_node_num_spec[0].min_node_num
    )
    error_message = "the serverless node number spec should satisfy max_node_num >= min_node_num > 0, got: ${jsonencode(data.tencentcloud_tdmysql_specs.all.serverless_node_num_spec)}"
  }
}

run "query_filtered_tdmysql_specs" {
  command = apply

  # --- identity of the filtered data source read ---
  assert {
    condition     = data.tencentcloud_tdmysql_specs.filtered.id != null && data.tencentcloud_tdmysql_specs.filtered.id != ""
    error_message = "the filtered data source id should be a non-empty random token generated at read time, got: ${data.tencentcloud_tdmysql_specs.filtered.id}"
  }

  # --- the configured filters are echoed into state unchanged ---
  assert {
    condition     = data.tencentcloud_tdmysql_specs.filtered.zones == tolist(var.zones)
    error_message = "zones should keep the configured availability zone combination ${jsonencode(var.zones)}, got: ${jsonencode(data.tencentcloud_tdmysql_specs.filtered.zones)}"
  }

  assert {
    condition     = data.tencentcloud_tdmysql_specs.filtered.full_replications == var.full_replications
    error_message = "full_replications should keep the configured replica number ${var.full_replications}, got: ${data.tencentcloud_tdmysql_specs.filtered.full_replications}"
  }

  assert {
    condition     = data.tencentcloud_tdmysql_specs.filtered.is_exclusive_instance == var.is_exclusive_instance
    error_message = "is_exclusive_instance should keep the configured exclusive flag ${var.is_exclusive_instance}, got: ${data.tencentcloud_tdmysql_specs.filtered.is_exclusive_instance}"
  }

  # --- the filtered view still returns sellable specs from the real cloud ---
  assert {
    condition     = length(data.tencentcloud_tdmysql_specs.filtered.hybrid_node_specs) > 0
    error_message = "the filtered view (zones=${jsonencode(var.zones)}, full_replications=${var.full_replications}, is_exclusive_instance=${var.is_exclusive_instance}) should still return sellable hybrid node specs, got ${length(data.tencentcloud_tdmysql_specs.filtered.hybrid_node_specs)} entries"
  }

  assert {
    condition = alltrue([
      for spec in data.tencentcloud_tdmysql_specs.filtered.hybrid_node_specs :
      spec.spec_code != null && spec.spec_code != ""
    ])
    error_message = "every hybrid node spec of the filtered view should carry a non-empty spec_code, got: ${jsonencode([for spec in data.tencentcloud_tdmysql_specs.filtered.hybrid_node_specs : spec.spec_code])}"
  }
}
