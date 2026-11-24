# Mock tests for the tencentcloud_oceanus_cluster_af resource (oceanus
# v20190422, framework stack).
#
# The resource id is the ClusterId returned by CreateOceanusCluster
# (cluster-xxxx). override_resource supplies the state Terraform would see after
# Read/DescribeClusters has refreshed it, so the assertions check both the
# identity and the values the provider is expected to keep in state.

override_resource {
  target = tencentcloud_oceanus_cluster_af.example
  values = {
    id                 = "cluster-mock1234"
    cluster_name       = "tf-mock-oceanus-cluster"
    region_id          = 1
    zone_id            = 100001
    login_password     = "MockPassword123"
    default_cos_bucket = "tf-mock-oceanus-1250000000"
    cu                 = 12
    remark             = "tf mock cluster"
    instance_charge_type = "POSTPAID_BY_SECOND"
    flink_web_ui_network_access_type = "NetworkAccess_EXTERNAL"
    vpc_descriptions = [
      {
        vpc_id    = "vpc-mock1234"
        subnet_id = "subnet-mock1234"
        app_id    = null
        owner_uin = null
      }
    ]
  }
}

# Plan-only run: exercises the schema (required/optional attributes, nested
# vpc_descriptions block) without reaching any read-back override.
run "plan_oceanus_cluster" {
  command = plan

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.cluster_name == "tf-mock-oceanus-cluster"
    error_message = "planned cluster_name should be tf-mock-oceanus-cluster"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.cu == 12
    error_message = "planned cu should be the configured 12"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.vpc_descriptions[0].subnet_id == "subnet-mock1234"
    error_message = "planned vpc_descriptions[0].subnet_id should be subnet-mock1234"
  }
}

run "apply_oceanus_cluster" {
  command = apply

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.id == "cluster-mock1234"
    error_message = "id should be the ClusterId cluster-mock1234 returned by CreateOceanusCluster"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.cluster_name == "tf-mock-oceanus-cluster"
    error_message = "cluster_name should be tf-mock-oceanus-cluster"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.region_id == 1 && tencentcloud_oceanus_cluster_af.example.zone_id == 100001
    error_message = "region_id/zone_id should keep the configured 1/100001"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.cu == 12
    error_message = "cu should be 12 CUs as configured"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.default_cos_bucket == "tf-mock-oceanus-1250000000"
    error_message = "default_cos_bucket should be tf-mock-oceanus-1250000000"
  }

  assert {
    condition     = length(tencentcloud_oceanus_cluster_af.example.vpc_descriptions) == 1 && tencentcloud_oceanus_cluster_af.example.vpc_descriptions[0].vpc_id == "vpc-mock1234" && tencentcloud_oceanus_cluster_af.example.vpc_descriptions[0].subnet_id == "subnet-mock1234"
    error_message = "vpc_descriptions should keep the configured vpc-mock1234/subnet-mock1234"
  }
}
