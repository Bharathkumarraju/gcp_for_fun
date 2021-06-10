export my_zone=us-central1-a
export my_cluster=standard-cluster-1


gcloud container clusters create $my_cluster --num-nodes 3 --zone $my_zone --enable-ip-alias

student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ gcloud container clusters create $my_cluster --num-nodes 3 --zone $my_zone --enable-ip-alias
WARNING: Starting in January 2021, clusters will use the Regular release channel by default when `--cluster-version`, `--release-channel`, `--no-enable-autoupgrade`, and `--no-enable-autorepair` flags are not specified.
WARNING: Starting with version 1.18, clusters will have shielded GKE nodes by default.
WARNING: The Pod address range limits the maximum size of the cluster. Please refer to https://cloud.google.com/kubernetes-engine/docs/how-to/flexible-pod-cidr to learn how to optimize IP address allocation.
WARNING: Starting with version 1.19, newly created clusters and node-pools will have COS_CONTAINERD as the default node image when no image type is specified.
Creating cluster standard-cluster-1 in us-central1-a... Cluster is being health-checked (master is healthy)...done.
Created [https://container.googleapis.com/v1/projects/qwiklabs-gcp-01-5c008499a92b/zones/us-central1-a/clusters/standard-cluster-1].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/us-central1-a/standard-cluster-1?project=qwiklabs-gcp-01-5c008499a92b
kubeconfig entry generated for standard-cluster-1.
NAME                LOCATION       MASTER_VERSION   MASTER_IP    MACHINE_TYPE  NODE_VERSION     NUM_NODES  STATUS
standard-cluster-1  us-central1-a  1.19.9-gke.1900  34.72.48.91  e2-medium     1.19.9-gke.1900  3          RUNNING
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$



gcloud container clusters resize $my_cluster --zone $my_zone --num-nodes=4



student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ gcloud container clusters resize $my_cluster --zone $my_zone --num-nodes=4
Pool [default-pool] for [standard-cluster-1] will be resized to 4.
Do you want to continue (Y/n)?  Y

Resizing standard-cluster-1...done.
Updated [https://container.googleapis.com/v1/projects/qwiklabs-gcp-01-5c008499a92b/zones/us-central1-a/clusters/standard-cluster-1].
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$



student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ export my_zone=us-central1-a
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ export my_cluster=standard-cluster-1
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ gcloud container clusters get-credentials $my_cluster --zone $my_zone
Fetching cluster endpoint and auth data.
kubeconfig entry generated for standard-cluster-1.
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ kubectl get nodes -o wide
NAME                                                STATUS   ROLES    AGE   VERSION            INTERNAL-IP   EXTERNAL-IP     OS-IMAGE                             KERNEL-VERSION   CONTAINER-RUNTIME
gke-standard-cluster-1-default-pool-b35f0c90-p781   Ready    <none>   48m   v1.19.9-gke.1900   10.128.0.3    146.148.67.12   Container-Optimized OS from Google   5.4.89+          containerd://1.4.3
gke-standard-cluster-1-default-pool-b35f0c90-sm90   Ready    <none>   40m   v1.19.9-gke.1900   10.128.0.5    35.188.68.135   Container-Optimized OS from Google   5.4.89+          containerd://1.4.3
gke-standard-cluster-1-default-pool-b35f0c90-sp2p   Ready    <none>   48m   v1.19.9-gke.1900   10.128.0.2    34.122.86.147   Container-Optimized OS from Google   5.4.89+          containerd://1.4.3
gke-standard-cluster-1-default-pool-b35f0c90-zjvv   Ready    <none>   48m   v1.19.9-gke.1900   10.128.0.4    35.232.209.7    Container-Optimized OS from Google   5.4.89+          containerd://1.4.3
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$



student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ cat ~/.kube/config
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURLekNDQWhPZ0F3SUJBZ0lSQUxlSm4wTkkzbE9EUkYrOHBUam92NmN3RFFZSktvWklodmNOQVFFTEJRQXcKTHpFdE1Dc0dBMVVFQXhNa1lUY3hNREEzWXpVdE16VTFaaTAwTWpoa0xUaGpOMll0TmpNME1qa3lZMlpqTVdVeApNQjRYRFRJeE1EWXhNREE1TVRJeU1Wb1hEVEkyTURZd09URXdNVEl5TVZvd0x6RXRNQ3NHQTFVRUF4TWtZVGN4Ck1EQTNZelV0TXpVMVppMDBNamhrTFRoak4yWXROak0wTWpreVkyWmpNV1V4TUlJQklqQU5CZ2txaGtpRzl3MEIKQVFFRkFBT0NBUThBTUlJQkNnS0NBUUVBMVV2VFhtcGlFUXphWWNsamFhRnl5b0VNcUlxNmI5aDRkNTJSSTVEVgpDV1Y2dXE5QWtsTy9lektVY0Y4YWl5WEN4WVFLRVFvSjZBMEt4ZmtIdXl0bDY2QWViekdZbXQrYzU3QzF3YW1FCi9CWEt3NElYYjkrQmtEWUx0MjVwcWxlbzcxSVlEL3RGeXpVTkxIMGpmSjhySlowbnJFdEI0M1UyTmRoa2pHSEEKWXI4emJ4MGxjNEU3b1pPazhhdHdUeG5TbnZTY3B2RjFURGR0Z21hdkNnM3RnYU53N0k2aDlRVklGWXFZL1N1Kwp4YW1zUGpNdUNXWHR0QkppbUo5OFpqeUdGS0NpYVpqRTZmaENuQWJLNC9mUFhDMFZ2VDdTamFUeGZBQTRTc0FlCklSd0xqMFQ4SEx0TmRIallmd0ljMnlhZVNaekJnL0V3Rm1XUDNsVmk5QTcxM3dJREFRQUJvMEl3UURBT0JnTlYKSFE4QkFmOEVCQU1DQWdRd0R3WURWUjBUQVFIL0JBVXdBd0VCL3pBZEJnTlZIUTRFRmdRVU5xSGpJblZsZG5SWQoxZFQrZFVZbkMvNWJaSTB3RFFZSktvWklodmNOQVFFTEJRQURnZ0VCQUM4UWNFMUJWY0krS3BGdTZGR3dCUXA4Cm00ZkNmbjBOU25WOUpHb0gwQ1ZEL3NPY0FVem55TUh1WlU5QWJqUzFEWkdDZlpDTTVERjE2dVRTS2FPQlg5LzUKNCsrdHowYndRQXJGM3VTdHJkS0xaeGFDbTJ3Mm1aS3hSaCtkWEwxOUdibG9pcWZiSzNadCtRUjNIYTk4eFpmVApqL0VmUHFkNThUSEJCRGoyZWVXWFErOFBSUGVEd2xVbUNLeTN1L0VGNi9Pc1ByNjB1WXpnc1VIWENlMzNDOGxxCjFuMEtrYm1sWSt6RHBJNHN0dU5mZWJsUVdmdzZtMWxORHQxbWxJYWhYMUZ4YThKd3JKRXd1UWlYREZmV21XcEwKbDRuOTRoUHgxRFpya1ovb3JzZk1EVXk1d3N5NXVLNWtZUjVYbXhTR25VNzArUDZEN3drdXJaRmxMR2NhREFJPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
    server: https://34.72.48.91
  name: gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
contexts:
- context:
    cluster: gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
    user: gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
  name: gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
current-context: gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
kind: Config
preferences: {}
users:
- name: gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
  user:
    auth-provider:
      config:
        access-token: ya29.a0AfH6SMAxYSuQ1ZTBULX6eMoucf3qE2mNGzlAXlemu11sinPthvC6fp2MgScGreAbBSipd9R2qPjOhnA1ButCx7o5I2G958oN9hi3ytZ07m0TqynHqbSynhpLcTpy2Zcf3m3xVxU8DmQ6mm3hsrCJeFZ6QEnHXmiDUb7a_QBniA6xsKIqLWeiujiADdsz42zME8ZzrSU5RbOnYEUExGGBnNGgUPyfxy3AaLrRzEfi7C17IQMWbHRiWhz75q29wQcMUDJ0TA
        cmd-args: config config-helper --format=json
        cmd-path: /usr/lib/google-cloud-sdk/bin/gcloud
        expiry: "2021-06-10T11:10:35Z"
        expiry-key: '{.credential.token_expiry}'
        token-key: '{.credential.access_token}'
      name: gcp
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$




student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ cat ~/.kube/config
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURLekNDQWhPZ0F3SUJBZ0lSQUxlSm4wTkkzbE9EUkYrOHBUam92NmN3RFFZSktvWklodmNOQVFFTEJRQXcKTHpFdE1Dc0dBMVVFQXhNa1lUY3hNREEzWXpVdE16VTFaaTAwTWpoa0xUaGpOMll0TmpNME1qa3lZMlpqTVdVeApNQjRYRFRJeE1EWXhNREE1TVRJeU1Wb1hEVEkyTURZd09URXdNVEl5TVZvd0x6RXRNQ3NHQTFVRUF4TWtZVGN4Ck1EQTNZelV0TXpVMVppMDBNamhrTFRoak4yWXROak0wTWpreVkyWmpNV1V4TUlJQklqQU5CZ2txaGtpRzl3MEIKQVFFRkFBT0NBUThBTUlJQkNnS0NBUUVBMVV2VFhtcGlFUXphWWNsamFhRnl5b0VNcUlxNmI5aDRkNTJSSTVEVgpDV1Y2dXE5QWtsTy9lektVY0Y4YWl5WEN4WVFLRVFvSjZBMEt4ZmtIdXl0bDY2QWViekdZbXQrYzU3QzF3YW1FCi9CWEt3NElYYjkrQmtEWUx0MjVwcWxlbzcxSVlEL3RGeXpVTkxIMGpmSjhySlowbnJFdEI0M1UyTmRoa2pHSEEKWXI4emJ4MGxjNEU3b1pPazhhdHdUeG5TbnZTY3B2RjFURGR0Z21hdkNnM3RnYU53N0k2aDlRVklGWXFZL1N1Kwp4YW1zUGpNdUNXWHR0QkppbUo5OFpqeUdGS0NpYVpqRTZmaENuQWJLNC9mUFhDMFZ2VDdTamFUeGZBQTRTc0FlCklSd0xqMFQ4SEx0TmRIallmd0ljMnlhZVNaekJnL0V3Rm1XUDNsVmk5QTcxM3dJREFRQUJvMEl3UURBT0JnTlYKSFE4QkFmOEVCQU1DQWdRd0R3WURWUjBUQVFIL0JBVXdBd0VCL3pBZEJnTlZIUTRFRmdRVU5xSGpJblZsZG5SWQoxZFQrZFVZbkMvNWJaSTB3RFFZSktvWklodmNOQVFFTEJRQURnZ0VCQUM4UWNFMUJWY0krS3BGdTZGR3dCUXA4Cm00ZkNmbjBOU25WOUpHb0gwQ1ZEL3NPY0FVem55TUh1WlU5QWJqUzFEWkdDZlpDTTVERjE2dVRTS2FPQlg5LzUKNCsrdHowYndRQXJGM3VTdHJkS0xaeGFDbTJ3Mm1aS3hSaCtkWEwxOUdibG9pcWZiSzNadCtRUjNIYTk4eFpmVApqL0VmUHFkNThUSEJCRGoyZWVXWFErOFBSUGVEd2xVbUNLeTN1L0VGNi9Pc1ByNjB1WXpnc1VIWENlMzNDOGxxCjFuMEtrYm1sWSt6RHBJNHN0dU5mZWJsUVdmdzZtMWxORHQxbWxJYWhYMUZ4YThKd3JKRXd1UWlYREZmV21XcEwKbDRuOTRoUHgxRFpya1ovb3JzZk1EVXk1d3N5NXVLNWtZUjVYbXhTR25VNzArUDZEN3drdXJaRmxMR2NhREFJPQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
    server: https://34.72.48.91
  name: gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
contexts:
- context:
    cluster: gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
    user: gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
  name: gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
current-context: gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
kind: Config
preferences: {}
users:
- name: gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
  user:
    auth-provider:
      config:
        access-token: ya29.a0AfH6SMAxYSuQ1ZTBULX6eMoucf3qE2mNGzlAXlemu11sinPthvC6fp2MgScGreAbBSipd9R2qPjOhnA1ButCx7o5I2G958oN9hi3ytZ07m0TqynHqbSynhpLcTpy2Zcf3m3xVxU8DmQ6mm3hsrCJeFZ6QEnHXmiDUb7a_QBniA6xsKIqLWeiujiADdsz42zME8ZzrSU5RbOnYEUExGGBnNGgUPyfxy3AaLrRzEfi7C17IQMWbHRiWhz75q29wQcMUDJ0TA
        cmd-args: config config-helper --format=json
        cmd-path: /usr/lib/google-cloud-sdk/bin/gcloud
        expiry: "2021-06-10T11:10:35Z"
        expiry-key: '{.credential.token_expiry}'
        token-key: '{.credential.access_token}'
      name: gcp
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$





student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ kubectl config current-context
gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ kubectl config  view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://34.72.48.91
  name: gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
contexts:
- context:
    cluster: gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
    user: gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
  name: gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
current-context: gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
kind: Config
preferences: {}
users:
- name: gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
  user:
    auth-provider:
      config:
        access-token: ya29.a0AfH6SMAxYSuQ1ZTBULX6eMoucf3qE2mNGzlAXlemu11sinPthvC6fp2MgScGreAbBSipd9R2qPjOhnA1ButCx7o5I2G958oN9hi3ytZ07m0TqynHqbSynhpLcTpy2Zcf3m3xVxU8DmQ6mm3hsrCJeFZ6QEnHXmiDUb7a_QBniA6xsKIqLWeiujiADdsz42zME8ZzrSU5RbOnYEUExGGBnNGgUPyfxy3AaLrRzEfi7C17IQMWbHRiWhz75q29wQcMUDJ0TA
        cmd-args: config config-helper --format=json
        cmd-path: /usr/lib/google-cloud-sdk/bin/gcloud
        expiry: "2021-06-10T11:10:35Z"
        expiry-key: '{.credential.token_expiry}'
        token-key: '{.credential.access_token}'
      name: gcp
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$



student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ kubectl cluster-info
Kubernetes control plane is running at https://34.72.48.91
GLBCDefaultBackend is running at https://34.72.48.91/api/v1/namespaces/kube-system/services/default-http-backend:http/proxy
KubeDNS is running at https://34.72.48.91/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
Metrics-server is running at https://34.72.48.91/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$


gke_[PROJECT_ID]_us-central1-a_standard-cluster-1


student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ kubectl config current-context
gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$


student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ kubectl config get-contexts
CURRENT   NAME                                                                CLUSTER                                                             AUTHINFO                                                            NAMESPACE
*         gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1   gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1   gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$



student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ kubectl config use-context gke_${GOOGLE_CLOUD_PROJECT}_us-central1-a_standard-cluster-1
Switched to context "gke_qwiklabs-gcp-01-5c008499a92b_us-central1-a_standard-cluster-1".
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$


student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ kubectl top nodes
W0610 11:09:33.808598     921 top_node.go:119] Using json format to get metrics. Next release will switch to protocol-buffers, switch early by passing --use-protocol-buffers flag
NAME                                                CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
gke-standard-cluster-1-default-pool-b35f0c90-p781   102m         10%    549Mi           19%
gke-standard-cluster-1-default-pool-b35f0c90-sm90   43m          4%     448Mi           15%
gke-standard-cluster-1-default-pool-b35f0c90-sp2p   69m          7%     561Mi           19%
gke-standard-cluster-1-default-pool-b35f0c90-zjvv   39m          4%     495Mi           17%
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$


In Cloud Shell, execute the following command to enable bash autocompletion for kubectl:

source <(kubectl completion bash)



student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ source <(kubectl completion bash)
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ kubectl
annotate       apply          autoscale      completion     cp             delete         drain          explain        help           logs           plugin         replace        scale          top            wait
api-resources  attach         certificate    config         create         describe       edit           expose         kustomize      options        port-forward   rollout        set            uncordon
api-versions   auth           cluster-info   cordon         debug          diff           exec           get            label          patch          proxy          run            taint          version
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ kubectl co
completion  config      cordon
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ kubectl co
completion  config      cordon
student_03_e0dd3c34422a@cloudshell:~ (qwiklabs-gcp-01-5c008499a92b)$ kubectl co

