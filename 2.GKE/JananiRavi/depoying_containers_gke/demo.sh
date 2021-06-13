packagaing up application code and all of its dependencies into a single unit and deploy this into GKE

kubernetes is a container orchestration technology.



export PS1="\[\e[34m\]\w\[\e[m\]>\n-->"


-->gcloud container clusters create my-regional-cluster \
> --num-nodes 2 \
> --region us-central1 \
> --disk-size=15GB \
> --disk-type=pd-standard \
> --enable-autoscaling --min-nodes 1 --max-nodes 10 \
> --enable-autorepair



-->gcloud container clusters create my-regional-cluster --num-nodes 2 --region us-central1 --disk-size=15GB --disk-type=pd-standard --enable-autoscaling --min-nodes 1 --max-nodes 10 --enable-autorepair
WARNING: Starting in January 2021, clusters will use the Regular release channel by default when `--cluster-version`, `--release-channel`, `--no-enable-autoupgrade`, and `--no-enable-autorepair` flags are not specified.
WARNING: Currently VPC-native is not the default mode during cluster creation. In the future, this will become the default mode and can be disabled using `--no-enable-ip-alias` flag. Use `--[no-]enable-ip-alias` flag to suppress this warning.
WARNING: Starting with version 1.18, clusters will have shielded GKE nodes by default.
WARNING: Your Pod address range (`--cluster-ipv4-cidr`) can accommodate at most 1008 node(s).
WARNING: Starting with version 1.19, newly created clusters and node-pools will have COS_CONTAINERD as the default node image when no image type is specified.
Creating cluster my-regional-cluster in us-central1... Cluster is being health-checked (master is healthy)...done.
Created [https://container.googleapis.com/v1/projects/learngcp-316009/zones/us-central1/clusters/my-regional-cluster].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/us-central1/my-regional-cluster?project=learngcp-316009
kubeconfig entry generated for my-regional-cluster.
NAME                 LOCATION     MASTER_VERSION   MASTER_IP       MACHINE_TYPE  NODE_VERSION     NUM_NODES  STATUS
my-regional-cluster  us-central1  1.19.9-gke.1900  35.193.102.177  e2-medium     1.19.9-gke.1900  6          RUNNING
~>
-->


gcloud container clusters create my-zonal-cluster --zone us-central1-a --preemptible --machine-type n1-standard-1 --no-enable-cloud-monitoring --no-enable-cloud-logging



-->gcloud container clusters create my-zonal-cluster --zone us-central1-a --preemptible --machine-type n1-standard-1 --no-enable-cloud-monitoring --no-enable-cloud-logging
WARNING: Starting in January 2021, clusters will use the Regular release channel by default when `--cluster-version`, `--release-channel`, `--no-enable-autoupgrade`, and `--no-enable-autorepair` flags are not specified.
WARNING: Currently VPC-native is not the default mode during cluster creation. In the future, this will become the default mode and can be disabled using `--no-enable-ip-alias` flag. Use `--[no-]enable-ip-alias` flag to suppress this warning.
WARNING: Starting with version 1.18, clusters will have shielded GKE nodes by default.
WARNING: Your Pod address range (`--cluster-ipv4-cidr`) can accommodate at most 1008 node(s).
WARNING: Starting with version 1.19, newly created clusters and node-pools will have COS_CONTAINERD as the default node image when no image type is specified.
Creating cluster my-zonal-cluster in us-central1-a... Cluster is being health-checked (master is healthy)...done.
Created [https://container.googleapis.com/v1/projects/learngcp-316009/zones/us-central1-a/clusters/my-zonal-cluster].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/us-central1-a/my-zonal-cluster?project=learngcp-316009
kubeconfig entry generated for my-zonal-cluster.
NAME              LOCATION       MASTER_VERSION   MASTER_IP       MACHINE_TYPE   NODE_VERSION     NUM_NODES  STATUS
my-zonal-cluster  us-central1-a  1.19.9-gke.1900  146.148.57.125  n1-standard-1  1.19.9-gke.1900  3          RUNNING
~>
-->




-->gcloud container clusters update my-zonal-cluster --zone us-central1-a --logging-service="logging.googleapis.com"
Updating my-zonal-cluster...done.
Updated [https://container.googleapis.com/v1/projects/learngcp-316009/zones/us-central1-a/clusters/my-zonal-cluster].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/us-central1-a/my-zonal-cluster?project=learngcp-316009
~>
-->


-->gcloud container node-pools create my-pool --num-nodes=2  --cluster my-zonal-cluster --zone us-central1-a
WARNING: Starting with version 1.19, newly created node-pools will have COS_CONTAINERD as the default node image when no image type is specified.
Creating node pool my-pool...done.
Created [https://container.googleapis.com/v1/projects/learngcp-316009/zones/us-central1-a/clusters/my-zonal-cluster/nodePools/my-pool].
NAME     MACHINE_TYPE  DISK_SIZE_GB  NODE_VERSION
my-pool  e2-medium     100           1.19.9-gke.1900
~>
-->gcloud container clusters resize my-zonal-cluster --zone us-central1-a --node-pool my-pool --size 4
WARNING: The --size flag is now deprecated. Please use `--num-nodes` instead.
Pool [my-pool] for [my-zonal-cluster] will be resized to 4.

Do you want to continue (Y/n)?  Y

Resizing my-zonal-cluster...done.
Updated [https://container.googleapis.com/v1/projects/learngcp-316009/zones/us-central1-a/clusters/my-zonal-cluster].
~>
-->



-->kubectl create deployment nginx --image=nginx --replicas=2
deployment.apps/nginx created
~>

-->kubectl get all
NAME                         READY   STATUS    RESTARTS   AGE
pod/nginx-6799fc88d8-76r84   1/1     Running   0          24s
pod/nginx-6799fc88d8-jg25k   1/1     Running   0          24s

NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.79.240.1   <none>        443/TCP   33m

NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx   2/2     2            2           25s

NAME                               DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-6799fc88d8   2         2         2       25s
~>
-->


-->kubectl expose deployment nginx --port=80 --target-port=80 --type=LoadBalancer
service/nginx exposed
~>
-->kubectl get services
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
kubernetes   ClusterIP      10.79.240.1     <none>        443/TCP        37m
nginx        LoadBalancer   10.79.247.116   <pending>     80:31411/TCP   21s
~>
-->kubectl get service nginx
NAME    TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)        AGE
nginx   LoadBalancer   10.79.247.116   34.67.211.228   80:31411/TCP   66s
~>
-->curl http://34.67.211.228
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
~>
-->



-->gcloud config set compute/zone us-central1-b
Updated property [compute/zone].
~>
-->gcloud container clusters create autoscaling-cluster
WARNING: Starting in January 2021, clusters will use the Regular release channel by default when `--cluster-version`, `--release-channel`, `--no-enable-autoupgrade`, and `--no-enable-autorepair` flags are not specified.
WARNING: Currently VPC-native is not the default mode during cluster creation. In the future, this will become the default mode and can be disabled using `--no-enable-ip-alias` flag. Use `--[no-]enable-ip-alias` flag to suppress this warning.
WARNING: Starting with version 1.18, clusters will have shielded GKE nodes by default.
WARNING: Your Pod address range (`--cluster-ipv4-cidr`) can accommodate at most 1008 node(s).
WARNING: Starting with version 1.19, newly created clusters and node-pools will have COS_CONTAINERD as the default node image when no image type is specified.
Creating cluster autoscaling-cluster in us-central1-b... Cluster is being health-checked (master is
 healthy)...done.
Created [https://container.googleapis.com/v1/projects/learngcp-316009/zones/us-central1-b/clusters/autoscaling-cluster].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/us-central1-b/autoscaling-cluster?project=learngcp-316009
kubeconfig entry generated for autoscaling-cluster.
NAME                 LOCATION       MASTER_VERSION   MASTER_IP      MACHINE_TYPE  NODE_VERSION     NUM_NODES  STATUS
autoscaling-cluster  us-central1-b  1.19.9-gke.1900  35.225.56.122  e2-medium     1.19.9-gke.1900  3          RUNNING
~>
-->


-->kubectl get all
NAME                              READY   STATUS    RESTARTS   AGE
pod/php-apache-869cb49f9b-wgmxf   1/1     Running   0          43s

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.103.240.1    <none>        443/TCP   7m3s
service/php-apache   ClusterIP   10.103.244.76   <none>        80/TCP    7s

NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/php-apache   1/1     1            1           43s

NAME                                    DESIRED   CURRENT   READY   AGE
replicaset.apps/php-apache-869cb49f9b   1         1         1       44s
~>
-->



-->kubectl create deployment php-apache --image=k8s.gcr.io/hpa-example
deployment.apps/php-apache created
~>
-->kubectl expose deployment php-apache --port=80
service/php-apache exposed
~>
-->kubectl get all
NAME                              READY   STATUS    RESTARTS   AGE
pod/php-apache-869cb49f9b-wgmxf   1/1     Running   0          43s

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.103.240.1    <none>        443/TCP   7m3s
service/php-apache   ClusterIP   10.103.244.76   <none>        80/TCP    7s

NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/php-apache   1/1     1            1           43s

NAME                                    DESIRED   CURRENT   READY   AGE
replicaset.apps/php-apache-869cb49f9b   1         1         1       44s
~>


-->kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=10
horizontalpodautoscaler.autoscaling/php-apache autoscaled
~>





-->kubectl run -i --tty load-generator1 --image=busybox /bin/sh
If you dont see a command prompt, try pressing enter.
/ #
/ # wget
BusyBox v1.33.1 (2021-06-07 17:33:50 UTC) multi-call binary.

Usage: wget [-cqS] [--spider] [-O FILE] [-o LOGFILE] [--header 'HEADER: VALUE'] [-Y on/off]
        [--no-check-certificate] [-P DIR] [-U AGENT] [-T SEC] URL...

Retrieve files via HTTP or FTP

        --spider        Only check URL existence: $? is 0 if exists
        --no-check-certificate  Don't validate the server's certificate
        -c              Continue retrieval of aborted transfer
        -q              Quiet
        -P DIR          Save to DIR (default .)
        -S              Show server response
        -T SEC          Network read timeout is SEC seconds
        -O FILE         Save to FILE ('-' for stdout)
        -o LOGFILE      Log messages to FILE
        -U STR          Use STR for User-Agent header
        -Y on/off       Use proxy
/ # wget -q -O- http://php-apache.default.svc.cluster.local
OK!/ # while true; do wget -q -O- http://php-apache.default.svc.cluster.local; done
OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!OK!O
