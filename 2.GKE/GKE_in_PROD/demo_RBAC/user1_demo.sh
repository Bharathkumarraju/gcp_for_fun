student_03_993c6c3e8409@cloudshell:~ (qwiklabs-gcp-03-eec58c2c6c6a)$ export my_zone=us-central1-a
student_03_993c6c3e8409@cloudshell:~ (qwiklabs-gcp-03-eec58c2c6c6a)$ export my_cluster=standard-cluster-1
student_03_993c6c3e8409@cloudshell:~ (qwiklabs-gcp-03-eec58c2c6c6a)$ source <(kubectl completion bash)
student_03_993c6c3e8409@cloudshell:~ (qwiklabs-gcp-03-eec58c2c6c6a)$ gcloud container clusters get-credentials $my_cluster --zone $my_zone
Fetching cluster endpoint and auth data.
kubeconfig entry generated for standard-cluster-1.
student_03_993c6c3e8409@cloudshell:~ (qwiklabs-gcp-03-eec58c2c6c6a)$ git clone https://github.com/GoogleCloudPlatform/training-data-analyst
Cloning into 'training-data-analyst'...
remote: Enumerating objects: 48994, done.
remote: Counting objects: 100% (1349/1349), done.
remote: Compressing objects: 100% (546/546), done.
remote: Total 48994 (delta 725), reused 1247 (delta 685), pack-reused 47645
Receiving objects: 100% (48994/48994), 575.52 MiB | 17.88 MiB/s, done.
Resolving deltas: 100% (30587/30587), done.
Checking out files: 100% (10001/10001), done.
student_03_993c6c3e8409@cloudshell:~ (qwiklabs-gcp-03-eec58c2c6c6a)$ ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
student_03_993c6c3e8409@cloudshell:~ (qwiklabs-gcp-03-eec58c2c6c6a)$ cd ~/ak8s/RBAC/
student_03_993c6c3e8409@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$



student_03_993c6c3e8409@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$ kubectl get namespaces
NAME              STATUS   AGE
default           Active   10m
kube-node-lease   Active   10m
kube-public       Active   10m
kube-system       Active   10m
student_03_993c6c3e8409@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$


tudent_03_993c6c3e8409@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$ kubectl create -f ./my-namespace.yaml
namespace/production created
student_03_993c6c3e8409@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$ kubectl get namespaces
NAME              STATUS   AGE
default           Active   10m
kube-node-lease   Active   10m
kube-public       Active   10m
kube-system       Active   10m
production        Active   9s
student_03_993c6c3e8409@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$ kubectl describe namespace production
Name:         production
Labels:       <none>
Annotations:  <none>
Status:       Active

Resource Quotas
  Name:                              gke-resource-quotas
  Resource                           Used  Hard
  --------                           ---   ---
  count/ingresses.extensions         0     100
  count/ingresses.networking.k8s.io  0     100
  count/jobs.batch                   0     5k
  pods                               0     1500
  services                           0     500

No LimitRange resource.
student_03_993c6c3e8409@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$



student_03_993c6c3e8409@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$ kubectl apply -f ./my-pod.yaml --namespace=production
pod/nginx created
student_03_993c6c3e8409@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$ kubectl get pods -n production
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          20s
student_03_993c6c3e8409@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$





Create a custom Role
Before you can create a Role, your account must have the permissions granted in the role being assigned.
For cluster administrators this can be easily accomplished by creating the following RoleBinding to grant your own user account the cluster-admin role.


To grant the Username 1 account cluster-admin privileges, run the following command, replacing [USERNAME_1_EMAIL] with the email address of the Username 1 account:



student_03_993c6c3e8409@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$ kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user  student-03-993c6c3e8409@qwiklabs.net
clusterrolebinding.rbac.authorization.k8s.io/cluster-admin-binding created
student_03_993c6c3e8409@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$ kubectl apply -f pod-reader-role.yaml
role.rbac.authorization.k8s.io/pod-reader created
student_03_993c6c3e8409@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$




student_03_993c6c3e8409@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$ kubectl describe role pod-reader --namespace production
Name:         pod-reader
Labels:       <none>
Annotations:  <none>
PolicyRule:
  Resources  Non-Resource URLs  Resource Names  Verbs
  ---------  -----------------  --------------  -----
  pods       []                 []              [create get list watch]
student_03_993c6c3e8409@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$



The role is used to assign privileges, but by itself it does nothing. The role must be bound to a user and an object, which is done in the RoleBinding.


student_03_993c6c3e8409@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$ kubectl apply -f username2-editor-binding.yaml
rolebinding.rbac.authorization.k8s.io/username2-editor created
student_03_993c6c3e8409@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$



student_02_b89333821a92@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$ kubectl apply -f ./production-pod.yaml
pod/production-pod created
student_02_b89333821a92@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$ kubectl get pods --namespace production
NAME             READY   STATUS    RESTARTS   AGE
nginx            1/1     Running   0          9m22s
production-pod   1/1     Running   0          9s
student_02_b89333821a92@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$




