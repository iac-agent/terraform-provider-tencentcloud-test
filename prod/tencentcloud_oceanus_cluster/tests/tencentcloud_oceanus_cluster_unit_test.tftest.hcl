# Apply-lifecycle tests for the oceanus cluster resource.
#
# The import block in main.tf makes the resource import-managed, so mock_provider
# cannot be used here ("Cannot import resources from mock providers");
# override_resource instead supplies the whole post-create state, which is what
# CreateOceanusCluster + DescribeClusters would have written. The pinned mirror
# build 0.0.1-beta.feat.add.oceanus.oceanus.cluster predates the resource rename,
# so the registered type is tencentcloud_oceanus_oceanus_cluster with the
# region_id/zone_id schema and vpc_descriptions objects carrying app_id/owner_uin.

override_resource {
  target = tencentcloud_oceanus_oceanus_cluster.example
  values = {
    id                               = "cluster-mock1234"
    cluster_name                     = "tf-oceanus-mock-cluster"
    region_id                        = 1
    zone_id                          = 100003
    default_cos_bucket               = "tf-oceanus-test-1308726196"
    cu                               = 12
    cu_memory                        = 4
    remark                           = "created by terraform mock test"
    period                           = 1
    instance_charge_type             = "PREPAID"
    cluster_type                     = "MULTI_AZ_CLUSTER"
    renew_flag                       = "NOTIFY_AND_MANUAL_RENEW"
    flink_web_ui_network_access_type = "NetworkAccess_EXTERNAL"
    vpc_descriptions = [
      {
        vpc_id    = "vpc-mock1234"
        subnet_id = "subnet-mock1234"
        app_id    = 1250000000
        owner_uin = "100000000000"
      }
    ]
    slave_vpc_descriptions = [
      {
        vpc_id    = "vpc-mock5678"
        subnet_id = "subnet-mock5678"
        app_id    = 1250000000
        owner_uin = "100000000000"
      }
    ]
  }
}

run "apply_oceanus_cluster" {
  command = apply

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.id == "cluster-mock1234"
    error_message = "id should be the ClusterId cluster-mock1234 returned by CreateOceanusCluster"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.cluster_name == "tf-oceanus-mock-cluster"
    error_message = "cluster_name should be tf-oceanus-mock-cluster"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.region_id == 1
    error_message = "region_id should be 1"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.zone_id == 100003
    error_message = "zone_id should be 100003"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.default_cos_bucket == "tf-oceanus-test-1308726196"
    error_message = "default_cos_bucket should be tf-oceanus-test-1308726196"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.cu == 12
    error_message = "cu should be 12 (the minimal billing unit)"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.cu_memory == 4
    error_message = "cu_memory should be 4"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.remark == "created by terraform mock test"
    error_message = "remark should be created by terraform mock test"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.period == 1
    error_message = "period should be 1 month as configured"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.instance_charge_type == "PREPAID"
    error_message = "instance_charge_type should be PREPAID"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.cluster_type == "MULTI_AZ_CLUSTER"
    error_message = "cluster_type should be MULTI_AZ_CLUSTER"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.renew_flag == "NOTIFY_AND_MANUAL_RENEW"
    error_message = "renew_flag should be NOTIFY_AND_MANUAL_RENEW"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.flink_web_ui_network_access_type == "NetworkAccess_EXTERNAL"
    error_message = "flink_web_ui_network_access_type should be NetworkAccess_EXTERNAL"
  }

  assert {
    condition     = length(tencentcloud_oceanus_oceanus_cluster.example.vpc_descriptions) == 1
    error_message = "vpc_descriptions should hold exactly one element"
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
    condition     = tencentcloud_oceanus_oceanus_cluster.example.vpc_descriptions[0].app_id == 1250000000
    error_message = "vpc_descriptions[0].app_id should be 1250000000"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.vpc_descriptions[0].owner_uin == "100000000000"
    error_message = "vpc_descriptions[0].owner_uin should be 100000000000"
  }

  assert {
    condition     = length(tencentcloud_oceanus_oceanus_cluster.example.slave_vpc_descriptions) == 1
    error_message = "slave_vpc_descriptions should hold exactly one element"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.slave_vpc_descriptions[0].vpc_id == "vpc-mock5678"
    error_message = "slave_vpc_descriptions[0].vpc_id should be vpc-mock5678"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.slave_vpc_descriptions[0].subnet_id == "subnet-mock5678"
    error_message = "slave_vpc_descriptions[0].subnet_id should be subnet-mock5678"
  }
}
