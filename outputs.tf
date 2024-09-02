# Copyright (c) 2024 Oracle Corporation and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

output "compartment_id" { value = var.compartment_ocid }
output "cluster_id" { value = var.cluster_id }
output "cluster_endpoint" { value = local.cluster_endpoint }
output "node_memory" { value = local.node_memory }

output "prometheus_stack_version" { value = local.prometheus_stack_version }
output "prometheus_pushgateway_version" { value = local.prometheus_pushgateway_version }
output "prometheus_adapter_version" { value = local.prometheus_adapter_version }
output "metrics_server_version" { value = local.metrics_server_version }

output "prom_server_memory_request_bytes" { value = local.prom_server_memory_request_bytes }
output "prom_server_memory_limit_bytes" { value = local.prom_server_memory_limit_bytes }
output "prom_server_port_forward" {
  value = format("kubectl port-forward -n %v svc/prom-kube-prometheus-stack-prometheus 9090:9090", var.monitoring_namespace)
}
output "prom_pushgateway_port_forward" {
  value = format("kubectl port-forward -n %v svc/prom-pushgateway-prometheus-pushgateway 9091:9091", var.monitoring_namespace)
}
output "grafana_port_forward" {
  value = format("kubectl port-forward -n %v svc/prom-grafana 3000:80", var.monitoring_namespace)
}
