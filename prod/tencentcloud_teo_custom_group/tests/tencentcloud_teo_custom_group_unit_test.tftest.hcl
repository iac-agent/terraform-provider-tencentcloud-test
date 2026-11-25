override_resource {
  target = tencentcloud_teo_custom_group.example
  values = {
    id                     = "zone-27h0vbm5w1e#cg-2qbzqqti0e9z"
    group_id               = "cg-2qbzqqti0e9z"
    group_item_total_count = 2
    ref_count              = 0
  }
}

run "apply_teo_custom_group" {
  command = apply

  assert {
    condition     = tencentcloud_teo_custom_group.example.id == "zone-27h0vbm5w1e#cg-2qbzqqti0e9z"
    error_message = "id should be zone-27h0vbm5w1e#cg-2qbzqqti0e9z"
  }

  assert {
    condition     = tencentcloud_teo_custom_group.example.group_id == "cg-2qbzqqti0e9z"
    error_message = "group_id should be cg-2qbzqqti0e9z"
  }

  assert {
    condition     = tencentcloud_teo_custom_group.example.zone_id == "zone-27h0vbm5w1e"
    error_message = "zone_id should be zone-27h0vbm5w1e"
  }

  assert {
    condition     = tencentcloud_teo_custom_group.example.group_name == "tf-test-teo-custom-group"
    error_message = "group_name should be tf-test-teo-custom-group"
  }

  assert {
    condition     = tencentcloud_teo_custom_group.example.group_type == "TLSFingerprint"
    error_message = "group_type should be TLSFingerprint"
  }

  assert {
    condition     = length(tencentcloud_teo_custom_group.example.group_items) == 2
    error_message = "group_items should contain 2 items"
  }

  assert {
    condition     = tencentcloud_teo_custom_group.example.group_items[0].content == "cd08b7ecb0e6f5a72c6f5a8ea17e2e5a"
    error_message = "group_items[0].content should be cd08b7ecb0e6f5a72c6f5a8ea17e2e5a"
  }

  assert {
    condition     = tencentcloud_teo_custom_group.example.group_items[0].item_type == "JA3"
    error_message = "group_items[0].item_type should be JA3"
  }

  assert {
    condition     = tencentcloud_teo_custom_group.example.group_items[1].content == "t13d1714h2_8daaf6b1a14185f4"
    error_message = "group_items[1].content should be t13d1714h2_8daaf6b1a14185f4"
  }

  assert {
    condition     = tencentcloud_teo_custom_group.example.group_items[1].item_type == "JA4"
    error_message = "group_items[1].item_type should be JA4"
  }

  assert {
    condition     = tencentcloud_teo_custom_group.example.group_item_total_count == 2
    error_message = "group_item_total_count should be 2"
  }

  assert {
    condition     = tencentcloud_teo_custom_group.example.ref_count == 0
    error_message = "ref_count should be 0"
  }
}
