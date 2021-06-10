student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl create deployment --image nginx nginx-1
deployment.apps/nginx-1 created
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl get all
NAME                           READY   STATUS    RESTARTS   AGE
pod/nginx-1-6664c49886-z5nlk   1/1     Running   0          23s

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.12.0.1    <none>        443/TCP   13m

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-1   1/1     1            1           24s

NAME                                 DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-1-6664c49886   1         1         1       24s
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$



student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl get pod
NAME                       READY   STATUS    RESTARTS   AGE
nginx-1-6664c49886-z5nlk   1/1     Running   0          69s
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ export my_nginx_pod=nginx-1-6664c49886-z5nlk
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ echo $my_nginx_pod
nginx-1-6664c49886-z5nlk
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl describe pod $my_nginx_pod
Name:         nginx-1-6664c49886-z5nlk
Namespace:    default
Priority:     0
Node:         gke-standard-cluster-1-default-pool-8f8f56c9-tnnr/10.128.0.5
Start Time:   Thu, 10 Jun 2021 11:31:37 +0000
Labels:       app=nginx-1
              pod-template-hash=6664c49886
Annotations:  <none>
Status:       RunningIP:           10.8.3.2
IPs:
  IP:           10.8.3.2
Controlled By:  ReplicaSet/nginx-1-6664c49886
Containers:
  nginx:
    Container ID:   containerd://77efae9d09747c83e143006f5a91eec4daa1d00ef1474d01e1e5d1b3a05b2af0
    Image:          nginx
    Image ID:       docker.io/library/nginx@sha256:6d75c99af15565a301e48297fa2d121e15d80ad526f8369c526324f0f7ccb750
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Thu, 10 Jun 2021 11:31:43 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-qmq7k (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-qmq7k:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-qmq7k
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                 node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  115s  default-scheduler  Successfully assigned default/nginx-1-6664c49886-z5nlk to gke-standard-cluster-1-default-pool-8f8f56c9-tnnr
  Normal  Pulling    114s  kubelet            Pulling image "nginx"
  Normal  Pulled     110s  kubelet            Successfully pulled image "nginx" in 3.951378257s
  Normal  Created    109s  kubelet            Created container nginx
  Normal  Started    109s  kubelet            Started container nginx
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$




student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ ls -rtlh
total 8.0K
-rw-r--r-- 1 student_03_619f3f5ecafa student_03_619f3f5ecafa 913 Jun 10 11:14 README-cloudshell.txt
-rw-r--r-- 1 student_03_619f3f5ecafa student_03_619f3f5ecafa  89 Jun 10 11:34 test.html
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl cp ~/test.html $my_nginx_pod:/usr/share/nginx/html/test.html
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$


student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl expose pod $my_nginx_pod --port 80 --type LoadBalancer
service/nginx-1-6664c49886-z5nlk exposed
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl get all
NAME                           READY   STATUS    RESTARTS   AGE
pod/nginx-1-6664c49886-z5nlk   1/1     Running   0          5m2s
NAME                               TYPE           CLUSTER-IP    EXTERNAL-IP   PORT(S)        AGE
service/kubernetes                 ClusterIP      10.12.0.1     <none>        443/TCP        18m
service/nginx-1-6664c49886-z5nlk   LoadBalancer   10.12.9.248   <pending>     80:32699/TCP   7s

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-1   1/1     1            1           5m3s

NAME                                 DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-1-6664c49886   1         1         1       5m3s
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$


tudent_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl get all
NAME                           READY   STATUS    RESTARTS   AGE
pod/nginx-1-6664c49886-z5nlk   1/1     Running   0          6m3s

NAME                               TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)        AGE
service/kubernetes                 ClusterIP      10.12.0.1     <none>          443/TCP        19m
service/nginx-1-6664c49886-z5nlk   LoadBalancer   10.12.9.248   35.239.200.56   80:32699/TCP   69s

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-1   1/1     1            1           6m4s

NAME                                 DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-1-6664c49886   1         1         1       6m4s
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$


student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl get services
NAME                       TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)        AGE
kubernetes                 ClusterIP      10.12.0.1     <none>          443/TCP        20m
nginx-1-6664c49886-z5nlk   LoadBalancer   10.12.9.248   35.239.200.56   80:32699/TCP   2m2s
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$


student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ curl http://35.239.200.56/test.html
<html> <header><title>This is title</title></header>
        <body> Hello world </body>
</html>
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$

student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl top pods
W0610 11:40:17.414197    2719 top_pod.go:140] Using json format to get metrics. Next release will switch to protocol-buffers, switch early by passing --use-protocol-buffers flag
NAME                       CPU(cores)   MEMORY(bytes)
nginx-1-6664c49886-z5nlk   1m           3Mi
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$




