bharath@cloudshell:~ (learngcp-316009)$ gcloud container clusters create spikey-cluster --zone us-central1-a
WARNING: Starting in January 2021, clusters will use the Regular release channel by default when `--cluster-version`, `--release-channel`, `--no-enable-autoupgrade`, and `--no-enable-autorepair` flags are not specified.
WARNING: Currently VPC-native is not the default mode during cluster creation. In the future, this will become the default mode and can be disabled using `--no-enable-ip-alias` flag. Use `--[no-]enable-ip-alias` flag to suppress this warning.
WARNING: Starting with version 1.18, clusters will have shielded GKE nodes by default.
WARNING: Your Pod address range (`--cluster-ipv4-cidr`) can accommodate at most 1008 node(s).
WARNING: Starting with version 1.19, newly created clusters and node-pools will have COS_CONTAINERD as the default node image when no image type is specified.
Creating cluster spikey-cluster in us-central1-a... Cluster is being health-checked (master is healthy)...done.
Created [https://container.googleapis.com/v1/projects/learngcp-316009/zones/us-central1-a/clusters/spikey-cluster].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/us-central1-a/spikey-cluster?project=learngcp-316009
kubeconfig entry generated for spikey-cluster.
NAME            LOCATION       MASTER_VERSION   MASTER_IP     MACHINE_TYPE  NODE_VERSION     NUM_NODES  STATUS
spikey-cluster  us-central1-a  1.19.9-gke.1900  34.72.41.109  e2-medium     1.19.9-gke.1900  3          RUNNING
bharath@cloudshell:~ (learngcp-316009)$


bharath@cloudshell:~ (learngcp-316009)$ export PROJECT_ID="$(gcloud config get-value project -q)"
Your active configuration is: [cloudshell-13483]
bharath@cloudshell:~ (learngcp-316009)$ echo $PROJECT_ID
learngcp-316009
bharath@cloudshell:~ (learngcp-316009)$ cd spikey-website/
bharath@cloudshell:~/spikey-website (learngcp-316009)$ docker build -t gcr.io/${PROJECT_ID}/spikeysales-website:v1 .
Sending build context to Docker daemon  11.78kB
Step 1/3 : FROM nginx:alpine
alpine: Pulling from library/nginx
540db60ca938: Pull complete0ae30075c5da: Pull complete9da81141e74e: Pull complete
b2e41dd2ded0: Pull complete
7f40e809fb2d: Pull complete
758848c48411: Pull complete
Digest: sha256:0f8595aa040ec107821e0409a1dd3f7a5e989501d5c8d5b5ca1f955f33ac81a0
Status: Downloaded newer image for nginx:alpine
 ---> a6eb2a334a9f
Step 2/3 : COPY default.conf /etc/nginx/conf.d/default.conf
 ---> b83a84edcc8d
Step 3/3 : COPY index.html /usr/share/nginx/html/index.html
 ---> 971b8a76b8b5
Successfully built 971b8a76b8b5
Successfully tagged gcr.io/learngcp-316009/spikeysales-website:v1
bharath@cloudshell:~/spikey-website (learngcp-316009)$



bharath@cloudshell:~/spikey-website (learngcp-316009)$ gcloud auth configure-docker
WARNING: Your config file at [/home/bharath/.docker/config.json] contains these credential helper entries:

{
  "credHelpers": {
    "gcr.io": "gcloud",
    "us.gcr.io": "gcloud",
    "eu.gcr.io": "gcloud",
    "asia.gcr.io": "gcloud",    "staging-k8s.gcr.io": "gcloud",    "marketplace.gcr.io": "gcloud"
  }
}
Adding credentials for all GCR repositories.
WARNING: A long list of credential helpers may cause delays running 'docker build'. We recommend passing the registry name to configure only the registry you are using.
gcloud credential helpers already registered correctly.
bharath@cloudshell:~/spikey-website (learngcp-316009)$


bharath@cloudshell:~/spikey-website (learngcp-316009)$ docker push gcr.io/${PROJECT_ID}/spikeysales-website:v1
The push refers to repository [gcr.io/learngcp-316009/spikeysales-website]
8ea49991fae8: Pushed
39fbbc9bac00: Pushed
058eb06e0efd: Layer already exists
2f2df3ae0cad: Layer already exists
2b60f0243825: Layer already exists
96131b349b16: Layer already exists
a42a23cd7b07: Layer already exists
b2d5eeeaba3a: Layer already exists
v1: digest: sha256:3db3141042dc0705a7e2b90b0df857acbfc2bc2d2d3cd0f8c21d49359cb8b6a1 size: 1983
bharath@cloudshell:~/spikey-website (learngcp-316009)$ gcloud container clusters get-credentials spikey-cluster --zone us-central1-a
Fetching cluster endpoint and auth data.
kubeconfig entry generated for spikey-cluster.
bharath@cloudshell:~/spikey-website (learngcp-316009)$ source <(kubectl completion bash)
bharath@cloudshell:~/spikey-website (learngcp-316009)$ kubectl cluster-info
Kubernetes control plane is running at https://34.72.41.109
GLBCDefaultBackend is running at https://34.72.41.109/api/v1/namespaces/kube-system/services/default-http-backend:http/proxy
KubeDNS is running at https://34.72.41.109/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
Metrics-server is running at https://34.72.41.109/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
bharath@cloudshell:~/spikey-website (learngcp-316009)$
bharath@cloudshell:~/spikey-website (learngcp-316009)$



bharath@cloudshell:~/spikey-website (learngcp-316009)$ kubectl create deployment spikey-web --image gcr.io/learngcp-316009/spikeysales-website:v1 --replicas 3
deployment.apps/spikey-web created
bharath@cloudshell:~/spikey-website (learngcp-316009)$ kubectl expose deployment spikey-web --type LoadBalancer --port 80 --target-port 80
service/spikey-web exposed
bharath@cloudshell:~/spikey-website (learngcp-316009)$ kubectl get all
NAME                              READY   STATUS    RESTARTS   AGE
pod/spikey-web-58bd7458fc-4d2rg   1/1     Running   0          52s
pod/spikey-web-58bd7458fc-xhlgx   1/1     Running   0          53s
pod/spikey-web-58bd7458fc-zqxs4   1/1     Running   0          52s

NAME                 TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/kubernetes   ClusterIP      10.3.240.1     <none>        443/TCP        14m
service/spikey-web   LoadBalancer   10.3.249.183   <pending>     80:30262/TCP   9sNAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/spikey-web   3/3     3            3           54s

NAME                                    DESIRED   CURRENT   READY   AGE
replicaset.apps/spikey-web-58bd7458fc   3         3         3       54s
bharath@cloudshell:~/spikey-website (learngcp-316009)$




bharath@cloudshell:~/spikey-website (learngcp-316009)$ kubectl delete service spikey-web
service "spikey-web" deleted
bharath@cloudshell:~/spikey-website (learngcp-316009)$

bharath@cloudshell:~/spikey-website (learngcp-316009)$ kubectl delete deployments spikey-web
deployment.apps "spikey-web" deleted
bharath@cloudshell:~/spikey-website (learngcp-316009)$ kubectl create deployment spikey-web --image gcr.io/learngcp-316009/spikeysales-website:v1
deployment.apps/spikey-web created
bharath@cloudshell:~/spikey-website (learngcp-316009)$ kubectl expose deployment spikey-web --type NodePort --port 80 --target-port 80
service/spikey-web exposed
bharath@cloudshell:~/spikey-website (learngcp-316009)$ kubectl get all
NAME                              READY   STATUS    RESTARTS   AGE
pod/spikey-web-58bd7458fc-k8jr4   1/1     Running   0          30s

NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/kubernetes   ClusterIP   10.3.240.1     <none>        443/TCP        21m
service/spikey-web   NodePort    10.3.242.102   <none>        80:31807/TCP   11s

NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/spikey-web   1/1     1            1           31s

NAME                                    DESIRED   CURRENT   READY   AGE
replicaset.apps/spikey-web-58bd7458fc   1         1         1       31s
bharath@cloudshell:~/spikey-website (learngcp-316009)$



bharath@cloudshell:~/spikey-website (learngcp-316009)$ ls
default.conf  Dockerfile  index.html  ingress.yaml
bharath@cloudshell:~/spikey-website (learngcp-316009)$ kubectl apply -f ingress.yaml
Warning: extensions/v1beta1 Ingress is deprecated in v1.14+, unavailable in v1.22+; use networking.k8s.io/v1 Ingress
ingress.extensions/spikey-website-ingress created
bharath@cloudshell:~/spikey-website (learngcp-316009)$ kubectl get ingress spikey-website-ingress --watch
NAME                     CLASS    HOSTS   ADDRESS   PORTS   AGE
spikey-website-ingress   <none>   *                 80      28s
spikey-website-ingress   <none>   *       34.117.187.51   80      39s
spikey-website-ingress   <none>   *       34.117.187.51   80      40s
bharath@cloudshell:~/spikey-website (learngcp-316009)$


bharath@cloudshell:~/spikey-website (learngcp-316009)$ kubectl get ingress
NAME                     CLASS    HOSTS   ADDRESS         PORTS   AGE
spikey-website-ingress   <none>   *       34.117.187.51   80      3m2s
bharath@cloudshell:~/spikey-website (learngcp-316009)$ kubectl describe ingress spikey-website-ingress
Name:             spikey-website-ingress
Namespace:        default
Address:          34.117.187.51
Default backend:  spikey-web:80 (10.0.0.7:80)
Rules:
  Host        Path  Backends
  ----        ----  --------
  *           *     spikey-web:80 (10.0.0.7:80)
Annotations:  ingress.kubernetes.io/backends: {"k8s-be-31807--02604f6d0ff3392a":"Unknown"}
              ingress.kubernetes.io/forwarding-rule: k8s2-fr-lsy91dpw-default-spikey-website-ingress-ra1uu4a1
              ingress.kubernetes.io/target-proxy: k8s2-tp-lsy91dpw-default-spikey-website-ingress-ra1uu4a1
              ingress.kubernetes.io/url-map: k8s2-um-lsy91dpw-default-spikey-website-ingress-ra1uu4a1
Events:
  Type    Reason     Age                    From                     Message
  ----    ------     ----                   ----                     -------
  Normal  Sync       2m45s                  loadbalancer-controller  UrlMap "k8s2-um-lsy91dpw-default-spikey-website-ingress-ra1uu4a1" created
  Normal  Sync       2m43s                  loadbalancer-controller  TargetProxy "k8s2-tp-lsy91dpw-default-spikey-website-ingress-ra1uu4a1" created
  Normal  Sync       2m38s                  loadbalancer-controller  ForwardingRule "k8s2-fr-lsy91dpw-default-spikey-website-ingress-ra1uu4a1" created
  Normal  IPChanged  2m38s                  loadbalancer-controller  IP is now 34.117.187.51
  Normal  Sync       2m37s (x4 over 3m17s)  loadbalancer-controller  Scheduled for sync
bharath@cloudshell:~/spikey-website (learngcp-316009)$


bharath@cloudshell:~/spikey-wordpress (learngcp-316009)$ kubectl apply -f mysql-volumeclaim.yaml
persistentvolumeclaim/spikey-mysql-volumeclaim created
bharath@cloudshell:~/spikey-wordpress (learngcp-316009)$ kubectl apply -f wordpress-volumeclaim.yaml
persistentvolumeclaim/spikey-wordpress-volumeclaim created
bharath@cloudshell:~/spikey-wordpress (learngcp-316009)$ kubectl get pvc
NAME                           STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
spikey-mysql-volumeclaim       Bound    pvc-3814a8c4-d98f-4c27-8c27-ce8f80e12deb   200Gi      RWO            standard       19s
spikey-wordpress-volumeclaim   Bound    pvc-3082b8e4-9ae5-41f1-8dbf-52ce890f1f32   200Gi      RWO            standard       7s
bharath@cloudshell:~/spikey-wordpress (learngcp-316009)$





