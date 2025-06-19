# Monitoring OKE with DCGM Exporter, Metrics Server, Prometheus server, Grafana, and Node Exporter


### Follow the instructions in the web console to access your cluster from your local machine.

Menu > Developer Services > Kubernetes Clusters (OKE) > Your Cluster > Access Cluster > Local Access

### Deploy Prometheus stack

```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

```
helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
--create-namespace --namespace monitoring \
--values https://raw.githubusercontent.com/oracle-quickstart/oci-hpc-oke/refs/heads/main/terraform/files/kube-prometheus/values.yaml
```

### Deploy DCGM Exporter

```
helm repo add gpu-helm-charts \
  https://nvidia.github.io/dcgm-exporter/helm-charts
```  

```
helm install --namespace monitoring dcgm-exporter gpu-helm-charts/dcgm-exporter \
--values https://raw.githubusercontent.com/oracle-quickstart/oci-hpc-oke/refs/heads/main/terraform/files/nvidia-dcgm-exporter/values.yaml
```

### Deploy Node Problem Detector
```
helm install gpu-rdma-node-problem-detector oci://ghcr.io/deliveryhero/helm-charts/node-problem-detector --version 2.3.18 --namespace monitoring \
    -f https://raw.githubusercontent.com/oracle-quickstart/oci-hpc-oke/refs/heads/main/terraform/files/node-problem-detector/values.yaml
```

### Get the public IP of your Grafana pod

```shell
kubectl get svc -n monitoring -l app.kubernetes.io/instance=kube-prometheus-stack,app.kubernetes.io/name=grafana -o jsonpath='{.items[0].status.loadBalancer.ingress[0].ip}'
```

### Access Grafana using the IP from the previous step.

> [!IMPORTANT]  
> The default username/password is `admin` & `prom-operator`. Change this in your first login.

```
Username: admin
Password: prom-operator
```
