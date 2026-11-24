# Online tests for tencentcloud_oceanus_cluster_af against the real cloud.
#
# No mock / override: every assertion checks values the provider got back from
# the Oceanus APIs (CreateOceanusCluster -> ClusterId, DescribeClusters ->
# Name/CuNum/DefaultCOSBucket, ScaleOceanusCluster -> new CU number).
#
# terraform test destroys every object created here at the end of the run: the
# cluster first, then the subnet, the COS bucket (force_clean) and the VPC.

run "create_and_verify_cluster" {
  command = apply

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.id != "" && startswith(tencentcloud_oceanus_cluster_af.example.id, "cluster-")
    error_message = "id should be the ClusterId (cluster-xxxxxxxx) returned by CreateOceanusCluster"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.cluster_name == local.name
    error_message = "cluster_name read back from DescribeClusters should equal the configured name"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.region_id == var.region_id && tencentcloud_oceanus_cluster_af.example.zone_id == var.zone_id
    error_message = "region_id / zone_id should keep the configured values"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.cu == var.cu
    error_message = "cu should be the CU number returned by DescribeClusters for the created cluster"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.default_cos_bucket == local.bucket
    error_message = "default_cos_bucket should be the COS bucket configured for the cluster"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.instance_charge_type == "POSTPAID_BY_SECOND"
    error_message = "instance_charge_type should be POSTPAID_BY_SECOND"
  }

  assert {
    condition     = length(tencentcloud_oceanus_cluster_af.example.vpc_descriptions) == 1 && tencentcloud_oceanus_cluster_af.example.vpc_descriptions[0].vpc_id == tencentcloud_vpc.example.id && tencentcloud_oceanus_cluster_af.example.vpc_descriptions[0].subnet_id == tencentcloud_subnet.example.id
    error_message = "vpc_descriptions should keep the VPC / subnet created for this cluster"
  }
}

run "scale_cluster" {
  command = apply

  # Only `cu` is updatable in place (ScaleOceanusCluster); every other attribute
  # carries RequiresReplace.
  variables {
    cu = var.cu_scaled
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.cu == var.cu_scaled
    error_message = "cu should be the new CU number after ScaleOceanusCluster"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.id != "" && startswith(tencentcloud_oceanus_cluster_af.example.id, "cluster-")
    error_message = "scaling must update the existing cluster in place and keep its ClusterId"
  }

  assert {
    condition     = tencentcloud_oceanus_cluster_af.example.cluster_name == local.name
    error_message = "cluster_name should be unchanged after an in-place scale"
  }
}
