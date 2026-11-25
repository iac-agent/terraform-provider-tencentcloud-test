# Import-lifecycle tests for the oceanus cluster resource.
#
# The import block in main.tf points at the example resource with a fake id;
# override_resource takes over the whole lifecycle so no cloud API is called.
# The pinned mirror build 0.0.1-beta.feat.add.oceanus.oceanus.cluster predates
# the resource rename, so the registered type is
# tencentcloud_oceanus_oceanus_cluster with the region_id/zone_id schema and
# vpc_descriptions objects carrying app_id/owner_uin.

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

run "import_oceanus_cluster" {
  command = apply

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.id == "cluster-mock1234"
    error_message = "imported id should be the import block id cluster-mock1234"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.cluster_name == "tf-oceanus-mock-cluster"
    error_message = "imported cluster_name should be tf-oceanus-mock-cluster"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.region_id == 1 && tencentcloud_oceanus_oceanus_cluster.example.zone_id == 100003
    error_message = "imported region_id/zone_id should be 1/100003"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.cu == 12
    error_message = "imported cu should be 12"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.instance_charge_type == "PREPAID"
    error_message = "imported instance_charge_type should be PREPAID"
  }

  assert {
    condition     = length(tencentcloud_oceanus_oceanus_cluster.example.vpc_descriptions) == 1 && tencentcloud_oceanus_oceanus_cluster.example.vpc_descriptions[0].vpc_id == "vpc-mock1234"
    error_message = "imported vpc_descriptions[0].vpc_id should be vpc-mock1234"
  }
}
