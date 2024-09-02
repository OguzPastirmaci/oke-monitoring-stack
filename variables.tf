# Copyright (c) 2024 Oracle Corporation and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

locals {
  scrape_interval = format("%vs", var.scrape_interval_seconds)
  scrape_timeout  = format("%vs", var.scrape_timeout_seconds)
  retention       = format("%vh", var.retention_hours)
  retention_size  = format("%vGB", var.retention_gb)
}

# Identity
variable "tenancy_ocid" { type = string }
variable "compartment_ocid" { type = string }
variable "region" { type = string }
variable "current_user_ocid" {
  default = null
  type    = string
}
variable "api_fingerprint" {
  default = null
  type    = string
}
variable "oci_auth" {
  type        = string
  default     = null
  description = "One of [api_key instance_principal instance_principal_with_certs security_token resource_principal]"
}
variable "oci_profile" {
  type    = string
  default = null
}

# Cluster
variable "cluster_id" { type = string }

# Installation
variable "install_prometheus_stack" {
  default = true
  type    = bool
}
variable "install_prometheus_adapter" {
  default = false
  type    = bool
}
variable "install_prometheus_pushgateway" {
  default = true
  type    = bool
}
variable "install_grafana" {
  default = true
  type    = bool
}
variable "install_grafana_dashboards" {
  default = true
  type    = bool
}
variable "install_metrics_server" {
  default = true
  type    = bool
}

variable "install_dcgm_exporter" {
  default = true
  type    = bool
}

variable "monitoring_namespace" {
  default = "monitoring"
  type    = string
}
variable "prometheus_stack_chart_version" {
  default = "62.3.1"
  type    = string
}
variable "prometheus_pushgateway_chart_version" {
  default = "2.14.0"
  type    = string
}
variable "prometheus_adapter_chart_version" {
  default = "4.11.0"
  type    = string
}
variable "metrics_server_chart_version" {
  default = "3.12.1"
  type    = string
}

variable "dcgm_exporter_chart_version" {
  default = "3.5.0"
  type    = string
}

# Configuration
variable "prom_server_memory_request" {
  default = "90%"
  type    = string
}
variable "prom_server_memory_limit" {
  default = "90%"
  type    = string
}
variable "retention_hours" {
  default = 48
  type    = number
}
variable "retention_gb" {
  default = 1000
  type    = number
}
variable "retention_storageclass" {
  default = "oci-bv"
  type    = string
}
variable "scrape_interval_seconds" {
  default = 30
  type    = string
}
variable "scrape_timeout_seconds" {
  default = 25
  type    = string
}
