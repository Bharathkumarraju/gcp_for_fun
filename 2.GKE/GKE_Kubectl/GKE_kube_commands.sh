student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ gcloud container clusters get-credentials $my_cluster --zone $my_zone
Fetching cluster endpoint and auth data.
kubeconfig entry generated for standard-cluster-1.
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl get nodes -o wide
NAME                                                STATUS   ROLES    AGE     VERSION            INTERNAL-IP   EXTERNAL-IP       OS-IMAGE                             KERNEL-VERSION   CONTAINER-RUNTIME
gke-standard-cluster-1-default-pool-8f8f56c9-p97q   Ready    <none>   6m43s   v1.19.9-gke.1900   10.128.0.4    34.67.130.113     Container-Optimized OS from Google   5.4.89+          containerd://1.4.3
gke-standard-cluster-1-default-pool-8f8f56c9-t50l   Ready    <none>   6m42s   v1.19.9-gke.1900   10.128.0.3    34.68.82.30       Container-Optimized OS from Google   5.4.89+          containerd://1.4.3
gke-standard-cluster-1-default-pool-8f8f56c9-tnnr   Ready    <none>   4m10s   v1.19.9-gke.1900   10.128.0.5    34.122.136.26     Container-Optimized OS from Google   5.4.89+          containerd://1.4.3
gke-standard-cluster-1-default-pool-8f8f56c9-vttb   Ready    <none>   6m42s   v1.19.9-gke.1900   10.128.0.2    104.197.101.128   Container-Optimized OS from Google   5.4.89+          containerd://1.4.3
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl config current-context
gke_qwiklabs-gcp-02-7c7d8f502dfa_us-central1-a_standard-cluster-1
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://35.239.237.132
  name: gke_qwiklabs-gcp-02-7c7d8f502dfa_us-central1-a_standard-cluster-1
contexts:
- context:
    cluster: gke_qwiklabs-gcp-02-7c7d8f502dfa_us-central1-a_standard-cluster-1
    user: gke_qwiklabs-gcp-02-7c7d8f502dfa_us-central1-a_standard-cluster-1
  name: gke_qwiklabs-gcp-02-7c7d8f502dfa_us-central1-a_standard-cluster-1
current-context: gke_qwiklabs-gcp-02-7c7d8f502dfa_us-central1-a_standard-cluster-1
kind: Config
preferences: {}
users:
- name: gke_qwiklabs-gcp-02-7c7d8f502dfa_us-central1-a_standard-cluster-1
  user:
    auth-provider:
      config:
        access-token: ya29.a0AfH6SMBota6HQSql4NZ2XWyHhPoBselHyKk4xRJW0M8lhLbPl42dM1ECA4_bRGvYVhCU904ILeLLcG1cpcvj2VFo1hdHfSAv3vzEKrCQq8YJgDBOJbGtGKC_hzOpiOodJkkoBc0Fqh4Y7etpkamY_rLmhnO9TQNz1jaZ0S_G7u-imhIMpeZGp3HzGWjJ56URJf5-NSV3y8R0cyDCOyrxZ6jL8SVOEKJ34ZdofLeJB4ZRm1BTImRi_ufXlpV3KDfMtS2RBQ
        cmd-args: config config-helper --format=json
        cmd-path: /usr/lib/google-cloud-sdk/bin/gcloud
        expiry: "2021-06-10T12:14:25Z"
        expiry-key: '{.credential.token_expiry}'
        token-key: '{.credential.access_token}'
      name: gcp
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl config get-contexts
CURRENT   NAME                                                                CLUSTER                                                             AUTHINFO                                                            NAMESPACE
*         gke_qwiklabs-gcp-02-7c7d8f502dfa_us-central1-a_standard-cluster-1   gke_qwiklabs-gcp-02-7c7d8f502dfa_us-central1-a_standard-cluster-1   gke_qwiklabs-gcp-02-7c7d8f502dfa_us-central1-a_standard-cluster-1
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$



student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl top nodes
W0610 11:30:15.253047    1312 top_node.go:119] Using json format to get metrics. Next release will switch to protocol-buffers, switch early by passing --use-protocol-buffers flag
NAME                                                CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
gke-standard-cluster-1-default-pool-8f8f56c9-p97q   44m          4%     542Mi           19%
gke-standard-cluster-1-default-pool-8f8f56c9-t50l   76m          8%     546Mi           19%
gke-standard-cluster-1-default-pool-8f8f56c9-tnnr   38m          4%     449Mi           15%
gke-standard-cluster-1-default-pool-8f8f56c9-vttb   41m          4%     504Mi           17%
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$ kubectl cluster-info
Kubernetes control plane is running at https://35.239.237.132
GLBCDefaultBackend is running at https://35.239.237.132/api/v1/namespaces/kube-system/services/default-http-backend:http/proxy
KubeDNS is running at https://35.239.237.132/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
Metrics-server is running at https://35.239.237.132/api/v1/namespaces/kube-system/services/https:metrics-server:/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
student_03_619f3f5ecafa@cloudshell:~ (qwiklabs-gcp-02-7c7d8f502dfa)$

