Create a VPC-native Kubernetes cluster with native Kubernetes monitoring enabled.

gcloud container clusters create $my_cluster \
   --num-nodes 3 --enable-ip-alias --zone $my_zone  \
   --enable-stackdriver-kubernetes




student_04_9744f94fe228@cloudshell:~ (qwiklabs-gcp-02-34197d28f762)$ gcloud container clusters get-credentials $my_cluster --zone $my_zone
Fetching cluster endpoint and auth data.
kubeconfig entry generated for standard-cluster-1.
student_04_9744f94fe228@cloudshell:~ (qwiklabs-gcp-02-34197d28f762)$ git clone https://github.com/GoogleCloudPlatform/training-data-analyst
Cloning into 'training-data-analyst'...
remote: Enumerating objects: 48994, done.
remote: Counting objects: 100% (1349/1349), done.
remote: Compressing objects: 100% (546/546), done.
remote: Total 48994 (delta 725), reused 1247 (delta 685), pack-reused 47645
Receiving objects: 100% (48994/48994), 575.52 MiB | 18.10 MiB/s, done.
Resolving deltas: 100% (30587/30587), done.
Checking out files: 100% (10001/10001), done.
student_04_9744f94fe228@cloudshell:~ (qwiklabs-gcp-02-34197d28f762)$ ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
student_04_9744f94fe228@cloudshell:~ (qwiklabs-gcp-02-34197d28f762)$ cd ~/ak8s/Monitoring/
student_04_9744f94fe228@cloudshell:~/ak8s/Monitoring (qwiklabs-gcp-02-34197d28f762)$ ls
gcp-gke-monitor-test  gcp-gke-monitor-test.yaml  hello-v2.yaml  prometheus-service.yml  query-custom-favicon-metric.py  rbac-setup.yml
student_04_9744f94fe228@cloudshell:~/ak8s/Monitoring (qwiklabs-gcp-02-34197d28f762)$



student_04_9744f94fe228@cloudshell:~/ak8s/Monitoring (qwiklabs-gcp-02-34197d28f762)$ kubectl create -f hello-v2.yaml
deployment.apps/hello-v2 created
student_04_9744f94fe228@cloudshell:~/ak8s/Monitoring (qwiklabs-gcp-02-34197d28f762)$ kubectl get pods
NAME                        READY   STATUS    RESTARTS   AGE
hello-v2-569cc4bf64-jpvgx   1/1     Running   0          8s
hello-v2-569cc4bf64-mz972   1/1     Running   0          8s
hello-v2-569cc4bf64-r8gql   1/1     Running   0          8s
student_04_9744f94fe228@cloudshell:~/ak8s/Monitoring (qwiklabs-gcp-02-34197d28f762)$ kubectl get deploy
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
hello-v2   3/3     3            3           18s
student_04_9744f94fe228@cloudshell:~/ak8s/Monitoring (qwiklabs-gcp-02-34197d28f762)$





student_04_9744f94fe228@cloudshell:~/ak8s/Monitoring (qwiklabs-gcp-02-34197d28f762)$ export PROJECT_ID="$(gcloud config get-value project -q)"
Your active configuration is: [cloudshell-24999]
student_04_9744f94fe228@cloudshell:~/ak8s/Monitoring (qwiklabs-gcp-02-34197d28f762)$ cd gcp-gke-monitor-test
student_04_9744f94fe228@cloudshell:~/ak8s/Monitoring/gcp-gke-monitor-test (qwiklabs-gcp-02-34197d28f762)$ ls
dev-test-build-steps.txt  docker-compose.yaml  Dockerfile  gcp-gke-monitor-test.yaml  images  index.html  LICENSE  package.json  package-lock.json  README.md  scripts  server.js
student_04_9744f94fe228@cloudshell:~/ak8s/Monitoring/gcp-gke-monitor-test (qwiklabs-gcp-02-34197d28f762)$ gcloud builds submit --tag=gcr.io/$PROJECT_ID/gcp-gke-monitor-test .
Creating temporary tarball archive of 15 file(s) totalling 252.7 KiB before compression.
Some files were not included in the source upload.

