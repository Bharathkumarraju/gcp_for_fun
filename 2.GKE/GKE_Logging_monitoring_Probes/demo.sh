by default 30 days logs available in stackdriver

stderror
stdout
/var/log

cloud logging runs a fluentd agent on all nodes


student_04_9744f94fe228@cloudshell:~ (qwiklabs-gcp-02-34197d28f762)$ export my_zone=us-central1-a
student_04_9744f94fe228@cloudshell:~ (qwiklabs-gcp-02-34197d28f762)$ export my_cluster=standard-cluster-1
student_04_9744f94fe228@cloudshell:~ (qwiklabs-gcp-02-34197d28f762)$ source <(kubectl completion bash)
student_04_9744f94fe228@cloudshell:~ (qwiklabs-gcp-02-34197d28f762)$ gcloud container clusters create $my_cluster \
>    --num-nodes 3 --enable-ip-alias --zone $my_zone  \
>    --enable-stackdriver-kubernetes
WARNING: Starting in January 2021, clusters will use the Regular release channel by default when `--cluster-version`, `--release-channel`, `--no-enable-autoupgrade`, and `--no-enable-autorepair` flags are not specified.
WARNING: Starting with version 1.18, clusters will have shielded GKE nodes by default.
WARNING: The Pod address range limits the maximum size of the cluster. Please refer to https://cloud.google.com/kubernetes-engine/docs/how-to/flexible-pod-cidr to learn how to optimize IP address allocation.
WARNING: Starting with version 1.19, newly created clusters and node-pools will have COS_CONTAINERD as the default node image when no image type is specified.
Creating cluster standard-cluster-1 in us-central1-a... Cluster is being health-checked (master is healthy)...done.
Created [https://container.googleapis.com/v1/projects/qwiklabs-gcp-02-34197d28f762/zones/us-central1-a/clusters/standard-cluster-1].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/us-central1-a/standard-cluster-1?project=qwiklabs-gcp-02-34197d28f762
kubeconfig entry generated for standard-cluster-1.
NAME                LOCATION       MASTER_VERSION   MASTER_IP       MACHINE_TYPE  NODE_VERSION     NUM_NODES  STATUS
standard-cluster-1  us-central1-a  1.19.9-gke.1900  35.202.160.136  e2-medium     1.19.9-gke.1900  3          RUNNING
student_04_9744f94fe228@cloudshell:~ (qwiklabs-gcp-02-34197d28f762)$




