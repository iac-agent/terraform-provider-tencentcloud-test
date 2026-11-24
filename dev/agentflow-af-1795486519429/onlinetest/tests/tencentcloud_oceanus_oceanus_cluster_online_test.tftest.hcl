run "create_oceanus_cluster_online" {
  command = apply

  assert {
    condition     = can(regex("^cluster-[a-z0-9]+$", tencentcloud_oceanus_oceanus_cluster.example.id))
    error_message = "cluster id should match format cluster-xxx returned by CreateOceanusCluster"
  }

  assert {
    condition     = tencentcloud_oceanus_oceanus_cluster.example.id == data.tencentcloud_oceanus_clusters.created.cluster_set[0].cluster_id
    error_message = "cluster id should be returned by DescribeClusters read-back"
  }

  assert {
    condition     = data.tencentcloud_oceanus_clusters.created.cluster_set[0].name == var.cluster_name
    error_message = "cluster name read back from cloud should equal the configured cluster_name"
  }

  assert {
    condition     = data.tencentcloud_oceanus_clusters.created.cluster_set[0].cu_num == var.cu
    error_message = "cluster CU count read back from cloud should equal the configured cu"
  }

  assert {
    condition     = data.tencentcloud_oceanus_clusters.created.cluster_set[0].status == 2
    error_message = "cluster should eventually reach running status (2) after creation"
  }
}
