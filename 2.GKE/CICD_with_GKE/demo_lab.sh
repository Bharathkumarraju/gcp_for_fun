In this lab, you learn how to perform the following tasks:

Create Kubernetes Engine clusters

Create Cloud Source Repositories

Trigger Cloud Build from Cloud Source Repositories

Automate tests and publish a deployable container image via Cloud Build

Manage resources deployed in a Kubernetes Engine cluster via Cloud Build


student_00_46bc792a0038@cloudshell:~ (qwiklabs-gcp-02-d9ddfe7472a6)$
student_00_46bc792a0038@cloudshell:~ (qwiklabs-gcp-02-d9ddfe7472a6)$ gcloud services enable container.googleapis.com \
>     cloudbuild.googleapis.com \
>     sourcerepo.googleapis.com \
>     containeranalysis.googleapis.com
Operation "operations/acf.p2-816948167132-d4ad6285-220b-4f92-a00f-147460aa3cae" finished successfully.
student_00_46bc792a0038@cloudshell:~ (qwiklabs-gcp-02-d9ddfe7472a6)$


student_00_46bc792a0038@cloudshell:~ (qwiklabs-gcp-02-d9ddfe7472a6)$ gcloud container clusters create hello-cloudbuild \
>     --num-nodes 1 --zone us-central1-b
WARNING: Starting in January 2021, clusters will use the Regular release channel by default when `--cluster-version`, `--release-channel`, `--no-enable-autoupgrade`, and `--no-enable-autorepair` flags are not specified.
WARNING: Currently VPC-native is not the default mode during cluster creation. In the future, this will become the default mode and can be disabled using `--no-enable-ip-alias` flag. Use `--[no-]enable-ip-alias` flag to suppress this warning.
WARNING: Starting with version 1.18, clusters will have shielded GKE nodes by default.
WARNING: Your Pod address range (`--cluster-ipv4-cidr`) can accommodate at most 1008 node(s).
WARNING: Starting with version 1.19, newly created clusters and node-pools will have COS_CONTAINERD as the default node image when no image type is specified.
Creating cluster hello-cloudbuild in us-central1-b... Cluster is being configured...⠛
Creating cluster hello-cloudbuild in us-central1-b... Cluster is being configured...⠹
Creating cluster hello-cloudbuild in us-central1-b... Cluster is being health-checked (master is healthy)...done.
Created [https://container.googleapis.com/v1/projects/qwiklabs-gcp-02-d9ddfe7472a6/zones/us-central1-b/clusters/hello-cloudbuild].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/us-central1-b/hello-cloudbuild?project=qwiklabs-gcp-02-d9ddfe7472a6
kubeconfig entry generated for hello-cloudbuild.
NAME              LOCATION       MASTER_VERSION   MASTER_IP     MACHINE_TYPE  NODE_VERSION     NUM_NODES  STATUS
hello-cloudbuild  us-central1-b  1.19.9-gke.1900  35.232.47.91  e2-medium     1.19.9-gke.1900  1          RUNNING
student_00_46bc792a0038@cloudshell:~ (qwiklabs-gcp-02-d9ddfe7472a6)$


git config --global user.email "bharath@bharathkumaraju.com"
git config --global user.name "Bharath"


student_00_46bc792a0038@cloudshell:~ (qwiklabs-gcp-02-d9ddfe7472a6)$ gcloud source repos create hello-cloudbuild-app
Created [hello-cloudbuild-app].
WARNING: You may be billed for this repository. See https://cloud.google.com/source-repositories/docs/pricing for details.
student_00_46bc792a0038@cloudshell:~ (qwiklabs-gcp-02-d9ddfe7472a6)$ gcloud source repos create hello-cloudbuild-env
Created [hello-cloudbuild-env].
WARNING: You may be billed for this repository. See https://cloud.google.com/source-repositories/docs/pricing for details.
student_00_46bc792a0038@cloudshell:~ (qwiklabs-gcp-02-d9ddfe7472a6)$



git clone https://github.com/GoogleCloudPlatform/gke-gitops-tutorial-cloudbuild \
    hello-cloudbuild-app


student_00_46bc792a0038@cloudshell:~ (qwiklabs-gcp-02-d9ddfe7472a6)$ cd ~
student_00_46bc792a0038@cloudshell:~ (qwiklabs-gcp-02-d9ddfe7472a6)$ pwd
/home/student_00_46bc792a0038
student_00_46bc792a0038@cloudshell:~ (qwiklabs-gcp-02-d9ddfe7472a6)$ git clone https://github.com/GoogleCloudPlatform/gke-gitops-tutorial-cloudbuild \
>     hello-cloudbuild-app
Cloning into 'hello-cloudbuild-app'...
remote: Enumerating objects: 12, done.
remote: Total 12 (delta 0), reused 0 (delta 0), pack-reused 12
Unpacking objects: 100% (12/12), done.
student_00_46bc792a0038@cloudshell:~ (qwiklabs-gcp-02-d9ddfe7472a6)$ ls -rtlh
total 8.0K
-rw-r--r-- 1 student_00_46bc792a0038 student_00_46bc792a0038  913 Jun 13 07:07 README-cloudshell.txt
drwxr-xr-x 3 student_00_46bc792a0038 student_00_46bc792a0038 4.0K Jun 13 07:19 hello-cloudbuild-app
student_00_46bc792a0038@cloudshell:~ (qwiklabs-gcp-02-d9ddfe7472a6)$
student_00_46bc792a0038@cloudshell:~ (qwiklabs-gcp-02-d9ddfe7472a6)$
student_00_46bc792a0038@cloudshell:~ (qwiklabs-gcp-02-d9ddfe7472a6)$







student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ git remote add google \
>     "https://source.developers.google.com/p/${PROJECT_ID}/r/hello-cloudbuild-app"
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ cd ~/hello-cloudbuild-app
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ COMMIT_ID="$(git rev-parse --short=7 HEAD)"
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ gcloud builds submit --tag="gcr.io/${PROJECT_ID}/hello-cloudbuild:${COMMIT_ID}" .
Creating temporary tarball archive of 10 file(s) totalling 22.9 KiB before compression.
Uploading tarball of [.] to [gs://qwiklabs-gcp-02-d9ddfe7472a6_cloudbuild/source/1623568892.688278-b6ad0051fa664e3cb963027804a35535.tgz]
Created [https://cloudbuild.googleapis.com/v1/projects/qwiklabs-gcp-02-d9ddfe7472a6/locations/global/builds/f998f5ce-a24e-4aad-8124-ba7ed288bc77].
Logs are available at [https://console.cloud.google.com/cloud-build/builds/f998f5ce-a24e-4aad-8124-ba7ed288bc77?project=816948167132].
-------------------------------------------------------------------------------------------------------------- REMOTE BUILD OUTPUT ---------------------------------------------------------------------------------------------------------------
starting build "f998f5ce-a24e-4aad-8124-ba7ed288bc77"

FETCHSOURCE
Fetching storage object: gs://qwiklabs-gcp-02-d9ddfe7472a6_cloudbuild/source/1623568892.688278-b6ad0051fa664e3cb963027804a35535.tgz#1623568893931036
Copying gs://qwiklabs-gcp-02-d9ddfe7472a6_cloudbuild/source/1623568892.688278-b6ad0051fa664e3cb963027804a35535.tgz#1623568893931036...
/ [1 files][  7.0 KiB/  7.0 KiB]
Operation completed over 1 objects/7.0 KiB.
BUILD
Already have image (with digest): gcr.io/cloud-builders/docker
Sending build context to Docker daemon  32.26kB
Step 1/6 : FROM python:3.7-slim
3.7-slim: Pulling from library/python
69692152171a: Already exists
66a3c154490a: Pulling fs layer
82a02637ec8f: Pulling fs layer
d8b2fbd22335: Pulling fs layer
c23c10f79e77: Pulling fs layer
c23c10f79e77: Waiting
d8b2fbd22335: Download complete
66a3c154490a: Verifying Checksum
66a3c154490a: Download complete
82a02637ec8f: Verifying Checksum
82a02637ec8f: Download complete
c23c10f79e77: Verifying Checksum
c23c10f79e77: Download complete
66a3c154490a: Pull complete
82a02637ec8f: Pull complete
d8b2fbd22335: Pull complete
c23c10f79e77: Pull complete
Digest: sha256:672037db64acc99961f7615272b9db372ae0cfae32994b7e1406431c9888335f
Status: Downloaded newer image for python:3.7-slim
 ---> 867339bd5033
Step 2/6 : RUN pip install flask
 ---> Running in 8b923e8aae64
Collecting flask
  Downloading Flask-2.0.1-py3-none-any.whl (94 kB)
Collecting Jinja2>=3.0
  Downloading Jinja2-3.0.1-py3-none-any.whl (133 kB)
Collecting click>=7.1.2
  Downloading click-8.0.1-py3-none-any.whl (97 kB)
Collecting itsdangerous>=2.0
  Downloading itsdangerous-2.0.1-py3-none-any.whl (18 kB)
Collecting Werkzeug>=2.0
  Downloading Werkzeug-2.0.1-py3-none-any.whl (288 kB)
Collecting importlib-metadata
  Downloading importlib_metadata-4.5.0-py3-none-any.whl (17 kB)
Collecting MarkupSafe>=2.0
  Downloading MarkupSafe-2.0.1-cp37-cp37m-manylinux2010_x86_64.whl (31 kB)
Collecting zipp>=0.5
  Downloading zipp-3.4.1-py3-none-any.whl (5.2 kB)
Collecting typing-extensions>=3.6.4
  Downloading typing_extensions-3.10.0.0-py3-none-any.whl (26 kB)
Installing collected packages: zipp, typing-extensions, MarkupSafe, importlib-metadata, Werkzeug, Jinja2, itsdangerous, click, flask
WARNING: Running pip as root will break packages and permissions. You should install packages reliably by using venv: https://pip.pypa.io/warnings/venv
Successfully installed Jinja2-3.0.1 MarkupSafe-2.0.1 Werkzeug-2.0.1 click-8.0.1 flask-2.0.1 importlib-metadata-4.5.0 itsdangerous-2.0.1 typing-extensions-3.10.0.0 zipp-3.4.1
Removing intermediate container 8b923e8aae64
 ---> 679f440ed9ce
Step 3/6 : WORKDIR /app
 ---> Running in 8946e9624bed
Removing intermediate container 8946e9624bed
 ---> f6d967eefd59
Step 4/6 : COPY app.py /app/app.py
 ---> cfd318b19ac8
Step 5/6 : ENTRYPOINT ["python"]
 ---> Running in 86e4cb004712
Removing intermediate container 86e4cb004712
 ---> 710f3f50da3c
Step 6/6 : CMD ["/app/app.py"]
 ---> Running in d0fa1ffc686d
Removing intermediate container d0fa1ffc686d
 ---> 9ae09e17d35d
Successfully built 9ae09e17d35d
Successfully tagged gcr.io/qwiklabs-gcp-02-d9ddfe7472a6/hello-cloudbuild:5b55cac
PUSH
Pushing gcr.io/qwiklabs-gcp-02-d9ddfe7472a6/hello-cloudbuild:5b55cac
The push refers to repository [gcr.io/qwiklabs-gcp-02-d9ddfe7472a6/hello-cloudbuild]
c05b1633d9da: Preparing
b6f197629307: Preparing
9500cd13483a: Preparing
55131b45c60c: Preparing
8506f6dcbf82: Preparing
4a36e2652108: Preparing
f9ef7f1bcb19: Preparing
02c055ef67f5: Preparing
4a36e2652108: Waiting
f9ef7f1bcb19: Waiting
02c055ef67f5: Waiting
55131b45c60c: Layer already exists
8506f6dcbf82: Layer already exists
f9ef7f1bcb19: Layer already exists
4a36e2652108: Layer already exists
02c055ef67f5: Layer already exists
c05b1633d9da: Pushed
b6f197629307: Pushed
9500cd13483a: Pushed
5b55cac: digest: sha256:c448a245f160dbae4ec2cac617ccd9290879368c26689f496421c397b2f79336 size: 1995
DONE
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ID                                    CREATE_TIME                DURATION  SOURCE                                                                                                      IMAGES                                                        STATUS
f998f5ce-a24e-4aad-8124-ba7ed288bc77  2021-06-13T07:21:35+00:00  23S       gs://qwiklabs-gcp-02-d9ddfe7472a6_cloudbuild/source/1623568892.688278-b6ad0051fa664e3cb963027804a35535.tgz  gcr.io/qwiklabs-gcp-02-d9ddfe7472a6/hello-cloudbuild:5b55cac  SUCCESS
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$


student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ git add .
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ git commit -am "flask app"
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ git push google master
Enumerating objects: 12, done.
Counting objects: 100% (12/12), done.
Delta compression using up to 2 threads
Compressing objects: 100% (12/12), done.
Writing objects: 100% (12/12), 10.16 KiB | 2.54 MiB/s, done.
Total 12 (delta 3), reused 0 (delta 0)
remote: Resolving deltas: 100% (3/3)
To https://source.developers.google.com/p/qwiklabs-gcp-02-d9ddfe7472a6/r/hello-cloudbuild-app
 * [new branch]      master -> master
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$







