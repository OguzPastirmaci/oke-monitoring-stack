# Monitoring OKE with DCGM Exporter, Metrics Server, Prometheus server, Grafana, and Node Exporter


1 - Follow the instructions in the web console to access your cluster from your local machine.

Menu > Developer Services > Kubernetes Clusters (OKE) > Your Cluster > Access Cluster > Local Access

2 - Deploy Prometheus stack

```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

```
helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
--create-namespace --namespace monitoring \
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
helm install --namespace monitoring dcgm-exporter gpu-helm-charts/dcgm-exporter \
--values https://raw.githubusercontent.com/OguzPastirmaci/oke-monitoring-stack/helm/kube-dcgm-exporter-values.yaml
```

3 - Once you configured your access to your OKE cluster, run the following command:

```shell
kubectl port-forward -n monitoring svc/kube-prometheus-stack-grafana 3001:80
```

4 - Then acess Grafana through local tunnel [http://localhost:3001](http://localhost:3001).

```
Username: admin
Password: prom-operator
```

5 - When you're in the Grafana page, go to Dashboards, click on **New** on the upper right corner and select **Import**.

In the **Import dashboard** page, enter `12239` to "Grafana.com dashboard URL or ID" field and click **Load**.

In the **Prometheus** drop down menu, choose the only available item and click **Import**.