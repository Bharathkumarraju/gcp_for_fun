Observe Kubernetes DNS in action.

Define various service types (ClusterIP, NodePort, LoadBalancer) in manifests along with label selectors to connect to existing labeled Pods and deployments, deploy those to a cluster, and test connectivity.

Deploy an Ingress resource that connects clients to two different services based on the URL path entered.

Verify Google Cloud network load balancer creation for type=LoadBalancer services.



student_04_1d7d2f48968f@cloudshell:~ (qwiklabs-gcp-04-7c288c13cbef)$ export my_zone=us-central1-a
student_04_1d7d2f48968f@cloudshell:~ (qwiklabs-gcp-04-7c288c13cbef)$ export my_cluster=standard-cluster-1
student_04_1d7d2f48968f@cloudshell:~ (qwiklabs-gcp-04-7c288c13cbef)$ source <(kubectl completion bash)
student_04_1d7d2f48968f@cloudshell:~ (qwiklabs-gcp-04-7c288c13cbef)$ gcloud container clusters get-credentials $my_cluster --zone $my_zone
Fetching cluster endpoint and auth data.
kubeconfig entry generated for standard-cluster-1.
student_04_1d7d2f48968f@cloudshell:~ (qwiklabs-gcp-04-7c288c13cbef)$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://35.238.175.17
  name: gke_qwiklabs-gcp-04-7c288c13cbef_us-central1-a_standard-cluster-1
contexts:
- context:
    cluster: gke_qwiklabs-gcp-04-7c288c13cbef_us-central1-a_standard-cluster-1
    user: gke_qwiklabs-gcp-04-7c288c13cbef_us-central1-a_standard-cluster-1
  name: gke_qwiklabs-gcp-04-7c288c13cbef_us-central1-a_standard-cluster-1
current-context: gke_qwiklabs-gcp-04-7c288c13cbef_us-central1-a_standard-cluster-1
kind: Config
preferences: {}
users:
- name: gke_qwiklabs-gcp-04-7c288c13cbef_us-central1-a_standard-cluster-1
  user:
    auth-provider:
      config:
        cmd-args: config config-helper --format=json
        cmd-path: /usr/lib/google-cloud-sdk/bin/gcloud
        expiry-key: '{.credential.token_expiry}'
        token-key: '{.credential.access_token}'
      name: gcp
student_04_1d7d2f48968f@cloudshell:~ (qwiklabs-gcp-04-7c288c13cbef)$

