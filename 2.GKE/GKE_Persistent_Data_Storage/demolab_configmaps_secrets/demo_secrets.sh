Task 1. Work with Secrets
In this task, you authenticate containers with Google Cloud in order to access Google Cloud services.
You set up a Cloud Pub/Sub topic and subscription,
try to access the Cloud Pub/Sub topic from a container running in GKE, and see that the access request fails.
To properly access the pub/sub topic, you create a service account with credentials, and pass those credentials through Kubernetes Secrets.



student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$ export my_zone=us-central1-a
student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$ export my_cluster=standard-cluster-1
student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$ source <(kubectl completion bash)
student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$ export my_service_account=no-permissions@qwiklabs-gcp-04-d9c0e8c68ead.iam.gserviceaccount.com


student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$ gcloud container clusters create $my_cluster \
>   --num-nodes 2 --zone $my_zone \
>   --service-account=$my_service_account
WARNING: Starting in January 2021, clusters will use the Regular release channel by default when `--cluster-version`, `--release-channel`, `--no-enable-autoupgrade`, and `--no-enable-autorepair` flags are not specified.
WARNING: Currently VPC-native is not the default mode during cluster creation. In the future, this will become the default mode and can be disabled using `--no-enable-ip-alias` flag. Use `--[no-]enable-ip-alias` flag to suppress this warning.
WARNING: Starting with version 1.18, clusters will have shielded GKE nodes by default.
WARNING: Your Pod address range (`--cluster-ipv4-cidr`) can accommodate at most 1008 node(s).
WARNING: Starting with version 1.19, newly created clusters and node-pools will have COS_CONTAINERD as the default node image when no image type is specified.
Creating cluster standard-cluster-1 in us-central1-a... Cluster is being configured...⠛
Creating cluster standard-cluster-1 in us-central1-a... Cluster is being health-checked (master is healthy)...done.
Created [https://container.googleapis.com/v1/projects/qwiklabs-gcp-04-d9c0e8c68ead/zones/us-central1-a/clusters/standard-cluster-1].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/us-central1-a/standard-cluster-1?project=qwiklabs-gcp-04-d9c0e8c68ead
kubeconfig entry generated for standard-cluster-1.
NAME                LOCATION       MASTER_VERSION   MASTER_IP      MACHINE_TYPE  NODE_VERSION     NUM_NODES  STATUS
standard-cluster-1  us-central1-a  1.19.9-gke.1900  35.224.50.167  e2-medium     1.19.9-gke.1900  2          RUNNING
student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$
student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$





student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$ gcloud container clusters get-credentials $my_cluster --zone $my_zone
Fetching cluster endpoint and auth data.
kubeconfig entry generated for standard-cluster-1.
student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$ export my_pubsub_topic=echo
student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$ export my_pubsub_subscription=echo-read
student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$ gcloud pubsub topics create $my_pubsub_topic
Created topic [projects/qwiklabs-gcp-04-d9c0e8c68ead/topics/echo].
student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$ gcloud pubsub subscriptions create $my_pubsub_subscription \
>  --topic=$my_pubsub_topic
Created subscription [projects/qwiklabs-gcp-04-d9c0e8c68ead/subscriptions/echo-read].
student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$ git clone https://github.com/GoogleCloudPlatform/training-data-analyst
Cloning into 'training-data-analyst'...
remote: Enumerating objects: 48994, done.
remote: Counting objects: 100% (1349/1349), done.
remote: Compressing objects: 100% (548/548), done.
remote: Total 48994 (delta 725), reused 1250 (delta 683), pack-reused 47645
Receiving objects: 100% (48994/48994), 575.36 MiB | 17.94 MiB/s, done.
Resolving deltas: 100% (30586/30586), done.
Checking out files: 100% (10001/10001), done.
student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$ ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$ cd ~/ak8s/Secrets/
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ ls
config-map-3.yaml  pubsub-configmap2.yaml  pubsub-configmap.yaml  pubsub-secret.yaml  pubsub.yaml  sample2.properties
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl apply -f pubsub.yaml
deployment.apps/pubsub created
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl get pods -l app=pubsub
NAME                     READY   STATUS   RESTARTS   AGE
pubsub-f6f9c86cf-lf8fr   0/1     Error    1          13s
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl logs -l app=pubsub
    return api_call(*args)
  File "/usr/local/lib/python3.9/site-packages/google/gax/api_callable.py", line 376, in inner
    return a_func(*args, **kwargs)
  File "/usr/local/lib/python3.9/site-packages/google/gax/retry.py", line 125, in inner
    raise errors.RetryError(
google.gax.errors.RetryError: RetryError(Exception occurred in retry method that was not classified as transient, caused by <_InactiveRpcError of RPC that terminated with:
        status = StatusCode.PERMISSION_DENIED
        details = "User not authorized to perform this action."
        debug_error_string = "{"created":"@1623542059.711674361","description":"Error received from peer ipv4:108.177.120.95:443","file":"src/core/lib/surface/call.cc","file_line":1066,"grpc_message":"User not authorized to perform this action.","grpc_status":7}"
>)
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$




To save the credentials.json key file to a Kubernetes Secret named pubsub-key execute the following command.

student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ cd ~
student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$ ls
ak8s  qwiklabs-gcp-04-d9c0e8c68ead-848d7caa5750.json  README-cloudshell.txt  training-data-analyst
student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$ mv qwiklabs-gcp-04-d9c0e8c68ead-848d7caa5750.json credentials.json
student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl create secret generic pubsub-key \
>  --from-file=key.json=$HOME/credentials.json
secret/pubsub-key created
student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$



student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl get secrets
NAME                  TYPE                                  DATA   AGE
default-token-nqrx8   kubernetes.io/service-account-token   3      16m
pubsub-key            Opaque                                1      2m14s
student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl describe secret pubsub-key
Name:         pubsub-key
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
key.json:  2359 bytes
student_00_57988528be37@cloudshell:~ (qwiklabs-gcp-04-d9c0e8c68ead)$


student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl apply -f pubsub-secret.yaml
deployment.apps/pubsub configured
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl get pods -l app=pubsub
NAME                      READY   STATUS        RESTARTS   AGE
pubsub-777cf9d9c7-m2p4w   1/1     Running       0          11s
pubsub-f6f9c86cf-lf8fr    0/1     Terminating   6          8m2s
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl get pods -l app=pubsub
NAME                      READY   STATUS    RESTARTS   AGE
pubsub-777cf9d9c7-m2p4w   1/1     Running   0          15s
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ gcloud pubsub topics publish $my_pubsub_topic --message="Hello, world!"
messageIds:
- '2530799461797291'
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ gcloud pubsub topics publish $my_pubsub_topic --message="Hello, world!"
messageIds:
- '2530807358496049'
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ gcloud pubsub topics publish $my_pubsub_topic --message="Hello, world!"
messageIds:
- '2530808327024434'
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$


student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl logs -l app=pubsub
Pulling messages from Pub/Sub subscription...
[2021-06-13 00:02:22.434690] Received message: ID=2530799461797291 Data=b'Hello, world!'
[2021-06-13 00:02:22.434754] Processing: 2530799461797291
[2021-06-13 00:02:25.437889] Processed: 2530799461797291
[2021-06-13 00:02:28.502959] Received message: ID=2530807358496049 Data=b'Hello, world!'
[2021-06-13 00:02:28.503002] Processing: 2530807358496049
[2021-06-13 00:02:31.506127] Processed: 2530807358496049
[2021-06-13 00:02:31.506471] Received message: ID=2530808327024434 Data=b'Hello, world!'
[2021-06-13 00:02:31.506616] Processing: 2530808327024434
[2021-06-13 00:02:34.509897] Processed: 2530808327024434
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$

