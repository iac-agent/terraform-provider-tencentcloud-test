# Mock tests for the tencentcloud_oceanus_cluster_af resource (oceanus v20190422).
#
# The resource id is the ClusterId returned by CreateOceanusCluster (cluster-xxxx);
# creation is asynchronous and the provider polls DescribeClusters until the
# cluster converges. override_resource supplies the read-back state that would
# normally come from DescribeClusters; assert checks are self-consistent with
# those mock values.

override_resource {
  target = tencentcloud_oceanus_cluster_af.example
  values = {
    id                = "cluster-abcd1234"
    cluster_read_id   = "cluster-abcd1234"
    cluster_name      = "tf-mock-cluster"
    region_id         = 1
    zone_id           = 100001
    zone              = "ap-guangzhou-1"
    login_password    = "tf-mock-password"
    default_cos_bucket = "tf-mock-bucket"
    cu                = 12
    remark            = "created by terraform"
    instance_charge_type = "POSTPAID_BY_SECOND"
    cluster_type         = "MULTI_AZ_CLUSTER"
    status            = "2"
    status_desc      = "running"
    create_time      = "2026-11-25 03:00:00"
    update_time      = "-"
    vpc_descriptions = [
      {
        vpc_id    = "vpc-1234abcd"
        subnet_id = "subnet-1234abcd"
      }
    ]
  }
}

run "apply_oceanus_cluster" {
  command = apply

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.id == "cluster-abcd1234"
    error_message = "cluster id should be the ClusterId cluster-abcd1234 returned by CreateOceanusCluster"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.cluster_read_id == "cluster-abcd1234"
    error_message = "cluster_read_id should match the read-back ClusterId cluster-abcd1234"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.cluster_name == "tf-mock-cluster"
    error_message = "cluster_name should be tf-mock-cluster"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.region_id == 1
    error_message = "region_id should be 1"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.zone_id == 100001
    error_message = "zone_id should be 100001"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.zone == "ap-guangzhou-1"
    error_message = "computed zone read back from DescribeClusters should be ap-guangzhou-1"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.default_cos_bucket == "tf-mock-bucket"
    error_message = "default_cos_bucket should be tf-mock-bucket"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.cu == 12
    error_message = "cu should be 12"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.instance_charge_type == "POSTPAID_BY_SECOND"
    error_message = "instance_charge_type should be POSTPAID_BY_SECOND"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.cluster_type == "MULTI_AZ_CLUSTER"
    error_message = "cluster_type should be MULTI_AZ_CLUSTER"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.status == "2"
    error_message = "computed status read back from DescribeClusters should be 2 (running)"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.vpc_descriptions[0].vpc_id == "vpc-1234abcd"
    error_message = "vpc_descriptions[0].vpc_id should be vpc-1234abcd"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.vpc_descriptions[0].subnet_id == "subnet-1234abcd"
    error_message = "vpc_descriptions[0].subnet_id should be subnet-1234abcd"
  }
}
