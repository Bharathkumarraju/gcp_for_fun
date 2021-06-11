student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ gcloud container node-pools create "temp-pool-1" \
> --cluster=$my_cluster --zone=$my_zone \
> --num-nodes "2" --node-labels=temp=true --preemptible
WARNING: Starting with version 1.19, newly created node-pools will have COS_CONTAINERD as the default node image when no image type is specified.
Creating node pool temp-pool-1...done.
Created [https://container.googleapis.com/v1/projects/qwiklabs-gcp-03-c0b415d0df5d/zones/us-central1-a/clusters/standard-cluster-1/nodePools/temp-pool-1].
NAME         MACHINE_TYPE  DISK_SIZE_GB  NODE_VERSION
temp-pool-1  e2-medium     100           1.19.9-gke.1900
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get nodes -o wide
NAME                                                STATUS   ROLES    AGE   VERSION            INTERNAL-IP   EXTERNAL-IP    OS-IMAGE                             KERNEL-VERSION   CONTAINER-RUNTIME
gke-standard-cluster-1-default-pool-ca555512-lmhp   Ready    <none>   32m   v1.19.9-gke.1900   10.128.0.3    35.239.39.41   Container-Optimized OS from Google   5.4.89+          containerd://1.4.3
gke-standard-cluster-1-default-pool-ca555512-nm8s   Ready    <none>   32m   v1.19.9-gke.1900   10.128.0.2    34.121.48.43   Container-Optimized OS from Google   5.4.89+          containerd://1.4.3
gke-standard-cluster-1-temp-pool-1-393a5adc-vvvj    Ready    <none>   21s   v1.19.9-gke.1900   10.128.0.4    34.71.104.73   Container-Optimized OS from Google   5.4.89+          containerd://1.4.3
gke-standard-cluster-1-temp-pool-1-393a5adc-xmgb    Ready    <none>   20s   v1.19.9-gke.1900   10.128.0.5    34.66.83.117   Container-Optimized OS from Google   5.4.89+          containerd://1.4.3
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$




student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get nodes -o wide -l temp=true
NAME                                               STATUS   ROLES    AGE   VERSION            INTERNAL-IP   EXTERNAL-IP    OS-IMAGE                             KERNEL-VERSION   CONTAINER-RUNTIME
gke-standard-cluster-1-temp-pool-1-393a5adc-vvvj   Ready    <none>   55s   v1.19.9-gke.1900   10.128.0.4    34.71.104.73   Container-Optimized OS from Google   5.4.89+          containerd://1.4.3
gke-standard-cluster-1-temp-pool-1-393a5adc-xmgb   Ready    <none>   54s   v1.19.9-gke.1900   10.128.0.5    34.66.83.117   Container-Optimized OS from Google   5.4.89+          containerd://1.4.3
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$




Control scheduling with taints and tolerations
--------------------------------------------------------->
To prevent the scheduler from running a Pod on the temporary nodes,
you add a taint to each of the nodes in the temp pool.
Taints are implemented as a key-value pair with an effect (such as NoExecute) that determines whether Pods can run on a certain node.
Only nodes that are configured to tolerate the key-value of the taint are scheduled to run on these nodes.

To add a taint to each of the newly created nodes, execute the following command.
You can use the temp=true label to apply this change across all the new nodes simultaneously.

kubectl taint node -l temp=true nodetype=preemptible:NoExecute


student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl taint node -l temp=true nodetype=preemptible:NoExecute
node/gke-standard-cluster-1-temp-pool-1-393a5adc-vvvj tainted
node/gke-standard-cluster-1-temp-pool-1-393a5adc-xmgb tainted
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$


To allow application Pods to execute on these tainted nodes, you must add a tolerations key to the deployment configuration.


Edit the web.yaml file to add the following key in the templates spec section:
tolerations:
- key: "nodetype"
  operator: Equal
  value: "preemptible"


...
    spec:
      tolerations:
      - key: "nodetype"
        operator: Equal
        value: "preemptible"
      containers:
      - image: gcr.io/google-samples/hello-app:1.0
        name: web
        ports:
        - containerPort: 8080
          protocol: TCP
        resources:
          # You must specify requests for CPU to autoscale
          # based on CPU utilization
          requests:
            cpu: "250m"
...

To force the web deployment to use the new node-pool add a nodeSelector key in the templates spec section. This is parallel to the tolerations key you just added.
...
     nodeSelector:
        temp: "true"
...


Note: GKE adds a custom label to each node called cloud.google.com/gke-nodepool
that contains the name of the node-pool that the node belongs to.
This key can also be used as part of a nodeSelector to ensure Pods are only deployed to suitable nodes.

student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get pods
NAME                   READY   STATUS    RESTARTS   AGE
web-65dcc68dfb-tp2sc   1/1     Running   0          14s
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl describe pods -l run=web
Name:         web-65dcc68dfb-tp2sc
Namespace:    default
Priority:     0
Node:         gke-standard-cluster-1-temp-pool-1-393a5adc-xmgb/10.128.0.5
Start Time:   Fri, 11 Jun 2021 01:53:44 +0000
Labels:       pod-template-hash=65dcc68dfb
              run=web
Annotations:  <none>
Status:       Running
IP:           10.8.3.3
IPs:
  IP:           10.8.3.3
Controlled By:  ReplicaSet/web-65dcc68dfb
Containers:
  web:
    Container ID:   containerd://d85659c46bcd411fe5887eceec420e60d80d96f48c7b8ecf2f3ab1474c5eecf7
    Image:          gcr.io/google-samples/hello-app:1.0
    Image ID:       gcr.io/google-samples/hello-app@sha256:1353d0777e00139fccb6db5229447ed812c11b0ad061b1bcceafd73464ee5cb0
    Port:           8080/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Fri, 11 Jun 2021 01:53:45 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-g6cfv (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-g6cfv:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-g6cfv
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  temp=true
Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                 node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
                 nodetype=preemptible
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  44s   default-scheduler  Successfully assigned default/web-65dcc68dfb-tp2sc to gke-standard-cluster-1-temp-pool-1-393a5adc-xmgb
  Normal  Pulled     43s   kubelet            Container image "gcr.io/google-samples/hello-app:1.0" already present on machine
  Normal  Created    43s   kubelet            Created container web
  Normal  Started    43s   kubelet            Started container web
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$



student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get pods -o wide
NAME                       READY   STATUS    RESTARTS   AGE     IP          NODE                                                NOMINATED NODE   READINESS GATES
loadgen-669c946894-chbjk   1/1     Running   0          3m1s    10.8.0.11   gke-standard-cluster-1-default-pool-ca555512-nm8s   <none>           <none>
loadgen-669c946894-dtp6p   1/1     Running   0          3m1s    10.8.1.8    gke-standard-cluster-1-default-pool-ca555512-lmhp   <none>           <none>
loadgen-669c946894-fgj7m   1/1     Running   0          3m1s    10.8.1.9    gke-standard-cluster-1-default-pool-ca555512-lmhp   <none>           <none>
loadgen-669c946894-mcgpw   1/1     Running   0          3m1s    10.8.1.10   gke-standard-cluster-1-default-pool-ca555512-lmhp   <none>           <none>
web-65dcc68dfb-tp2sc       1/1     Running   0          6m37s   10.8.3.3    gke-standard-cluster-1-temp-pool-1-393a5adc-xmgb    <none>           <none>
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$



