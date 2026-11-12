run "plan_teo_function_1111_01" {
  command = plan

  assert {
    condition     = tencentcloud_teo_function_1111_01.example.zone_id == "zone-2p6gh1xjqwbv"
    error_message = "zone_id should be zone-2p6gh1xjqwbv"
  }

  assert {
    condition     = tencentcloud_teo_function_1111_01.example.name == "tf-test-function-1111-01"
    error_message = "name should be tf-test-function-1111-01"
  }

  assert {
    condition     = tencentcloud_teo_function_1111_01.example.remark == "created by terraform test"
    error_message = "remark should be created by terraform test"
  }

  assert {
    condition     = startswith(tencentcloud_teo_function_1111_01.example.content, "addEventListener('fetch'")
    error_message = "content should keep the configured JavaScript code"
  }
}
