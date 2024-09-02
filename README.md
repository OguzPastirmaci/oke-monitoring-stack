# oke-monitoring-stack

1 - Deploy the stack using the button below.

[![Deploy to Oracle Cloud](https://oci-resourcemanager-plugin.plugins.oci.oraclecloud.com/latest/deploy-to-oracle-cloud.svg)](https://cloud.oracle.com/resourcemanager/stacks/create?zipUrl=https://github.com/OguzPastirmaci/oke-monitoring-stack/releases/download/24.9.1/24.9.1.zip)

2 - Follow the instructions in the web console to access your cluster from your local machine.

Menu > Developer Services > Kubernetes Clusters (OKE) > Your Cluster > Access Cluster > Local Access

3 - Once you configured your access to your OKE cluster, run the following command:

```shell
kubectl port-forward -n monitoring svc/prom-grafana 3001:80
```

4 - Then acess Grafana through local tunnel [http://localhost:3001](http://localhost:3001).

```
Username: admin
Password: prom-operator
```