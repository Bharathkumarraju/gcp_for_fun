Cluster autoscaling controls the number of worker nodes in response to our workload demands.

GKE Cluster Auto scaling can automatically resize a cluster based on the demands of our workload.

By default cluster auto scaler is disabled.

Cluster auto scaling allows you to pay only for resources that are needed at any given moment and to automatically get the
additional resources when demand increases.

When Autoscaling is enabled, GKE automatically adds a node to your cluster if you create new pods and dont have enough capacity to run.
if node in the cluster is underutilized and its pods can ve run on another nodes GKE can delete the node.

Before enabling autoscaling you should make sure that your services can tolerate a potential disruption.
