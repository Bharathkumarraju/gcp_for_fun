student_01_a1c78d6badfb@cloudshell:~ (qwiklabs-gcp-01-95d5588bf27e)$ export my_zone=us-central1-a
student_01_a1c78d6badfb@cloudshell:~ (qwiklabs-gcp-01-95d5588bf27e)$ source <(kubectl completion bash)
student_01_a1c78d6badfb@cloudshell:~ (qwiklabs-gcp-01-95d5588bf27e)$ export my_cluster=standard-cluster-1
gcloud container clusters create $my_cluster --num-nodes 3 --enable-ip-alias --zone $my_zone --enable-network-policy

student_01_a1c78d6badfb@cloudshell:~ (qwiklabs-gcp-01-95d5588bf27e)$ gcloud container clusters create $my_cluster --num-nodes 3 --enable-ip-alias --zone $my_zone --enable-network-policy
WARNING: Starting in January 2021, clusters will use the Regular release channel by default when `--cluster-version`, `--release-channel`, `--no-enable-autoupgrade`, and `--no-enable-autorepair` flags are not specified.
WARNING: Starting with version 1.18, clusters will have shielded GKE nodes by default.
WARNING: The Pod address range limits the maximum size of the cluster. Please refer to https://cloud.google.com/kubernetes-engine/docs/how-to/flexible-pod-cidr to learn how to optimize IP address allocation.
WARNING: Starting with version 1.19, newly created clusters and node-pools will have COS_CONTAINERD as the default node image when no image type is specified.
Creating cluster standard-cluster-1 in us-central1-a... Cluster is being configured...⠶
Creating cluster standard-cluster-1 in us-central1-a... Cluster is being health-checked (master is healthy)...done.
Created [https://container.googleapis.com/v1/projects/qwiklabs-gcp-01-95d5588bf27e/zones/us-central1-a/clusters/standard-cluster-1].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/us-central1-a/standard-cluster-1?project=qwiklabs-gcp-01-95d5588bf27e
kubeconfig entry generated for standard-cluster-1.
NAME                LOCATION       MASTER_VERSION   MASTER_IP      MACHINE_TYPE  NODE_VERSION     NUM_NODES  STATUS
standard-cluster-1  us-central1-a  1.19.9-gke.1900  35.239.82.127  e2-medium     1.19.9-gke.1900  3          RUNNING
student_01_a1c78d6badfb@cloudshell:~ (qwiklabs-gcp-01-95d5588bf27e)$





kubectl run hello-web --labels app=hello \
  --image=gcr.io/google-samples/hello-app:1.0 --port 8080 --expose



student_01_a1c78d6badfb@cloudshell:~ (qwiklabs-gcp-01-95d5588bf27e)$ kubectl run hello-web --labels app=hello \
>   --image=gcr.io/google-samples/hello-app:1.0 --port 8080 --expose
service/hello-web created
pod/hello-web created
student_01_a1c78d6badfb@cloudshell:~ (qwiklabs-gcp-01-95d5588bf27e)$ kubectl get all
NAME            READY   STATUS    RESTARTS   AGE
pod/hello-web   1/1     Running   0          9s

NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
service/hello-web    ClusterIP   10.12.13.47   <none>        8080/TCP   8s
service/kubernetes   ClusterIP   10.12.0.1     <none>        443/TCP    6m26s
student_01_a1c78d6badfb@cloudshell:~ (qwiklabs-gcp-01-95d5588bf27e)$



student_01_a1c78d6badfb@cloudshell:~ (qwiklabs-gcp-01-95d5588bf27e)$ git clone https://github.com/GoogleCloudPlatform/training-data-analyst
Cloning into 'training-data-analyst'...
remote: Enumerating objects: 48994, done.
remote: Counting objects: 100% (1349/1349), done.
remote: Compressing objects: 100% (549/549), done.
remote: Total 48994 (delta 725), reused 1249 (delta 682), pack-reused 47645
Receiving objects: 100% (48994/48994), 575.52 MiB | 18.36 MiB/s, done.
Resolving deltas: 100% (30593/30593), done.
Checking out files: 100% (10001/10001), done.
student_01_a1c78d6badfb@cloudshell:~ (qwiklabs-gcp-01-95d5588bf27e)$



Restrict incoming traffic to Pods:
A sample NetworkPolicy manifest file called hello-allow-from-foo.yaml has been provided for you.
This manifest file defines an ingress policy that allows access to Pods labeled app: hello from Pods labeled app: foo.


student_01_a1c78d6badfb@cloudshell:~ (qwiklabs-gcp-01-95d5588bf27e)$ ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
student_01_a1c78d6badfb@cloudshell:~ (qwiklabs-gcp-01-95d5588bf27e)$ cd ~/ak8s/GKE_Networks/
student_01_a1c78d6badfb@cloudshell:~/ak8s/GKE_Networks (qwiklabs-gcp-01-95d5588bf27e)$ ls
foo-allow-to-hello.yaml  hello-allow-from-foo.yaml
student_01_a1c78d6badfb@cloudshell:~/ak8s/GKE_Networks (qwiklabs-gcp-01-95d5588bf27e)$ kubectl apply -f hello-allow-from-foo.yaml
networkpolicy.networking.k8s.io/hello-allow-from-foo created
student_01_a1c78d6badfb@cloudshell:~/ak8s/GKE_Networks (qwiklabs-gcp-01-95d5588bf27e)$ kubectl get networkpolicy
NAME                   POD-SELECTOR   AGE
hello-allow-from-foo   app=hello      12s
student_01_a1c78d6badfb@cloudshell:~/ak8s/GKE_Networks (qwiklabs-gcp-01-95d5588bf27e)$ kubectl get networkpolicy -o wide
NAME                   POD-SELECTOR   AGE
hello-allow-from-foo   app=hello      17s
student_01_a1c78d6badfb@cloudshell:~/ak8s/GKE_Networks (qwiklabs-gcp-01-95d5588bf27e)$

####### Validate the ingress policy #################

student_01_a1c78d6badfb@cloudshell:~/ak8s/GKE_Networks (qwiklabs-gcp-01-95d5588bf27e)$ kubectl describe networkpolicy hello-allow-from-foo
Name:         hello-allow-from-foo
Namespace:    default
Created on:   2021-06-12 00:03:58 +0000 UTC
Labels:       <none>
Annotations:  <none>
Spec:
  PodSelector:     app=hello
  Allowing ingress traffic:
    To Port: <any> (traffic allowed to all ports)
    From:
      PodSelector: app=foo
  Not affecting egress traffic
  Policy Types: Ingress
student_01_a1c78d6badfb@cloudshell:~/ak8s/GKE_Networks (qwiklabs-gcp-01-95d5588bf27e)$




student_01_a1c78d6badfb@cloudshell:~/ak8s/GKE_Networks (qwiklabs-gcp-01-95d5588bf27e)$ kubectl run test-1 --labels app=foo --image=alpine --restart=Never --rm --stdin --tty
If you dont see a command prompt, try pressing enter.
/ #

Note: The kubectl switches used here in conjunction with the run command are important to note.

--stdin ( alternatively -i ) creates an interactive session attached to STDIN on the container.

--tty ( alternatively -t ) allocates a TTY for each container in the pod.

--rm instructs Kubernetes to treat this as a temporary Pod that will be removed as soon as it completes its startup task. As this is an interactive session it will be removed as soon as the user exits the session.

--label ( alternatively -l ) adds a set of labels to the pod.

--restart defines the restart policy for the Pod


student_01_a1c78d6badfb@cloudshell:~/ak8s/GKE_Networks (qwiklabs-gcp-01-95d5588bf27e)$ kubectl run test-1 --labels app=foo --image=alpine --restart=Never --rm --stdin --tty
If you dont see a command prompt, try pressing enter.
/ # wget -qO- --timeout=2 http://hello-web:8080
Hello, world!
Version: 1.0.0
Hostname: hello-web
/ # wget -qO- --timeout=2 http://hello-web:8080
Hello, world!
Version: 1.0.0
Hostname: hello-web
/ #
/ #
/ #
/ # exit
pod "test-1" deleted
student_01_a1c78d6badfb@cloudshell:~/ak8s/GKE_Networks (qwiklabs-gcp-01-95d5588bf27e)$ kubectl run test-1 --labels app=other --image=alpine --restart=Never --rm --stdin --tty
If you dont see a command prompt, try pressing enter.
/ # wget -qO- --timeout=2 http://hello-web:8080
wget: download timed out
/ #



Restrict outgoing traffic from the Pods
You can restrict outgoing (egress) traffic as you do incoming traffic.
However, in order to query internal hostnames (such as hello-web) or external hostnames (such as www.example.com),
you must allow DNS resolution in your egress network policies. DNS traffic occurs on port 53, using TCP and UDP protocols.

The NetworkPolicy manifest file foo-allow-to-hello.yaml file
that has been provided for you defines a policy that permits Pods with the label app: foo to communicate with Pods labeled app: hello on any port number,
and allows the Pods labeled app: foo to communicate to any computer on UDP port 53, which is used for DNS resolution.
Without the DNS port open, you will not be able to resolve the hostnames.


student_01_a1c78d6badfb@cloudshell:~/ak8s/GKE_Networks (qwiklabs-gcp-01-95d5588bf27e)$ kubectl get networkpolicy
NAME                   POD-SELECTOR   AGE
foo-allow-to-hello     app=foo        18s
hello-allow-from-foo   app=hello      10m
student_01_a1c78d6badfb@cloudshell:~/ak8s/GKE_Networks (qwiklabs-gcp-01-95d5588bf27e)$


student_01_a1c78d6badfb@cloudshell:~/ak8s/GKE_Networks (qwiklabs-gcp-01-95d5588bf27e)$ kubectl get all
NAME            READY   STATUS    RESTARTS   AGE
pod/hello-web   1/1     Running   0          15m

NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
service/hello-web    ClusterIP   10.12.13.47   <none>        8080/TCP   15m
service/kubernetes   ClusterIP   10.12.0.1     <none>        443/TCP    21m
student_01_a1c78d6badfb@cloudshell:~/ak8s/GKE_Networks (qwiklabs-gcp-01-95d5588bf27e)$


Validate the egress policy

Deploy a new web application called hello-web-2 and expose it internally in the cluster.
kubectl run hello-web-2 --labels app=hello-2 \
  --image=gcr.io/google-samples/hello-app:1.0 --port 8080 --expose


Run a temporary Pod with the app=foo label and get a shell prompt inside the container.
kubectl run test-3 --labels app=foo --image=alpine --restart=Never --rm --stdin --tty


Verify that the Pod can establish connections to hello-web:8080.
wget -qO- --timeout=2 http://hello-web:8080





student_01_a1c78d6badfb@cloudshell:~/ak8s/GKE_Networks (qwiklabs-gcp-01-95d5588bf27e)$ kubectl run hello-web-2 --labels app=hello-2 \
>   --image=gcr.io/google-samples/hello-app:1.0 --port 8080 --expose
service/hello-web-2 created
pod/hello-web-2 created
student_01_a1c78d6badfb@cloudshell:~/ak8s/GKE_Networks (qwiklabs-gcp-01-95d5588bf27e)$ kubectl run test-3 --labels app=foo --image=alpine --restart=Never --rm --stdin --tty
If you dont see a command prompt, try pressing enter.
/ # wget -qO- --timeout=2 http://hello-web:8080
Hello, world!
Version: 1.0.0
Hostname: hello-web
/ # wget -qO- --timeout=2 http://hello-web-2:8080
wget: download timed out
/ #
/ #
/ # wget -qO- --timeout=2 http://www.example.com
wget: download timed out
/ #












