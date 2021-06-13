Task 2. Configure liveness probes
Configure a liveness probe
In this task you will deploy a liveness probe to detect applications that have transitioned from a running state to a broken state.
Sometimes, applications are temporarily unable to serve traffic.
For example, an application might need to load large data or configuration files during startup.
In such cases, you don't want to kill the application, but you don't want to send it requests either.
 Kubernetes provides readiness probes to detect and mitigate these situations.
A Pod with containers reporting that they are not ready does not receive traffic through Kubernetes Services.

Readiness probes are configured similarly to liveness probes. The only difference is that you use the readinessProbe field instead of the livenessProbe field.

A Pod definition file called exec-liveness.yaml has been provided for you that defines a simple container called liveness running Busybox and
a liveness probe that uses the cat command against the file /tmp/healthy within the container to test for liveness every 5 seconds.
The startup script for the liveness container creates the /tmp/healthy on startup and then deletes it 30 seconds later to simulate an outage that the Liveness probe can detect.



student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$ kubectl create -f exec-liveness.yaml
pod/liveness-exec created
student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$ kubectl describe pod liveness-exec
Name:         liveness-exec
Namespace:    default
Priority:     0
Node:         gke-standard-cluster-1-default-pool-a1701cec-ljdl/10.128.0.2
Start Time:   Sun, 13 Jun 2021 05:29:31 +0000
Labels:       test=liveness
Annotations:  <none>
Status:       Running
IP:           10.8.1.6
IPs:
  IP:  10.8.1.6
Containers:
  liveness:
    Container ID:  containerd://ee47da1b4b055d200d98d5bd4d58429b33491542d84e96d5bd2bd51367afee74
    Image:         k8s.gcr.io/busybox
    Image ID:      sha256:36a4dca0fe6fb2a5133dc11a6c8907a97aea122613fa3e98be033959a0821a1f
    Port:          <none>
    Host Port:     <none>
    Args:
      /bin/sh
      -c
      touch /tmp/healthy; sleep 30; rm -rf /tmp/healthy; sleep 600
    State:          Running
      Started:      Sun, 13 Jun 2021 05:29:32 +0000
    Ready:          True
    Restart Count:  0
    Liveness:       exec [cat /tmp/healthy] delay=5s timeout=1s period=5s #success=1 #failure=3
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-7djdm (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-7djdm:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-7djdm
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                 node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  19s   default-scheduler  Successfully assigned default/liveness-exec to gke-standard-cluster-1-default-pool-a1701cec-ljdl
  Normal  Pulling    18s   kubelet            Pulling image "k8s.gcr.io/busybox"
  Normal  Pulled     18s   kubelet            Successfully pulled image "k8s.gcr.io/busybox" in 316.959473ms
  Normal  Created    18s   kubelet            Created container liveness
  Normal  Started    18s   kubelet            Started container liveness
student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$




student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$ kubectl describe pod liveness-exec
Name:         liveness-exec
Namespace:    default
Priority:     0
Node:         gke-standard-cluster-1-default-pool-a1701cec-ljdl/10.128.0.2
Start Time:   Sun, 13 Jun 2021 05:29:31 +0000
Labels:       test=liveness
Annotations:  <none>
Status:       Running
IP:           10.8.1.6
IPs:
  IP:  10.8.1.6
Containers:
  liveness:
    Container ID:  containerd://ee47da1b4b055d200d98d5bd4d58429b33491542d84e96d5bd2bd51367afee74
    Image:         k8s.gcr.io/busybox
    Image ID:      sha256:36a4dca0fe6fb2a5133dc11a6c8907a97aea122613fa3e98be033959a0821a1f
    Port:          <none>
    Host Port:     <none>
    Args:
      /bin/sh
      -c
      touch /tmp/healthy; sleep 30; rm -rf /tmp/healthy; sleep 600
    State:          Running
      Started:      Sun, 13 Jun 2021 05:29:32 +0000
    Ready:          True
    Restart Count:  0
    Liveness:       exec [cat /tmp/healthy] delay=5s timeout=1s period=5s #success=1 #failure=3
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-7djdm (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-7djdm:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-7djdm
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                 node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason     Age               From               Message
  ----     ------     ----              ----               -------
  Normal   Scheduled  52s               default-scheduler  Successfully assigned default/liveness-exec to gke-standard-cluster-1-default-pool-a1701cec-ljdl
  Normal   Pulling    51s               kubelet            Pulling image "k8s.gcr.io/busybox"
  Normal   Pulled     51s               kubelet            Successfully pulled image "k8s.gcr.io/busybox" in 316.959473ms
  Normal   Created    51s               kubelet            Created container liveness
  Normal   Started    51s               kubelet            Started container liveness
  Warning  Unhealthy  9s (x3 over 19s)  kubelet            Liveness probe failed: cat: cant open '/tmp/healthy': No such file or directory
  Normal   Killing    9s                kubelet            Container liveness failed liveness probe, will be restarted
student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$




student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$
student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$ kubectl get pod liveness-exec
NAME            READY   STATUS    RESTARTS   AGE
liveness-exec   1/1     Running   1          87s
student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$ kubectl get pod liveness-exec
NAME            READY   STATUS    RESTARTS   AGE
liveness-exec   1/1     Running   1          90s
student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$ kubectl delete pod liveness-exec
pod "liveness-exec" deleted

student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$
student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$


kubectl describe service readiness-svc




student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$ echo $RANDOM
26022
student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$ echo $RANDOM
13217
student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$ echo $RANDOM
18605
student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$ echo $RANDOM
26831
student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$ echo $RANDOM
32608
student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$ kubectl create -f readiness-deployment.yaml
deployment.apps/readiness-deployment created
student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$ kubectl get pods
NAME                                    READY   STATUS    RESTARTS   AGE
readiness-deployment-54bc89fdf9-gqx8p   0/1     Running   0          9s
readiness-deployment-54bc89fdf9-l6fxk   0/1     Running   0          9s
readiness-deployment-54bc89fdf9-nsdcc   0/1     Running   0          9s
student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$ kubectl create -f readiness-service.yaml
service/readiness-svc created
student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$ kubectl describe service readiness-svc
Name:                     readiness-svc
Namespace:                default
Labels:                   <none>
Annotations:              <none>
Selector:                 app=readiness-test
Type:                     LoadBalancer
IP Families:              <none>
IP:                       10.11.242.181
IPs:                      <none>
Port:                     <unset>  80/TCP
TargetPort:               8080/TCP
NodePort:                 <unset>  32044/TCP
Endpoints:                10.8.0.7:8080,10.8.1.7:8080,10.8.1.8:8080
Session Affinity:         None
External Traffic Policy:  Cluster
Events:
  Type    Reason                Age   From                Message
  ----    ------                ----  ----                -------
  Normal  EnsuringLoadBalancer  7s    service-controller  Ensuring load balancer
student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$
student_03_a49c790726e7@cloudshell:~/ak8s/Probes (qwiklabs-gcp-02-2e1254f182de)$
