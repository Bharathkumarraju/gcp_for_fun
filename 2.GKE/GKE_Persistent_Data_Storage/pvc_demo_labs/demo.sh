student_02_63312c3fb221@cloudshell:~ (qwiklabs-gcp-02-22e67f7e8e87)$ export my_cluster=standard-cluster-1
student_02_63312c3fb221@cloudshell:~ (qwiklabs-gcp-02-22e67f7e8e87)$ export my_zone=us-central1-a
student_02_63312c3fb221@cloudshell:~ (qwiklabs-gcp-02-22e67f7e8e87)$ gcloud container clusters get-credentials $my_cluster --zone $my_zone
Fetching cluster endpoint and auth data.
kubeconfig entry generated for standard-cluster-1.
student_02_63312c3fb221@cloudshell:~ (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://34.67.50.51
  name: gke_qwiklabs-gcp-02-22e67f7e8e87_us-central1-a_standard-cluster-1
contexts:
- context:
    cluster: gke_qwiklabs-gcp-02-22e67f7e8e87_us-central1-a_standard-cluster-1
    user: gke_qwiklabs-gcp-02-22e67f7e8e87_us-central1-a_standard-cluster-1
  name: gke_qwiklabs-gcp-02-22e67f7e8e87_us-central1-a_standard-cluster-1
current-context: gke_qwiklabs-gcp-02-22e67f7e8e87_us-central1-a_standard-cluster-1
kind: Config
preferences: {}
users:
- name: gke_qwiklabs-gcp-02-22e67f7e8e87_us-central1-a_standard-cluster-1
  user:
    auth-provider:
      config:
        cmd-args: config config-helper --format=json
        cmd-path: /usr/lib/google-cloud-sdk/bin/gcloud
        expiry-key: '{.credential.token_expiry}'
        token-key: '{.credential.access_token}'
      name: gcp
student_02_63312c3fb221@cloudshell:~ (qwiklabs-gcp-02-22e67f7e8e87)$ source <(kubectl completion bash)
student_02_63312c3fb221@cloudshell:~ (qwiklabs-gcp-02-22e67f7e8e87)$




student_02_63312c3fb221@cloudshell:~ (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get nodes -o wide
NAME                                                STATUS   ROLES    AGE     VERSION            INTERNAL-IP   EXTERNAL-IP     OS-IMAGE                             KERNEL-VERSION   CONTAINER-RUNTIME
gke-standard-cluster-1-default-pool-83385860-5ktw   Ready    <none>   4m56s   v1.19.9-gke.1900   10.128.0.2    104.154.64.67   Container-Optimized OS from Google   5.4.89+          containerd://1.4.3
gke-standard-cluster-1-default-pool-83385860-7b47   Ready    <none>   4m55s   v1.19.9-gke.1900   10.128.0.3    34.134.188.4    Container-Optimized OS from Google   5.4.89+          containerd://1.4.3
student_02_63312c3fb221@cloudshell:~ (qwiklabs-gcp-02-22e67f7e8e87)$ git clone https://github.com/GoogleCloudPlatform/training-data-analyst
Cloning into 'training-data-analyst'...
remote: Enumerating objects: 48994, done.
remote: Counting objects: 100% (1349/1349), done.
remote: Compressing objects: 100% (546/546), done.
remote: Total 48994 (delta 725), reused 1247 (delta 685), pack-reused 47645
Receiving objects: 100% (48994/48994), 575.52 MiB | 17.82 MiB/s, done.
Resolving deltas: 100% (30587/30587), done.
Checking out files: 100% (10001/10001), done.
student_02_63312c3fb221@cloudshell:~ (qwiklabs-gcp-02-22e67f7e8e87)$ ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
student_02_63312c3fb221@cloudshell:~ (qwiklabs-gcp-02-22e67f7e8e87)$ cd ~/ak8s/Storage/
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ ls
pod-volume-demo.yaml  pvc-demo.yaml  statefulset-demo.yaml
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$



student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get persistentvolume
No resources found
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get persistentvolumeclaims
No resources found in default namespace.
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$



student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl apply -f pvc-demo.yaml
persistentvolumeclaim/hello-web-disk created
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get persistentvolume
NAME                                       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                    STORAGECLASS   REASON   AGE
pvc-9e002382-3b49-4ae4-b579-3cf6f27862ee   30Gi       RWO            Delete           Bound    default/hello-web-disk   standard                23s
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get persistentvolumeclaims
NAME             STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
hello-web-disk   Bound    pvc-9e002382-3b49-4ae4-b579-3cf6f27862ee   30Gi       RWO            standard       30s
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$




pod/pvc-demo-pod created
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get pods
NAME           READY   STATUS              RESTARTS   AGE
pvc-demo-pod   0/1     ContainerCreating   0          7s
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get pods
NAME           READY   STATUS              RESTARTS   AGE
pvc-demo-pod   0/1     ContainerCreating   0          13s
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get pods
NAME           READY   STATUS    RESTARTS   AGE
pvc-demo-pod   1/1     Running   0          36s
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl exec -it pvc-demo-pod -- sh
# df -PH
Filesystem      Size  Used Avail Use% Mounted on
overlay         102G  3.0G   99G   3% /
tmpfs            68M     0   68M   0% /dev
tmpfs           2.1G     0  2.1G   0% /sys/fs/cgroup
shm              68M     0   68M   0% /dev/shm
/dev/sda1       102G  3.0G   99G   3% /etc/hosts
/dev/sdb         32G   47M   32G   1% /var/www/html
tmpfs           2.1G   13k  2.1G   1% /run/secrets/kubernetes.io/serviceaccount
tmpfs           2.1G     0  2.1G   0% /proc/acpi
tmpfs           2.1G     0  2.1G   0% /proc/scsi
tmpfs           2.1G     0  2.1G   0% /sys/firmware
# echo Test webpage in a persistent volume!>/var/www/html/index.html
chmod +x /var/www/html/index.html#
# cat /var/www/html/index.html#
cat: /var/www/html/index.html#: No such file or directory
# cat /var/www/html/index.html
Test webpage in a persistent volume!
# exit
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get pods
NAME           READY   STATUS    RESTARTS   AGE
pvc-demo-pod   1/1     Running   0          2m49s
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$




student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get pods
NAME           READY   STATUS    RESTARTS   AGE
pvc-demo-pod   1/1     Running   0          2m49s
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl delete pod pvc-demo-pod
pod "pvc-demo-pod" deleted
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get persistentvolumeclaim
NAME             STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
hello-web-disk   Bound    pvc-9e002382-3b49-4ae4-b579-3cf6f27862ee   30Gi       RWO            standard       6m8s
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl apply -f pod-volume-demo.yaml
pod/pvc-demo-pod created
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get pods
NAME           READY   STATUS              RESTARTS   AGE
pvc-demo-pod   0/1     ContainerCreating   0          11s
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get pods
NAME           READY   STATUS              RESTARTS   AGE
pvc-demo-pod   0/1     ContainerCreating   0          15s
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl get pods
NAME           READY   STATUS    RESTARTS   AGE
pvc-demo-pod   1/1     Running   0          23s
student_02_63312c3fb221@cloudshell:~/ak8s/Storage (qwiklabs-gcp-02-22e67f7e8e87)$ kubectl exec -it pvc-demo-pod -- sh
# cat /var/www/html/index.html
Test webpage in a persistent volume!
#
#
#









