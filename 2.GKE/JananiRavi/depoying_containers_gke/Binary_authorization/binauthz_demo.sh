bharath@cloudshell:~ (learngcp-316009)$ mkdir binary-auth
bharath@cloudshell:~ (learngcp-316009)$ cd binary-auth
bharath@cloudshell:~/binary-auth (learngcp-316009)$ ls -rtlh
total 0
bharath@cloudshell:~/binary-auth (learngcp-316009)$ gcloud services enable container.googleapis.com
bharath@cloudshell:~/binary-auth (learngcp-316009)$ gcloud services enable binaryauthorization.googleapis.com
bharath@cloudshell:~/binary-auth (learngcp-316009)$



bharath@cloudshell:~/binary-auth (learngcp-316009)$ gcloud container clusters create binary-auth-cluster --zone us-central1-a
WARNING: Starting in January 2021, clusters will use the Regular release channel by default when `--cluster-version`, `--release-channel`, `--no-enable-autoupgrade`, and `--no-enable-autorepair` flags are not specified.
WARNING: Currently VPC-native is not the default mode during cluster creation. In the future, this will become the default mode and can be disabled using `--no-enable-ip-alias` flag. Use `--[no-]enable-ip-alias` flag to suppress this warning.
WARNING: Starting with version 1.18, clusters will have shielded GKE nodes by default.
WARNING: Your Pod address range (`--cluster-ipv4-cidr`) can accommodate at most 1008 node(s).
WARNING: Starting with version 1.19, newly created clusters and node-pools will have COS_CONTAINERD as the default node image when no image type is specified.
Creating cluster binary-auth-cluster in us-central1-a... Cluster is being health-checked (master is healthy)...done.
Created [https://container.googleapis.com/v1/projects/learngcp-316009/zones/us-central1-a/clusters/binary-auth-cluster].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/us-central1-a/binary-auth-cluster?project=learngcp-316009
kubeconfig entry generated for binary-auth-cluster.
NAME                 LOCATION       MASTER_VERSION   MASTER_IP     MACHINE_TYPE  NODE_VERSION     NUM_NODES  STATUS
binary-auth-cluster  us-central1-a  1.19.9-gke.1900  34.70.218.19  e2-medium     1.19.9-gke.1900  3          RUNNING
bharath@cloudshell:~/binary-auth (learngcp-316009)$



CONTAINER_PATH=us.gcr.io/$PROJECT_ID/hello-world


bharath@cloudshell:~/binary-auth (learngcp-316009)$ PROJECT_ID=$(gcloud config get-value project -q)
Your active configuration is: [cloudshell-24356]
bharath@cloudshell:~/binary-auth (learngcp-316009)$ echo $PROJECT_ID
learngcp-316009
bharath@cloudshell:~/binary-auth (learngcp-316009)$ CONTAINER_PATH=us.gcr.io/$PROJECT_ID/hello-world
bharath@cloudshell:~/binary-auth (learngcp-316009)$ vim Dockerfile
bharath@cloudshell:~/binary-auth (learngcp-316009)$ docker build -t $CONTAINER_PATH ./
Sending build context to Docker daemon  2.048kB
Step 1/2 : FROM alpine
latest: Pulling from library/alpine
540db60ca938: Pull complete
Digest: sha256:69e70a79f2d41ab5d637de98c1e0b055206ba40a8145e7bddb55ccc04e13cf8f
Status: Downloaded newer image for alpine:latest
 ---> 6dbb9cc54074
Step 2/2 : CMD tail -f /dev/null
 ---> Running in aa873f84dd25
Removing intermediate container aa873f84dd25
 ---> fa92469d9dc9
Successfully built fa92469d9dc9
Successfully tagged us.gcr.io/learngcp-316009/hello-world:latest
bharath@cloudshell:~/binary-auth (learngcp-316009)$ gcloud auth configure-docker --quiet
WARNING: Your config file at [/home/bharath/.docker/config.json] contains these credential helper entries:

{
  "credHelpers": {
    "gcr.io": "gcloud",
    "us.gcr.io": "gcloud",
    "eu.gcr.io": "gcloud",
    "asia.gcr.io": "gcloud",
    "staging-k8s.gcr.io": "gcloud",
    "marketplace.gcr.io": "gcloud"
  }
}
Adding credentials for all GCR repositories.
WARNING: A long list of credential helpers may cause delays running 'docker build'. We recommend passing the registry name to configure only the registry you are using.
gcloud credential helpers already registered correctly.
bharath@cloudshell:~/binary-auth (learngcp-316009)$


bharath@cloudshell:~/binary-auth (learngcp-316009)$
bharath@cloudshell:~/binary-auth (learngcp-316009)$ docker push $CONTAINER_PATH
Using default tag: latest
The push refers to repository [us.gcr.io/learngcp-316009/hello-world]
b2d5eeeaba3a: Layer already exists
latest: digest: sha256:23968e0041feaf3034313cc556827ff96fea09012f5e15c75107e8bc0a8d218d size: 528
bharath@cloudshell:~/binary-auth (learngcp-316009)$



bharath@cloudshell:~/binary-auth (learngcp-316009)$
bharath@cloudshell:~/binary-auth (learngcp-316009)$ docker push $CONTAINER_PATH
Using default tag: latest
The push refers to repository [us.gcr.io/learngcp-316009/hello-world]
b2d5eeeaba3a: Layer already exists
latest: digest: sha256:23968e0041feaf3034313cc556827ff96fea09012f5e15c75107e8bc0a8d218d size: 528
bharath@cloudshell:~/binary-auth (learngcp-316009)$ source <(kubectl completion bash)
bharath@cloudshell:~/binary-auth (learngcp-316009)$ kubectl create deployment hello --image $CONTAINER_PATH
deployment.apps/hello created
bharath@cloudshell:~/binary-auth (learngcp-316009)$ kubectl get all
NAME                        READY   STATUS    RESTARTS   AGE
pod/hello-f4cb75c4b-fnqlh   1/1     Running   0          9s

NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.59.240.1   <none>        443/TCP   8m22s

NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/hello   1/1     1            1           11s

NAME                              DESIRED   CURRENT   READY   AGE
replicaset.apps/hello-f4cb75c4b   1         1         1       11s
bharath@cloudshell:~/binary-auth (learngcp-316009)$



bharath@cloudshell:~/binary-auth (learngcp-316009)$ gcloud container clusters update binary-auth-cluster --enable-binauthz --zone us-central1-a
Updating binary-auth-cluster...done.
Updated [https://container.googleapis.com/v1/projects/learngcp-316009/zones/us-central1-a/clusters/binary-auth-cluster].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/us-central1-a/binary-auth-cluster?project=learngcp-316009
bharath@cloudshell:~/binary-auth (learngcp-316009)$




https://codelabs.developers.google.com/codelabs/cloud-binauthz-intro#3




bharath@cloudshell:~/binary-auth (learngcp-316009)$ gcloud container binauthz policy import policy.yaml
defaultAdmissionRule:
  enforcementMode: ENFORCED_BLOCK_AND_AUDIT_LOG
  evaluationMode: ALWAYS_DENY
globalPolicyEvaluationMode: ENABLE
name: projects/learngcp-316009/policy
updateTime: '2021-06-13T16:55:10.720017Z'
bharath@cloudshell:~/binary-auth (learngcp-316009)$


bharath@cloudshell:~/binary-auth (learngcp-316009)$ gcloud container binauthz policy import policy.yaml
admissionWhitelistPatterns:
- namePattern: gcr.io/google_containers/*
- namePattern: gcr.io/google-containers/*
- namePattern: k8s.gcr.io/*
defaultAdmissionRule:
  enforcementMode: ENFORCED_BLOCK_AND_AUDIT_LOG
  evaluationMode: ALWAYS_DENY
name: projects/learngcp-316009/policy
updateTime: '2021-06-13T16:59:00.441091Z'
bharath@cloudshell:~/binary-auth (learngcp-316009)$


bharath@cloudshell:~/binary-auth (learngcp-316009)$ echo $CONTAINER_PATH
us.gcr.io/learngcp-316009/hello-world
bharath@cloudshell:~/binary-auth (learngcp-316009)$ kubectl create deployment hello --image $CONTAINER_PATH
deployment.apps/hello created
bharath@cloudshell:~/binary-auth (learngcp-316009)$ kubectl get pods
No resources found in default namespace.
bharath@cloudshell:~/binary-auth (learngcp-316009)$ kubectl get events
LAST SEEN   TYPE      REASON              OBJECT                       MESSAGE
4s          Warning   FailedCreate        replicaset/hello-f4cb75c4b   Error creating: admission webhook "imagepolicywebhook.image-policy.k8s.io" denied the request: Image us.gcr.io/learngcp-316009/hello-world denied by Binary Authorization default admission rule. Denied by always_deny admission rule
25s         Normal    ScalingReplicaSet   deployment/hello             Scaled up replica set hello-f4cb75c4b to 1
bharath@cloudshell:~/binary-auth (learngcp-316009)$



bharath@cloudshell:~/binary-auth (learngcp-316009)$ kubectl get event --template \
> '{{range.items}}{{"\033[0;36m"}}{{.reason}}:{{"\033[0m"}}{{.message}}{{"\n"}}{{end}}'
FailedCreate:Error creating: admission webhook "imagepolicywebhook.image-policy.k8s.io" denied the request: Image us.gcr.io/learngcp-316009/hello-world denied by Binary Authorization default admission rule. Denied by always_deny admission rule
ScalingReplicaSet:Scaled up replica set hello-f4cb75c4b to 1
bharath@cloudshell:~/binary-auth (learngcp-316009)$




bharath@cloudshell:~/binary-auth (learngcp-316009)$ echo $NOTE_ID
spikey-attestor-note
bharath@cloudshell:~/binary-auth (learngcp-316009)$

curl -vvv -X POST \
    -H "Content-Type: application/json"  \
    -H "Authorization: Bearer $(gcloud auth print-access-token)"  \
    --data-binary @./create_note_request.json  \
    "https://containeranalysis.googleapis.com/v1/projects/${PROJECT_ID}/notes/?noteId=${NOTE_ID}"


curl -vvv  \
    -H "Authorization: Bearer $(gcloud auth print-access-token)" \
    "https://containeranalysis.googleapis.com/v1/projects/${PROJECT_ID}/notes/${NOTE_ID}"


bharath@cloudshell:~/binary-auth (learngcp-316009)$ ATTESTOR_ID=spikey-binauthz-attestor
bharath@cloudshell:~/binary-auth (learngcp-316009)$ echo $ATTESTOR_ID
spikey-binauthz-attestor
bharath@cloudshell:~/binary-auth (learngcp-316009)$ gcloud container binauthz attestors create $ATTESTOR_ID \
>     --attestation-authority-note=$NOTE_ID \
>     --attestation-authority-note-project=${PROJECT_ID}
bharath@cloudshell:~/binary-auth (learngcp-316009)$ gcloud container binauthz attestors list
┌──────────────────────────┬─────────────────────────────────────────────────────┬─────────────────┐
│           NAME           │                         NOTE                        │ NUM_PUBLIC_KEYS │
├──────────────────────────┼─────────────────────────────────────────────────────┼─────────────────┤
│ spikey-binauthz-attestor │ projects/learngcp-316009/notes/spikey-attestor-note │ 0               │
└──────────────────────────┴─────────────────────────────────────────────────────┴─────────────────┘
bharath@cloudshell:~/binary-auth (learngcp-316009)$


bharath@cloudshell:~/binary-auth (learngcp-316009)$ PROJECT_NUMBER=$(gcloud projects describe "${PROJECT_ID}"  --format="value(projectNumber)")
bharath@cloudshell:~/binary-auth (learngcp-316009)$
bharath@cloudshell:~/binary-auth (learngcp-316009)$ BINAUTHZ_SA_EMAIL="service-${PROJECT_NUMBER}@gcp-sa-binaryauthorization.iam.gserviceaccount.com"
bharath@cloudshell:~/binary-auth (learngcp-316009)$ echo $PROJECT_NUMBER
953414004163
bharath@cloudshell:~/binary-auth (learngcp-316009)$ echo $BINAUTHZ_SA_EMAIL
service-953414004163@gcp-sa-binaryauthorization.iam.gserviceaccount.com
bharath@cloudshell:~/binary-auth (learngcp-316009)$



bharath@cloudshell:~/binary-auth (learngcp-316009)$ curl -X POST      -H "Content-Type: application/json"     -H "Authorization: Bearer $(gcloud auth print-access-token)"     --data-binary @./iam_request.json     "https://containeranalysis.googleapis.com/v1/projects/${PROJECT_ID}/notes/${NOTE_ID}:setIamPolicy"
{
  "version": 1,
  "etag": "BwXEqR8csts=",
  "bindings": [
    {
      "role": "roles/containeranalysis.notes.occurrences.viewer",
      "members": [
        "serviceAccount:service-953414004163@gcp-sa-binaryauthorization.iam.gserviceaccount.com"
      ]
    }
  ]
}
bharath@cloudshell:~/binary-auth (learngcp-316009)$





