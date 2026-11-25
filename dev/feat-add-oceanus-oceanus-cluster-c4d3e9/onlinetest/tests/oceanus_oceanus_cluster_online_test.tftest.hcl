# Online tests for tencentcloud_oceanus_oceanus_cluster against the real cloud.
#
# No mock / override_resource: every assertion checks a value the provider got
# back from the Oceanus APIs (CreateOceanusCluster -> ClusterId, DescribeClusters
# -> Name / CuNum / DefaultCOSBucket / Remark).
#
# `terraform test` destroys everything created here at the end of the run: the
# cluster first, then the subnet, the COS bucket (force_clean) and the VPC.

run "create_oceanus_cluster" {
  command = apply

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.id != "" && startswith(tencentcloud_oceanus_oceanus_cluster.example.id, "cluster-")
    error_message = "id should be the ClusterId (cluster-xxxxxxxx) returned by CreateOceanusCluster, got: ${tencentcloud_oceanus_oceanus_cluster.example.id}"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.cluster_name == local.name
    error_message = "cluster_name read back from DescribeClusters should equal the configured name, got: ${tencentcloud_oceanus_oceanus_cluster.example.cluster_name}"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.region_id == var.region_id && tencentcloud_oceanus_oceanus_cluster.example.zone_id == var.zone_id
    error_message = "region_id / zone_id should keep the configured values, got: ${tencentcloud_oceanus_oceanus_cluster.example.region_id} / ${tencentcloud_oceanus_oceanus_cluster.example.zone_id}"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.cu == var.cu
    error_message = "cu should be the CU number returned by DescribeClusters for the created cluster, got: ${tencentcloud_oceanus_oceanus_cluster.example.cu}"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.default_cos_bucket == local.bucket
    error_message = "default_cos_bucket should be the COS bucket configured for the cluster, got: ${tencentcloud_oceanus_oceanus_cluster.example.default_cos_bucket}"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.instance_charge_type == "POSTPAID_BY_SECOND"
    error_message = "instance_charge_type should be POSTPAID_BY_SECOND, got: ${tencentcloud_oceanus_oceanus_cluster.example.instance_charge_type}"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.remark == local.name
    error_message = "remark read back from DescribeClusters should equal the configured description, got: ${tencentcloud_oceanus_oceanus_cluster.example.remark}"
  }

  assert {
    condition     = length(tencentcloud_oceanus_oceanus_cluster.example.vpc_descriptions) == 1 && tencentcloud_oceanus_oceanus_cluster.example.vpc_descriptions[0].vpc_id == tencentcloud_vpc.example.id && tencentcloud_oceanus_oceanus_cluster.example.vpc_descriptions[0].subnet_id == tencentcloud_subnet.example.id
    error_message = "vpc_descriptions should keep the VPC / subnet created for this cluster"
  }
}

run "reapply_oceanus_cluster" {
  command = apply

  # Second apply without any change: the read back from DescribeClusters must be
  # idempotent (no drift, cluster not replaced) and the ClusterId must be kept.
  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.id != "" && startswith(tencentcloud_oceanus_oceanus_cluster.example.id, "cluster-")
    error_message = "the cluster id must survive the second apply, got: ${tencentcloud_oceanus_oceanus_cluster.example.id}"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.cluster_name == local.name && tencentcloud_oceanus_oceanus_cluster.example.cu == var.cu
    error_message = "cluster_name / cu should be stable across a no-op apply"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.default_cos_bucket == local.bucket
    error_message = "default_cos_bucket should remain the configured COS bucket after refresh, got: ${tencentcloud_oceanus_oceanus_cluster.example.default_cos_bucket}"
  }
}
