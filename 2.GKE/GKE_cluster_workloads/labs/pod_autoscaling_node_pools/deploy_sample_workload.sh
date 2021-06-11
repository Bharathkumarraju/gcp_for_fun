
student_04_266ad823bd1a@cloudshell:~ (qwiklabs-gcp-03-c0b415d0df5d)$ export my_zone=us-central1-a
student_04_266ad823bd1a@cloudshell:~ (qwiklabs-gcp-03-c0b415d0df5d)$ export my_cluster=standard-cluster-1
student_04_266ad823bd1a@cloudshell:~ (qwiklabs-gcp-03-c0b415d0df5d)$ source <(kubectl completion bash)
student_04_266ad823bd1a@cloudshell:~ (qwiklabs-gcp-03-c0b415d0df5d)$


student_04_266ad823bd1a@cloudshell:~ (qwiklabs-gcp-03-c0b415d0df5d)$ gcloud container clusters get-credentials $my_cluster --zone $my_zone
Fetching cluster endpoint and auth data.
kubeconfig entry generated for standard-cluster-1.
student_04_266ad823bd1a@cloudshell:~ (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://35.225.224.122
  name: gke_qwiklabs-gcp-03-c0b415d0df5d_us-central1-a_standard-cluster-1
contexts:
- context:
    cluster: gke_qwiklabs-gcp-03-c0b415d0df5d_us-central1-a_standard-cluster-1
    user: gke_qwiklabs-gcp-03-c0b415d0df5d_us-central1-a_standard-cluster-1
  name: gke_qwiklabs-gcp-03-c0b415d0df5d_us-central1-a_standard-cluster-1
current-context: gke_qwiklabs-gcp-03-c0b415d0df5d_us-central1-a_standard-cluster-1
kind: Config
preferences: {}
users:
- name: gke_qwiklabs-gcp-03-c0b415d0df5d_us-central1-a_standard-cluster-1
  user:
    auth-provider:
      config:
        cmd-args: config config-helper --format=json
        cmd-path: /usr/lib/google-cloud-sdk/bin/gcloud
        expiry-key: '{.credential.token_expiry}'
        token-key: '{.credential.access_token}'
      name: gcp
student_04_266ad823bd1a@cloudshell:~ (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl cluster-info
Kubernetes control plane is running at https://35.225.224.122
GLBCDefaultBackend is running at https://35.225.224.122/api/v1/namespaces/kube-system/services/default-http-backend:http/proxy
KubeDNS is running at https://35.225.224.122/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
Metrics-server is running at https://35.225.224.122/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
student_04_266ad823bd1a@cloudshell:~ (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl config current-context
gke_qwiklabs-gcp-03-c0b415d0df5d_us-central1-a_standard-cluster-1
student_04_266ad823bd1a@cloudshell:~ (qwiklabs-gcp-03-c0b415d0df5d)$


student_04_266ad823bd1a@cloudshell:~ (qwiklabs-gcp-03-c0b415d0df5d)$ git clone https://github.com/GoogleCloudPlatform/training-data-analyst
Cloning into 'training-data-analyst'...
remote: Enumerating objects: 48994, done.
remote: Counting objects: 100% (1349/1349), done.
remote: Compressing objects: 100% (548/548), done.
remote: Total 48994 (delta 725), reused 1250 (delta 683), pack-reused 47645
Receiving objects: 100% (48994/48994), 575.36 MiB | 16.31 MiB/s, done.
Resolving deltas: 100% (30586/30586), done.
Checking out files: 100% (10001/10001), done.
student_04_266ad823bd1a@cloudshell:~ (qwiklabs-gcp-03-c0b415d0df5d)$ ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
student_04_266ad823bd1a@cloudshell:~ (qwiklabs-gcp-03-c0b415d0df5d)$ cd ~/ak8s/Autoscaling/
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ ls
loadgen.yaml  web-tolerations.yaml  web.yaml
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$



student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl create -f web.yaml --save-config
deployment.apps/web created
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl expose deployment web --target-port=8080 --type=NodePort
service/web exposed
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get all
NAME                      READY   STATUS    RESTARTS   AGE
pod/web-98c9d48b4-bwjb7   1/1     Running   0          63s

NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/kubernetes   ClusterIP   10.11.240.1     <none>        443/TCP          11m
service/web          NodePort    10.11.249.186   <none>        8080:31898/TCP   22s

NAME                  READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/web   1/1     1            1           64s

NAME                            DESIRED   CURRENT   READY   AGE
replicaset.apps/web-98c9d48b4   1         1         1       64s
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$ kubectl get service web
NAME   TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
web    NodePort   10.11.249.186   <none>        8080:31898/TCP   40s
student_04_266ad823bd1a@cloudshell:~/ak8s/Autoscaling (qwiklabs-gcp-03-c0b415d0df5d)$