git clone https://github.com/GoogleCloudPlatform/training-data-analyst

ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s

cd ~/ak8s/GKE_Shell/



student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ cd ~/ak8s/GKE_Shell/
student_03_619f3f5ecafa@cloudshell:~/ak8s/GKE_Shell (qwiklabs-gcp-02-7c7d8f502dfa)$ ls -rtlh
total 8.0K
-rw-r--r-- 1 student_03_619f3f5ecafa student_03_619f3f5ecafa  89 Jun 10 11:42 test.html
-rw-r--r-- 1 student_03_619f3f5ecafa student_03_619f3f5ecafa 176 Jun 10 11:42 new-nginx-pod.yaml
student_03_619f3f5ecafa@cloudshell:~/ak8s/GKE_Shell (qwiklabs-gcp-02-7c7d8f502dfa)$



student_03_619f3f5ecafa@cloudshell:~/ak8s/GKE_Shell (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl apply -f ./new-nginx-pod.yaml
pod/new-nginx created
student_03_619f3f5ecafa@cloudshell:~/ak8s/GKE_Shell (qwiklabs-gcp-02-7c7d8f502dfa)$


student_03_619f3f5ecafa@cloudshell:~/ak8s/GKE_Shell (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl get all
NAME                           READY   STATUS    RESTARTS   AGEpod/new-nginx                  1/1     Running   0          23s
pod/new-nginx                  1/1     Running   0          23s
pod/nginx-1-6664c49886-z5nlk   1/1     Running   0          14m

NAME                               TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)        AGE
service/kubernetes                 ClusterIP      10.12.0.1     <none>          443/TCP        27m
service/nginx-1-6664c49886-z5nlk   LoadBalancer   10.12.9.248   35.239.200.56   80:32699/TCP   9m5s

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx-1   1/1     1            1           14m

NAME                                 DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-1-6664c49886   1         1         1       14m
student_03_619f3f5ecafa@cloudshell:~/ak8s/GKE_Shell (qwiklabs-gcp-02-7c7d8f502dfa)$


kubectl port-forward new-nginx 10081:80
student_03_619f3f5ecafa@cloudshell:~/ak8s/GKE_Shell (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl port-forward new-nginx 10081:80
Forwarding from 127.0.0.1:10081 -> 80
Handling connection for 10081


student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ curl http://127.0.0.1:10081/test.html
<html> <header><title>This is title</title></header>
<body> Hello world </body>
</html>
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$



student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl logs new-nginx -f --timestamps
2021-06-10T11:45:20.050861569Z /docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
2021-06-10T11:45:20.050920829Z /docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
2021-06-10T11:45:20.052190409Z /docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
2021-06-10T11:45:20.059872022Z 10-listen-on-ipv6-by-default.sh: info: Getting the checksum of /etc/nginx/conf.d/default.conf
2021-06-10T11:45:20.065967643Z 10-listen-on-ipv6-by-default.sh: info: Enabled listen on IPv6 in /etc/nginx/conf.d/default.conf
2021-06-10T11:45:20.065990003Z /docker-entrypoint.sh: Launching /docker-entrypoint.d/20-envsubst-on-templates.sh
2021-06-10T11:45:20.068388414Z /docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
2021-06-10T11:45:20.069393984Z /docker-entrypoint.sh: Configuration complete; ready for start up
2021-06-10T11:45:20.073602266Z 2021/06/10 11:45:20 [notice] 1#1: using the "epoll" event method
2021-06-10T11:45:20.073649586Z 2021/06/10 11:45:20 [notice] 1#1: nginx/1.21.0
2021-06-10T11:45:20.073657246Z 2021/06/10 11:45:20 [notice] 1#1: built by gcc 8.3.0 (Debian 8.3.0-6)
2021-06-10T11:45:20.073662186Z 2021/06/10 11:45:20 [notice] 1#1: OS: Linux 5.4.89+
2021-06-10T11:45:20.073666496Z 2021/06/10 11:45:20 [notice] 1#1: getrlimit(RLIMIT_NOFILE): 1048576:1048576
2021-06-10T11:45:20.073713696Z 2021/06/10 11:45:20 [notice] 1#1: start worker processes
2021-06-10T11:45:20.074107166Z 2021/06/10 11:45:20 [notice] 1#1: start worker process 32
2021-06-10T11:45:20.074129086Z 2021/06/10 11:45:20 [notice] 1#1: start worker process 33
2021-06-10T11:53:01.165740435Z 127.0.0.1 - - [10/Jun/2021:11:53:01 +0000] "GET /test.html HTTP/1.1" 200 88 "-" "curl/7.64.0" "-"








