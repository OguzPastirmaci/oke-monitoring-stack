# Copyright (c) 2024 Oracle Corporation and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

data "oci_containerengine_cluster_kube_config" "oke" {
  cluster_id = var.cluster_id
  endpoint   = "PUBLIC_ENDPOINT"
}

data "kubernetes_nodes" "pool" {
  metadata {
    labels = {
      "oke.oraclecloud.com/pool.name" = "oke-ops"
    }
  }
}

locals {
  # Kubeconfig for kubernetes provider endpoint/CA certificate
  kube_exec_args = concat(
    ["--region", var.region],
    var.oci_profile != null ? ["--profile", var.oci_profile] : [],
    ["ce", "cluster", "generate-token"],
    ["--cluster-id", var.cluster_id],
  )
  kubeconfig         = yamldecode(data.oci_containerengine_cluster_kube_config.oke.content)
  kubeconfig_cluster = try(lookup(lookup(local.kubeconfig, "clusters", [{}])[0], "cluster", {}), {})
  cluster_ca_cert    = lookup(local.kubeconfig_cluster, "certificate-authority-data", "")
  cluster_endpoint   = lookup(local.kubeconfig_cluster, "server", "")

  # Kubernetes labels
  labels_gpu_stack = tomap({
    "app.kubernetes.io/part-of" = "oke-gpu-stack"
    "app.kubernetes.io/version" = "1"
  })

  # Node resources
  node             = element(tolist(one(data.kubernetes_nodes.pool[*].nodes)), 1)
  node_allocatable = lookup(element(lookup(local.node, "status", [{}]), 1), "allocatable", {})
  node_memory      = lookup(local.node_allocatable, "memory", "8000000Ki")
  node_memory_bytes = (
    length(regexall("Ki$", local.node_memory)) > 0
    ? parseint(trimsuffix(local.node_memory, "Ki"), 10) * 1000
    : parseint(local.node_memory)
  )
  prom_server_memory_request_bytes = (
    length(regexall("%$", var.prom_server_memory_request)) > 0
    ? local.node_memory_bytes * (parseint(trimsuffix(var.prom_server_memory_request, "%"), 10) * 0.01)
    : var.prom_server_memory_request
  )
  prom_server_memory_limit_bytes = (
    length(regexall("%$", var.prom_server_memory_limit)) > 0
    ? local.node_memory_bytes * (parseint(trimsuffix(var.prom_server_memory_limit, "%"), 10) * 0.01)
    : var.prom_server_memory_limit
  )
}