Check the gcloud log [/tmp/tmp.ff3D0n3hdO/logs/2021.06.13/04.43.05.389363.log] to see which files and the contents of the
default gcloudignore file used (see `$ gcloud topic gcloudignore` to learn
more).

Uploading tarball of [.] to [gs://qwiklabs-gcp-02-34197d28f762_cloudbuild/source/1623559385.566844-702e4accb69844d99c649b2984caff79.tgz]
Created [https://cloudbuild.googleapis.com/v1/projects/qwiklabs-gcp-02-34197d28f762/locations/global/builds/4e0b5304-ad66-4fa8-a2a6-84cdbd136a72].
Logs are available at [https://console.cloud.google.com/cloud-build/builds/4e0b5304-ad66-4fa8-a2a6-84cdbd136a72?project=1098587254372].
------------------------------------------------------------------------------------------------------ REMOTE BUILD OUTPUT -------------------------------------------------------------------------------------------------------
starting build "4e0b5304-ad66-4fa8-a2a6-84cdbd136a72"

FETCHSOURCE
Fetching storage object: gs://qwiklabs-gcp-02-34197d28f762_cloudbuild/source/1623559385.566844-702e4accb69844d99c649b2984caff79.tgz#1623559387517333
Copying gs://qwiklabs-gcp-02-34197d28f762_cloudbuild/source/1623559385.566844-702e4accb69844d99c649b2984caff79.tgz#1623559387517333...
/ [1 files][165.8 KiB/165.8 KiB]
Operation completed over 1 objects/165.8 KiB.
BUILD
Already have image (with digest): gcr.io/cloud-builders/docker
Sending build context to Docker daemon  73.73kB
Step 1/7 : FROM node:10-alpine
10-alpine: Pulling from library/node
ddad3d7c1e96: Pulling fs layer
de915e575d22: Pulling fs layer
7150aa69525b: Pulling fs layer
d7aa47be044e: Pulling fs layer
d7aa47be044e: Waiting
ddad3d7c1e96: Verifying Checksum
ddad3d7c1e96: Download complete
d7aa47be044e: Verifying Checksum
d7aa47be044e: Download complete
7150aa69525b: Verifying Checksum
7150aa69525b: Download complete
ddad3d7c1e96: Pull complete
de915e575d22: Verifying Checksum
de915e575d22: Download complete
de915e575d22: Pull complete
7150aa69525b: Pull complete
d7aa47be044e: Pull complete
Digest: sha256:dc98dac24efd4254f75976c40bce46944697a110d06ce7fa47e7268470cf2e28
Status: Downloaded newer image for node:10-alpine
 ---> aa67ba258e18
Step 2/7 : WORKDIR /usr/src/app
 ---> Running in dde1c4e0bf13
Removing intermediate container dde1c4e0bf13
 ---> 164f5ca8d560
Step 3/7 : COPY package*.json ./
 ---> cb449f1b1fd1
Step 4/7 : RUN npm ci --only=production
 ---> Running in fc840ee426b9

 > protobufjs@6.8.8 postinstall /usr/src/app/node_modules/protobufjs
 > node scripts/postinstall

 added 122 packages in 3.53s
 Removing intermediate container fc840ee426b9
  ---> 924602f46275
 Step 5/7 : COPY . .
  ---> 2661c150d853
 Step 6/7 : EXPOSE 8080
  ---> Running in beeeef2328a5
 Removing intermediate container beeeef2328a5
  ---> 8bddc71c4e26
 Step 7/7 : CMD [ "node", "server.js" ]
  ---> Running in 1e44efc2fec8
 Removing intermediate container 1e44efc2fec8
  ---> a56812321393
 Successfully built a56812321393
 Successfully tagged gcr.io/qwiklabs-gcp-02-34197d28f762/gcp-gke-monitor-test:latest
 PUSH
 Pushing gcr.io/qwiklabs-gcp-02-34197d28f762/gcp-gke-monitor-test
 The push refers to repository [gcr.io/qwiklabs-gcp-02-34197d28f762/gcp-gke-monitor-test]
 5a4575acaabd: Preparing
 4b5730f6295e: Preparing
 60e8c289d363: Preparing
 10f6bdb0c567: Preparing
 edff9ff691d5: Preparing
 cbe4b9146f86: Preparing
 a6524c5b12a6: Preparing
 9a5d14f9f550: Preparing
 cbe4b9146f86: Waiting
 a6524c5b12a6: Waiting
 9a5d14f9f550: Waiting
 edff9ff691d5: Layer already exists
 cbe4b9146f86: Layer already exists
 a6524c5b12a6: Layer already exists
 9a5d14f9f550: Layer already exists
 60e8c289d363: Pushed
 5a4575acaabd: Pushed
 10f6bdb0c567: Pushed
 4b5730f6295e: Pushed
 latest: digest: sha256:3588d81d4cca4ca0fa1d50c1ebd6ec2d6f627aba33a01e1fdc9fb126f0acf1a9 size: 1995
 DONE
 ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 ID                                    CREATE_TIME                DURATION  SOURCE                                                                                                      IMAGES                         STATUS
 4e0b5304-ad66-4fa8-a2a6-84cdbd136a72  2021-06-13T04:43:08+00:00  31S       gs://qwiklabs-gcp-02-34197d28f762_cloudbuild/source/1623559385.566844-702e4accb69844d99c649b2984caff79.tgz  gcr.io/qwiklabs-gcp-02-34197d28f762/gcp-gke-monitor-test (+1 more)  SUCCESS
 student_04_9744f94fe228@cloudshell:~/ak8s/Monitoring/gcp-gke-monitor-test (qwiklabs-gcp-02-34197d28f762)$
 student_04_9744f94fe228@cloudshell:~/ak8s/Monitoring/gcp-gke-monitor-test (qwiklabs-gcp-02-34197d28f762)$




student_04_9744f94fe228@cloudshell:~/ak8s/Monitoring (qwiklabs-gcp-02-34197d28f762)$ sed -i "s/\[DOCKER-IMAGE\]/gcr\.io\/${PROJECT_ID}\/gcp-gke-monitor-test\:latest/" gcp-gke-monitor-test.yaml
student_04_9744f94fe228@cloudshell:~/ak8s/Monitoring (qwiklabs-gcp-02-34197d28f762)$ kubectl create -f gcp-gke-monitor-test.yaml
deployment.apps/gcp-gke-monitor-test created
service/gcp-gke-monitor-test-service created
student_04_9744f94fe228@cloudshell:~/ak8s/Monitoring (qwiklabs-gcp-02-34197d28f762)$



student_04_9744f94fe228@cloudshell:~/ak8s/Monitoring (qwiklabs-gcp-02-34197d28f762)$ kubectl  get all
NAME                                       READY   STATUS    RESTARTS   AGE
pod/gcp-gke-monitor-test-85bfc67d9-7fffb   1/1     Running   0          35s
pod/hello-v2-569cc4bf64-jpvgx              1/1     Running   0          5m47s
pod/hello-v2-569cc4bf64-mz972              1/1     Running   0          5m47s
pod/hello-v2-569cc4bf64-r8gql              1/1     Running   0          5m47s

NAME                                   TYPE           CLUSTER-IP   EXTERNAL-IP   PORT(S)        AGE
service/gcp-gke-monitor-test-service   LoadBalancer   10.12.5.63   <pending>     80:30510/TCP   36s
service/kubernetes                     ClusterIP      10.12.0.1    <none>        443/TCP        12m

NAME                                   READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/gcp-gke-monitor-test   1/1     1            1           36s
deployment.apps/hello-v2               3/3     3            3           5m48s

NAME                                             DESIRED   CURRENT   READY   AGE
replicaset.apps/gcp-gke-monitor-test-85bfc67d9   1         1         1       36s
replicaset.apps/hello-v2-569cc4bf64              3         3         3       5m48s
student_04_9744f94fe228@cloudshell:~/ak8s/Monitoring (qwiklabs-gcp-02-34197d28f762)$




