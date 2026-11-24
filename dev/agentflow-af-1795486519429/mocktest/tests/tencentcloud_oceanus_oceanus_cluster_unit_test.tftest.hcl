override_resource {
  target = tencentcloud_oceanus_oceanus_cluster.example
  values = {
    id                     = "cluster-mock1234"
    cluster_id             = "cluster-mock1234"
    cluster_name           = "tf_mock_cluster"
    status                 = 2
    create_time            = "2025-01-01 00:00:00"
    update_time            = "2025-01-02 00:00:00"
    default_cos_bucket     = "tf-mock-bucket-1250000000"
    cu                     = 12
    cu_memory              = 2
    remark                 = "created by terraform mock test"
    vpc_descriptions       = { vpc_id = "vpc-mock1234", subnet_id = "subnet-mock1234", app_id = 1250000000, owner_uin = "100000000000" }
    slave_vpc_descriptions = []
  }
}

run "create_oceanus_cluster" {
  command = apply

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.id == "cluster-mock1234"
    error_message = "id should be the mocked cluster id"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.cluster_name == "tf_mock_cluster"
    error_message = "cluster_name should be tf_mock_cluster"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.status == 2
    error_message = "status should be mocked as running (2)"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.vpc_descriptions[0].vpc_id == "vpc-mock1234"
    error_message = "vpc_descriptions[0].vpc_id should be vpc-mock1234"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.vpc_descriptions[0].subnet_id == "subnet-mock1234"
    error_message = "vpc_descriptions[0].subnet_id should be subnet-mock1234"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.instance_charge_type == "POSTPAID_BY_SECOND"
    error_message = "instance_charge_type should be POSTPAID_BY_SECOND"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.cu == 12
    error_message = "cu should be 12"
  }
}

run "plan_no_changes" {
  command = plan

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.cluster_name == "tf_mock_cluster"
    error_message = "cluster_name should remain stable in plan"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.vpc_descriptions[0].vpc_id == "vpc-mock1234"
    error_message = "vpc_id should remain stable in plan"
  }
}
