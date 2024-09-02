# Monitoring OKE with DCGM Exporter, Metrics Server, Prometheus server, Grafana, and Node Exporter


1 - Follow the instructions in the web console to access your cluster from your local machine.

Menu > Developer Services > Kubernetes Clusters (OKE) > Your Cluster > Access Cluster > Local Access

2 - Deploy Prometheus stack

```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

```
helm install prometheus-community/kube-prometheus-stack \
--create-namespace --namespace monitoring \
--generate-name \
--values https://raw.githubusercontent.com/OguzPastirmaci/oke-monitoring-stack/main/kube-prometheus-stack-values.yaml \
--set prometheus.service.type=NodePort \
--set prometheus.prometheusSpec.serviceMonitorSelectorNilUsesHelmValues=false \
--set grafana.service.type=NodePort
```

3 - Deploy DCGM Exporter

```
helm repo add gpu-helm-charts \
  https://nvidia.github.io/dcgm-exporter/helm-charts
```  

```
helm install --namespace monitoring --generate-name gpu-helm-charts/dcgm-exporter --values https://raw.githubusercontent.com/OguzPastirmaci/oke-monitoring-stack/main/kube-dcgm-exporter-values.yaml
```

3 - Once you configured your access to your OKE cluster, run the following command:

```shell
kubectl port-forward -n monitoring svc/prom-grafana 3001:80
```

4 - Then acess Grafana through local tunnel [http://localhost:3001](http://localhost:3001).

```
Username: admin
Password: prom-operator
```