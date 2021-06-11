configure the cluster to automatically scale the sample application that you deployed earlier.



To configure your sample application for autoscaling (and to set the maximum number of replicas to four and the minimum to one, with a CPU utilization target of 1%), execute the following command:


student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl autoscale deployment web  --max 4 --min 1 --cpu-percent 1
horizontalpodautoscaler.autoscaling/web autoscaled
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$


student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get all
NAME                      READY   STATUS    RESTARTS   AGE
pod/web-98c9d48b4-bwjb7   1/1     Running   0          6m2s

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/kubernetes   ClusterIP   10.11.240.1     <none>        443/TCP          16m
service/web          NodePort    10.11.249.186   <none>        8080:31898/TCP   5m21s

NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/web   1/1     1            1           6m3s

NAME                            DESIRED   CURRENT   READY   AGE
replicaset.apps/web-98c9d48b4   1         1         1       6m3s

NAME                                      REFERENCE        TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
horizontalpodautoscaler.autoscaling/web   Deployment/web   0%/1%     1         4         1          37s
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get deployment
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
web    1/1     1            1           6m31s
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$



student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl describe hpa web
Name:                                                  web
Namespace:                                             default
Labels:                                                <none>
Annotations:                                           <none>
CreationTimestamp:                                     Fri, 11 Jun 2021 01:24:53 +0000
Reference:                                             Deployment/web
Metrics:                                               ( current / target )
  resource cpu on pods  (as a percentage of request):  0% (0) / 1%
Min replicas:                                          1
Max replicas:                                          4
Deployment pods:                                       1 current / 1 desired
Conditions:
  Type            Status  Reason               Message
  ----            ------  ------               -------
  AbleToScale     True    ScaleDownStabilized  recent recommendations were higher than current one, applying the highest recent recommendation
  ScalingActive   True    ValidMetricFound     the HPA was able to successfully calculate a replica count from cpu resource utilization (percentage of request)
  ScalingLimited  False   DesiredWithinRange   the desired count is within the acceptable range
Events:           <none>
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$


student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get hpa web -o wide
NAME   REFERENCE        TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
web    Deployment/web   0%/1%     1         4         1          2m38s
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$




student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get hpa web -o yaml
apiVersion: autoscaling/v1
kind: HorizontalPodAutoscaler
metadata:
  annotations:
    autoscaling.alpha.kubernetes.io/conditions: '[{"type":"AbleToScale","status":"True","lastTransitionTime":"2021-06-11T01:25:09Z","reason":"ScaleDownStabilized","message":"recent
      recommendations were higher than current one, applying the highest recent recommendation"},{"type":"ScalingActive","status":"True","lastTransitionTime":"2021-06-11T01:25:09Z","reason":"ValidMetricFound","message":"the
      HPA was able to successfully calculate a replica count from cpu resource utilization
      (percentage of request)"},{"type":"ScalingLimited","status":"False","lastTransitionTime":"2021-06-11T01:25:09Z","reason":"DesiredWithinRange","message":"the
      desired count is within the acceptable range"}]'
    autoscaling.alpha.kubernetes.io/current-metrics: '[{"type":"Resource","resource":{"name":"cpu","currentAverageUtilization":0,"currentAverageValue":"0"}}]'
  creationTimestamp: "2021-06-11T01:24:53Z"
  name: web
  namespace: default
  resourceVersion: "7405"
  selfLink: /apis/autoscaling/v1/namespaces/default/horizontalpodautoscalers/web
  uid: 27260216-5f54-4f33-90c7-bbf6067a1217
spec:
  maxReplicas: 4
  minReplicas: 1
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: web
  targetCPUUtilizationPercentage: 1
status:
  currentCPUUtilizationPercentage: 0
  currentReplicas: 1
  desiredReplicas: 1
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$





/ # curl http://localhost:8080
Hello, world!
Version: 1.0.0
Hostname: web-98c9d48b4-bwjb7
/ # curl http://web:8080
Hello, world!
Version: 1.0.0
Hostname: web-98c9d48b4-bwjb7
/ # nslookup web
Server:         10.11.240.10
Address:        10.11.240.10:53

** server can't find web.svc.cluster.local: NXDOMAIN

** server can't find web.cluster.local: NXDOMAIN

Non-authoritative answer:
Name:   web.default.svc.cluster.local
Address: 10.11.249.186


/ # exit
command terminated with exit code 1
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ ls -rtlh
total 12K
-rw-r--r-- 1 student_04_266ad823bd1a student_04_266ad823bd1a 507 Jun 11 01:18 web.yaml
-rw-r--r-- 1 student_04_266ad823bd1a student_04_266ad823bd1a 484 Jun 11 01:18 web-tolerations.yaml
-rw-r--r-- 1 student_04_266ad823bd1a student_04_266ad823bd1a 379 Jun 11 01:18 loadgen.yaml
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl apply -f loadgen.yaml
deployment.apps/loadgen created
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get deployment web --watch
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
web    2/4     4            2           13m
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get deployments --watch
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
loadgen   4/4     4            4           46s
web       2/4     4            2           14m
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get hpa --watch
NAME   REFERENCE        TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
web    Deployment/web   73%/1%    1         4         4          9m6s
web    Deployment/web   74%/1%    1         4         4          9m18s
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$

student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get hpa
NAME   REFERENCE        TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
web    Deployment/web   88%/1%    1         4         4          11m
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$






student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl scale deployment loadgen  --replicas=0
deployment.apps/loadgen scaled
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get deployment
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
loadgen   0/0     0            0           4m23s
web       2/4     4            2           17m
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get deployment
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
loadgen   0/0     0            0           4m29s
web       2/4     4            2           17m
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get hpa
NAME   REFERENCE        TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
web    Deployment/web   78%/1%    1         4         4          12m
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get hpa
NAME   REFERENCE        TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
web    Deployment/web   78%/1%    1         4         4          12m
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get deployment
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
loadgen   0/0     0            0           4m50s
web       2/4     4            2           18m
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$




student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get deployment
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
loadgen   0/0     0            0           6m28s
web       2/4     4            2           19m
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get hpa
NAME   REFERENCE        TARGETS   MINPODS   MAXPODS   REPLICAS   AGE
web    Deployment/web   0%/1%     1         4         4          14m
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl top pods
W0611 01:39:29.836395    1521 top_pod.go:140] Using json format to get metrics. Next release will switch to protocol-buffers, switch early by passing --use-protocol-buffers flag
NAME                  CPU(cores)   MEMORY(bytes)
web-98c9d48b4-bwjb7   1m           10Mi
web-98c9d48b4-tn9ws   1m           6Mi
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$
