# Mock tests for tencentcloud_oceanus_oceanus_cluster (oceanus v20190422,
# framework stack).
#
# The resource id is the ClusterId returned by CreateOceanusCluster
# (cluster-xxx). override_resource supplies the state Terraform sees after the
# create+read-back has refreshed it, so the assertions check both the identity
# and the values the provider is expected to keep in state.

override_resource {
  target = tencentcloud_oceanus_oceanus_cluster.example
  values = {
    id                               = "cluster-mock1234"
    cluster_name                     = "tf_mock_oceanus_cluster"
    region_id                        = 1
    zone_id                          = 100003
    login_password                   = "MockPassw0rd!"
    default_cos_bucket               = "tf-mock-bucket-1250000000"
    cu                               = 12
    remark                           = "created by terraform mock test"
    instance_charge_type             = "POSTPAID_BY_SECOND"
    flink_web_ui_network_access_type = "NetworkAccess_EXTERNAL"
    cu_memory                        = 2
    vpc_descriptions = [
      {
        vpc_id    = "vpc-mock1234"
        subnet_id = "subnet-mock1234"
        app_id    = 1250000000
        owner_uin = "100000000000"
      }
    ]
    slave_vpc_descriptions = null
  }
}

# Plan-only run: exercises the schema (required / optional attributes, nested
# vpc_descriptions block) without reaching any read-back override.
run "plan_oceanus_cluster" {
  command = plan

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.cluster_name == "tf_mock_oceanus_cluster"
    error_message = "planned cluster_name should be tf_mock_oceanus_cluster"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.region_id == 1 && tencentcloud_oceanus_oceanus_cluster.example.zone_id == 100003
    error_message = "planned region_id/zone_id should be 1/100003"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.cu == 12
    error_message = "planned cu should be the configured 12"
  }

  assert {
    condition     = length(tencentcloud_oceanus_oceanus_cluster.example.vpc_descriptions) == 1 && tencentcloud_oceanus_oceanus_cluster.example.vpc_descriptions[0].vpc_id == "vpc-mock1234" && tencentcloud_oceanus_oceanus_cluster.example.vpc_descriptions[0].subnet_id == "subnet-mock1234"
    error_message = "planned vpc_descriptions should keep the configured vpc-mock1234/subnet-mock1234"
  }
}

# Apply run: 12 CU is the minimum billing unit, so the created cluster must come
# back with cu == 12 and the identity must be the cluster id.
run "create_oceanus_cluster" {
  command = apply

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.id == "cluster-mock1234"
    error_message = "id should be the ClusterId cluster-mock1234 returned by CreateOceanusCluster"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.cluster_name == "tf_mock_oceanus_cluster"
    error_message = "cluster_name should be tf_mock_oceanus_cluster"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.cu == 12
    error_message = "cu should be the effective 12 CUs of the cluster"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.default_cos_bucket == "tf-mock-bucket-1250000000"
    error_message = "default_cos_bucket should be tf-mock-bucket-1250000000"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.instance_charge_type == "POSTPAID_BY_SECOND"
    error_message = "instance_charge_type should be POSTPAID_BY_SECOND"
  }

  assert {
    condition     = length(tencentcloud_oceanus_oceanus_cluster.example.vpc_descriptions) == 1 && tencentcloud_oceanus_oceanus_cluster.example.vpc_descriptions[0].subnet_id == "subnet-mock1234"
    error_message = "vpc_descriptions[0].subnet_id should be subnet-mock1234"
  }
}
