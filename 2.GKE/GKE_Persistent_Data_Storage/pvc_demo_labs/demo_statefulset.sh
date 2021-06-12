student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ ls
pod-volume-demo.yaml  pvc-demo.yaml  statefulset-demo.yaml
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl apply -f statefulset-demo.yaml
service/statefulset-demo-service created
statefulset.apps/statefulset-demo created
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl describe statefulset statefulset-demo
Name:               statefulset-demo
Namespace:          default
CreationTimestamp:  Sat, 12 Jun 2021 23:08:21 +0000
Selector:           app=MyApp
Labels:             <none>
Annotations:        <none>
Replicas:           3 desired | 1 total
Update Strategy:    RollingUpdate
Pods Status:        0 Running / 1 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  app=MyApp
  Containers:
   stateful-set-container:
    Image:        nginx
    Port:         80/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:
      /var/www/html from hello-web-disk (rw)
  Volumes:  <none>
Volume Claims:
  Name:          hello-web-disk
  StorageClass:
  Labels:        <none>
  Annotations:   <none>
  Capacity:      30Gi
  Access Modes:  [ReadWriteOnce]
Events:
  Type    Reason            Age   From                    Message
  ----    ------            ----  ----                    -------
  Normal  SuccessfulCreate  11s   statefulset-controller  create Claim hello-web-disk-statefulset-demo-0 Pod statefulset-demo-0 in StatefulSet statefulset-demo success
  Normal  SuccessfulCreate  11s   statefulset-controller  create Pod statefulset-demo-0 in StatefulSet statefulset-demo successful
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$



student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get pods
NAME                 READY   STATUS    RESTARTS   AGE
statefulset-demo-0   1/1     Running   0          78s
statefulset-demo-1   1/1     Running   0          65s
statefulset-demo-2   1/1     Running   0          46s
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get pods -o wide
NAME                 READY   STATUS    RESTARTS   AGE   IP         NODE                                                NOMINATED NODE   READINESS GATES
statefulset-demo-0   1/1     Running   0          99s   10.8.0.8   gke-standard-cluster-1-default-pool-83385860-5ktw   <none>           <none>
statefulset-demo-1   1/1     Running   0          86s   10.8.1.7   gke-standard-cluster-1-default-pool-83385860-7b47   <none>           <none>
statefulset-demo-2   1/1     Running   0          67s   10.8.0.9   gke-standard-cluster-1-default-pool-83385860-5ktw   <none>           <none>
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get pvc -o wide
NAME                                STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE    VOLUMEMODE
hello-web-disk                      Bound    pvc-9e002382-3b49-4ae4-b579-3cf6f27862ee   30Gi       RWO            standard       12m    Filesystem
hello-web-disk-statefulset-demo-0   Bound    pvc-f5fbcfd2-6700-4085-bebc-5a8bdbe8c22b   30Gi       RWO            standard       109s   Filesystem
hello-web-disk-statefulset-demo-1   Bound    pvc-4c567f33-e0b9-4af3-9f85-db1eb8cac7e1   30Gi       RWO            standard       96s    Filesystem
hello-web-disk-statefulset-demo-2   Bound    pvc-8e84a1e2-6091-4890-b0e9-e1a742c1d242   30Gi       RWO            standard       77s    Filesystem
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl describe pvc hello-web-disk-statefulset-demo-0
Name:          hello-web-disk-statefulset-demo-0
Namespace:     default
StorageClass:  standard
Status:        Bound
Volume:        pvc-f5fbcfd2-6700-4085-bebc-5a8bdbe8c22b
Labels:        app=MyApp
Annotations:   pv.kubernetes.io/bind-completed: yes
               pv.kubernetes.io/bound-by-controller: yes
               volume.beta.kubernetes.io/storage-provisioner: kubernetes.io/gce-pd
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      30Gi
Access Modes:  RWO
VolumeMode:    Filesystem
Used By:       statefulset-demo-0
Events:
  Type    Reason                 Age    From                         Message
  ----    ------                 ----   ----                         -------
  Normal  ProvisioningSucceeded  2m16s  persistentvolume-controller  Successfully provisioned volume pvc-f5fbcfd2-6700-4085-bebc-5a8bdbe8c22b using kubernetes.io/gce-pd
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$




Task 4. Verify the persistence of Persistent Volume connections to Pods managed by StatefulSets



student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get pods
NAME                 READY   STATUS    RESTARTS   AGE
statefulset-demo-0   1/1     Running   0          3m28s
statefulset-demo-1   1/1     Running   0          3m15s
statefulset-demo-2   1/1     Running   0          2m56s
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl exec -it statefulset-demo-0 -- sh
# echo Test webpage in a persistent volume!>/var/www/html/index.html
# chmod +x /var/www/html/index.html
# cat /var/www/html/index.html
Test webpage in a persistent volume!
# cat /var/www/html/index.html
Test webpage in a persistent volume!
# exit
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl delete pod statefulset-demo-0
pod "statefulset-demo-0" deleted
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get pods --watch
NAME                 READY   STATUS              RESTARTS   AGE
statefulset-demo-0   0/1     ContainerCreating   0          7s
statefulset-demo-1   1/1     Running             0          4m47s
statefulset-demo-2   1/1     Running             0          4m28s
statefulset-demo-0   1/1     Running             0          10s
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$


student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get pods
NAME                 READY   STATUS    RESTARTS   AGE
statefulset-demo-0   1/1     Running   0          2m
statefulset-demo-1   1/1     Running   0          6m40s
statefulset-demo-2   1/1     Running   0          6m21s
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl exec -it statefulset-demo-0 -- sh
# cat /var/www/html/index.html
Test webpage in a persistent volume!
#


