student_03_e616be0ba762@cloudshell:~ (qwiklabs-gcp-03-64ef984edf9e)$ source <(kubectl completion bash)
student_03_e616be0ba762@cloudshell:~ (qwiklabs-gcp-03-64ef984edf9e)$ glcoud
-bash: glcoud: command not found
student_03_e616be0ba762@cloudshell:~ (qwiklabs-gcp-03-64ef984edf9e)$ gcloud container clusters get-credentials ^C
student_03_e616be0ba762@cloudshell:~ (qwiklabs-gcp-03-64ef984edf9e)$ export my_cluster=standard-cluster-1
student_03_e616be0ba762@cloudshell:~ (qwiklabs-gcp-03-64ef984edf9e)$ export my_zone=us-central1-a
student_03_e616be0ba762@cloudshell:~ (qwiklabs-gcp-03-64ef984edf9e)$ gcloud container clusters get-credentials $my_cluster --zone $my_zone
Fetching cluster endpoint and auth data.
kubeconfig entry generated for standard-cluster-1.
student_03_e616be0ba762@cloudshell:~ (qwiklabs-gcp-03-64ef984edf9e)$ git clone https://github.com/GoogleCloudPlatform/training-data-analyst
Cloning into 'training-data-analyst'...
remote: Enumerating objects: 48994, done.
remote: Counting objects: 100% (1349/1349), done.
remote: Compressing objects: 100% (548/548), done.
remote: Total 48994 (delta 725), reused 1250 (delta 683), pack-reused 47645
Receiving objects: 100% (48994/48994), 575.36 MiB | 18.58 MiB/s, done.
Resolving deltas: 100% (30586/30586), done.
Checking out files: 100% (10001/10001), done.
student_03_e616be0ba762@cloudshell:~ (qwiklabs-gcp-03-64ef984edf9e)$


student_03_e616be0ba762@cloudshell:~ (qwiklabs-gcp-03-64ef984edf9e)$ kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://34.123.28.29
  name: gke_qwiklabs-gcp-03-64ef984edf9e_us-central1-a_standard-cluster-1
contexts:
- context:
    cluster: gke_qwiklabs-gcp-03-64ef984edf9e_us-central1-a_standard-cluster-1
    user: gke_qwiklabs-gcp-03-64ef984edf9e_us-central1-a_standard-cluster-1
  name: gke_qwiklabs-gcp-03-64ef984edf9e_us-central1-a_standard-cluster-1
current-context: gke_qwiklabs-gcp-03-64ef984edf9e_us-central1-a_standard-cluster-1
kind: Config
preferences: {}
users:
- name: gke_qwiklabs-gcp-03-64ef984edf9e_us-central1-a_standard-cluster-1
  user:
    auth-provider:
      config:
        cmd-args: config config-helper --format=json
        cmd-path: /usr/lib/google-cloud-sdk/bin/gcloud
        expiry-key: '{.credential.token_expiry}'
        token-key: '{.credential.access_token}'
      name: gcp
student_03_e616be0ba762@cloudshell:~ (qwiklabs-gcp-03-64ef984edf9e)$


student_03_e616be0ba762@cloudshell:~ (qwiklabs-gcp-03-64ef984edf9e)$ ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
student_03_e616be0ba762@cloudshell:~ (qwiklabs-gcp-03-64ef984edf9e)$ cd ~/ak8s/Deployments/
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ ls -lrth
total 12K
-rw-r--r-- 1 student_03_e616be0ba762 student_03_e616be0ba762 168 Jun 10 16:55 service-nginx.yaml
-rw-r--r-- 1 student_03_e616be0ba762 student_03_e616be0ba762 340 Jun 10 16:55 nginx-deployment.yaml
-rw-r--r-- 1 student_03_e616be0ba762 student_03_e616be0ba762 381 Jun 10 16:55 nginx-canary.yaml
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ vim nginx-deployment.yaml
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$



student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ kubectl apply -f nginx-deployment.yaml
deployment.apps/nginx-deployment created
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ kubectl get deployments
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   3/3     3            3           17s
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$



student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ kubectl get deployments
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   1/1     1            1           2m30s
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ kubectl scale --replicas=3 deployment nginx-deployment
deployment.apps/nginx-deployment scaled
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ kubectl get deployments
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deployment   3/3     3            3           3m9s
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$




Task 3. Trigger a deployment rollout and a deployment rollback
A deployments rollout is triggered if and only if the deployments Pod template (that is, .spec.template) is changed,
for example, if the labels or container images of the template are updated. Other updates, such as scaling the deployment, do not trigger a rollout.

In this task, you trigger deployment rollout, and then you trigger deployment rollback.

kubectl set image deployment.v1.apps/nginx-deployment nginx=nginx:1.9.1 --record


student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ kubectl set image deployment.v1.apps/nginx-deployment nginx=nginx:1.9.1 --record
deployment.apps/nginx-deployment image updated
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ kubectl rollout status deployment.v1.apps/nginx-deployment
deployment "nginx-deployment" successfully rolled out
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$


student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ kubectl rollout history deployment nginx-deployment
deployment.apps/nginx-deployment
REVISION  CHANGE-CAUSE
1         <none>
2         kubectl set image deployment.v1.apps/nginx-deployment nginx=nginx:1.9.1 --record=true

student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$



student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ kubectl rollout undo deployment nginx-deployment
deployment.apps/nginx-deployment rolled back
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ kubectl rollout history deployment nginx-deployment
deployment.apps/nginx-deployment
REVISION  CHANGE-CAUSE
2         kubectl set image deployment.v1.apps/nginx-deployment nginx=nginx:1.9.1 --record=true
3         <none>

student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$



student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ kubectl rollout history deployment nginx-deployment  --revision=3
deployment.apps/nginx-deployment with revision #3
Pod Template:
  Labels:       app=nginx
        pod-template-hash=5d59d67564
  Containers:
   nginx:
    Image:      nginx:1.7.9
    Port:       80/TCP
    Host Port:  0/TCP
    Environment:        <none>
    Mounts:     <none>
  Volumes:      <none>

student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$



