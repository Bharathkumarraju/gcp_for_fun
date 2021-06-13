Nodes have only internal ip.
not an external IP addresses. Cluster workloads will be isolated from the public internet.

1. All nodes have just internal IP addresses.
2. Cannot be accessed by external clients.

No external client can connect directly to a node on a private cluster.


now the master endpoint is special because thats what you  interact with.

3. Cluster master endpoint is reachable.
   - Only from internal IP addresses
   - only from a set of authorized networks.

in the second case master endpoint is publicly reachable only from networks that you know are trusted.

GCP interacts with cluster in many different ways. Google has special access to the master node for scheduling and cluster management.

Private GKE clusters can use vpc network peering to connect to your clusters VPC with any google-owned VPC networks.
Routing between these peer networks use internal IP addresses. so once again you donot need external IPs for this.


gcloud beta container clusters create spikey-website-cluster \
 --private-cluster \
 --master-ipv4-cidr 172.16.0.16/28 \
 --enable-ip-alias \
 --create-subnetwork ""


we use --master-ipv4-cidr flag to reserve this IP range for the cluster master.
Once this is configured during cluster creation, this can not be changed.


bharath@cloudshell:~ (learngcp-316009)$ gcloud beta container clusters create spikey-website-cluster \
>  --enable-private-nodes \
>  --master-ipv4-cidr 172.16.0.16/28 \
>  --enable-ip-alias \
>  --zone us-central1-a \
>  --create-subnetwork ""
WARNING: Starting in January 2021, clusters will use the Regular release channel by default when `--cluster-version`, `--release-channel`, `--no-enable-autoupgrade`, and `--no-enable-autorepair` flags are not specified.
WARNING: Starting with version 1.18, clusters will have shielded GKE nodes by default.
WARNING: The Pod address range limits the maximum size of the cluster. Please refer to https://cloud.google.com/kubernetes-engine/docs/how-to/flexible-pod-cidr to learn how to optimize IP address allocation.
WARNING: Starting with version 1.19, newly created clusters and node-pools will have COS_CONTAINERD as the default node image when no image type is specified.
Creating cluster spikey-website-cluster in us-central1-a... Cluster is being health-checked (master is healthy)...done.
Created [https://container.googleapis.com/v1beta1/projects/learngcp-316009/zones/us-central1-a/clusters/spikey-website-cluster].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/us-central1-a/spikey-website-cluster?project=learngcp-316009
kubeconfig entry generated for spikey-website-cluster.
NAME                    LOCATION       MASTER_VERSION   MASTER_IP      MACHINE_TYPE  NODE_VERSION     NUM_NODES  STATUS
spikey-website-cluster  us-central1-a  1.19.9-gke.1900  35.224.97.152  e2-medium     1.19.9-gke.1900  3          RUNNING
bharath@cloudshell:~ (learngcp-316009)$


bharath@cloudshell:~ (learngcp-316009)$ gcloud compute networks subnets list --network default | grep "us-central1"
default                                     us-central1              default  10.128.0.0/20
gke-spikey-website-cluster-subnet-d8a19f5d  us-central1              default  10.34.16.0/22
bharath@cloudshell:~ (learngcp-316009)$





bharath@cloudshell:~ (learngcp-316009)$ gcloud compute instances set-service-account \
> test-vm --zone us-central1-a \
> --scopes 'https://www.googleapis.com/auth/cloud-platform'
Updated [https://www.googleapis.com/compute/v1/projects/learngcp-316009/zones/us-central1-a/instances/test-vm].
bharath@cloudshell:~ (learngcp-316009)$



bharath@cloudshell:~ (learngcp-316009)$ gcloud compute instances describe test-vm --zone us-central1-a | grep natIP
    natIP: 35.224.211.157
bharath@cloudshell:~ (learngcp-316009)$



bharath@cloudshell:~ (learngcp-316009)$ gcloud container clusters update spikey-website-cluster \
> --enable-master-authorized-networks \
> --zone us-central1-a --master-authorized-networks 35.224.211.157/32
Updating spikey-website-cluster...done.
Updated [https://container.googleapis.com/v1/projects/learngcp-316009/zones/us-central1-a/clusters/spikey-website-cluster].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/us-central1-a/spikey-website-cluster?project=learngcp-316009
bharath@cloudshell:~ (learngcp-316009)$



bharath@test-vm:~$ gcloud container clusters get-credentials spikey-website-cluster --zone us-central1-a
Fetching cluster endpoint and auth data.
kubeconfig entry generated for spikey-website-cluster.
bharath@test-vm:~$ kubectl get nodes -o wide
NAME                                                  STATUS   ROLES    AGE   VERSION            INTERNAL-IP   EXTERNAL-IP   OS-IMAGE                             KERNEL-VERSION   CONTAINER-RUNTIME
gke-spikey-website-clust-default-pool-7102ce8d-fmq8   Ready    <none>   21m   v1.19.9-gke.1900   10.34.16.2    <none>        Container-Optimized OS from Google   5.4.89+          containerd://1.4.3
gke-spikey-website-clust-default-pool-7102ce8d-ldst   Ready    <none>   21m   v1.19.9-gke.1900   10.34.16.4    <none>        Container-Optimized OS from Google   5.4.89+          containerd://1.4.3
gke-spikey-website-clust-default-pool-7102ce8d-w9cr   Ready    <none>   21m   v1.19.9-gke.1900   10.34.16.3    <none>        Container-Optimized OS from Google   5.4.89+          containerd://1.4.3
bharath@test-vm:~$
^C
bharath@test-vm:~$ kubectl create deployment nginx --image=nginx --replicas 3
deployment.apps/nginx created
bharath@test-vm:~$ kubectl get all
NAME                         READY   STATUS              RESTARTS   AGE
pod/nginx-6799fc88d8-5jdh4   0/1     ContainerCreating   0          6s
pod/nginx-6799fc88d8-mnnnx   0/1     ContainerCreating   0          6s
pod/nginx-6799fc88d8-r6btr   0/1     ContainerCreating   0          6s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.34.32.1   <none>        443/TCP   22m

NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx   0/3     3            0           6s

NAME                               DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-6799fc88d8   3         3         0       6s
bharath@test-vm:~$




bharath@test-vm:~$ kubectl get nodes -o yaml  | grep -A4 addresses
    addresses:
    - address: 10.34.16.2
      type: InternalIP
    - address: gke-spikey-website-clust-default-pool-7102ce8d-fmq8.us-central1-a.c.learngcp-316009.internal
      type: InternalDNS
--
    addresses:
    - address: 10.34.16.4
      type: InternalIP
    - address: gke-spikey-website-clust-default-pool-7102ce8d-ldst.us-central1-a.c.learngcp-316009.internal
      type: InternalDNS
--
    addresses:
    - address: 10.34.16.3
      type: InternalIP
    - address: gke-spikey-website-clust-default-pool-7102ce8d-w9cr.us-central1-a.c.learngcp-316009.internal
      type: InternalDNS
bharath@test-vm:~$



