run "plan_monitor_ext_namespace" {
  command = plan

  # The data block calls DescribeExtNamespace at plan time: override_data
  # returns fake values so no cloud API request is ever issued.
  override_data {
    target = data.tencentcloud_monitor_ext_namespace.example
    values = {
      ext_namespace_list = ["PT_SH", "PT_GZ"]
    }
  }

  assert {
    condition     = length(data.tencentcloud_monitor_ext_namespace.example.ext_namespace_list) > 0
    error_message = "ext_namespace_list should not be empty"
  }

  assert {
    condition     = anytrue([for n in data.tencentcloud_monitor_ext_namespace.example.ext_namespace_list : n == "PT_SH"]) || anytrue([for n in data.tencentcloud_monitor_ext_namespace.example.ext_namespace_list : n == "PT_GZ"])
    error_message = "ext_namespace_list should contain the overridden values"
  }
}
