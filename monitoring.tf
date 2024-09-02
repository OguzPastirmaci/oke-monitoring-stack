# Copyright (c) 2024 Oracle Corporation and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl


locals {
  monitoring_version = "1"
  monitoring_labels = merge(local.labels_gpu_stack, tomap({
    "app.kubernetes.io/name"    = var.monitoring_namespace
    "app.kubernetes.io/version" = local.monitoring_version
  }))
}


data "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring"
  }
}

output "ns-present" {
  value = lookup(data.kubernetes_namespace.monitoring, "id") != null
}

resource "kubernetes_namespace_v1" "monitoring" {
  metadata {
    name = var.monitoring_namespace
    labels = {
      "kubernetes.io/metadata.name" = var.monitoring_namespace
    }
  }
}
