# Task 2. Building Containers with DockerFile and Cloud Build
# ===================================================================================:

student_02_7bdddbe2d53f@cloudshell:~ (qwiklabs-gcp-04-d46e3912368e)$ ls
quickstart.sh  README-cloudshell.txt
student_02_7bdddbe2d53f@cloudshell:~ (qwiklabs-gcp-04-d46e3912368e)$ vim Dockerfile

gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/quickstart-image .
gcloud builds submit --config cloudbuild.yaml .

student_02_7bdddbe2d53f@cloudshell:~ (qwiklabs-gcp-04-d46e3912368e)$ gcloud builds submit --tag gcr.io/${GOOGLE_CLOUD_PROJECT}/quickstart-image .
Creating temporary tarball archive of 10 file(s) totalling 8.4 KiB before compression.
Uploading tarball of [.] to [gs://qwiklabs-gcp-04-d46e3912368e_cloudbuild/source/1623211291.614978-be78570dcab143949442927598a090f6.tgz]
Created [https://cloudbuild.googleapis.com/v1/projects/qwiklabs-gcp-04-d46e3912368e/locations/global/builds/1928c31f-de35-4a25-adc2-ec1a146b8684].
Logs are available at [https://console.cloud.google.com/cloud-build/builds/1928c31f-de35-4a25-adc2-ec1a146b8684?project=1030276288500].
--------------------------------------------------------------------------------------------------------------------------------------- REMOTE BUILD OUTPUT ----------------------------------------------------------------------------------------------------------------------------------------
starting build "1928c31f-de35-4a25-adc2-ec1a146b8684"

FETCHSOURCE
Fetching storage object: gs://qwiklabs-gcp-04-d46e3912368e_cloudbuild/source/1623211291.614978-be78570dcab143949442927598a090f6.tgz#1623211293269372
Copying gs://qwiklabs-gcp-04-d46e3912368e_cloudbuild/source/1623211291.614978-be78570dcab143949442927598a090f6.tgz#1623211293269372...
/ [1 files][  4.1 KiB/  4.1 KiB]
Operation completed over 1 objects/4.1 KiB.
BUILD
Already have image (with digest): gcr.io/cloud-builders/docker
Sending build context to Docker daemon  18.94kB
Step 1/3 : FROM alpine
latest: Pulling from library/alpine
Digest: sha256:69e70a79f2d41ab5d637de98c1e0b055206ba40a8145e7bddb55ccc04e13cf8f
Status: Downloaded newer image for alpine:latest
 ---> 6dbb9cc54074
Step 2/3 : COPY quickstart.sh /
 ---> 3d81410bc40a
Step 3/3 : CMD ["/quickstart.sh"]
 ---> Running in e2149bf2fddf
Removing intermediate container e2149bf2fddf
 ---> 5147358f6865
Successfully built 5147358f6865
Successfully tagged gcr.io/qwiklabs-gcp-04-d46e3912368e/quickstart-image:latest
PUSH
Pushing gcr.io/qwiklabs-gcp-04-d46e3912368e/quickstart-image
The push refers to repository [gcr.io/qwiklabs-gcp-04-d46e3912368e/quickstart-image]
5ea0d680e675: Preparing
b2d5eeeaba3a: Preparing
b2d5eeeaba3a: Layer already exists
5ea0d680e675: Pushed
latest: digest: sha256:2a99dfa1964c50503e9226b6855e153f6fce4e8b2725e4b1652aadc03f450168 size: 735
DONE
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ID                                    CREATE_TIME                DURATION  SOURCE                                                                                                      IMAGES                                                          STATUS
1928c31f-de35-4a25-adc2-ec1a146b8684  2021-06-09T04:01:33+00:00  15S       gs://qwiklabs-gcp-04-d46e3912368e_cloudbuild/source/1623211291.614978-be78570dcab143949442927598a090f6.tgz  gcr.io/qwiklabs-gcp-04-d46e3912368e/quickstart-image (+1 more)  SUCCESS
student_02_7bdddbe2d53f@cloudshell:~ (qwiklabs-gcp-04-d46e3912368e)$

gcr.io/qwiklabs-gcp-04-d46e3912368e/quickstart-image


# Task 3. Building Containers with a build configuration file and Cloud Build
# ==========================================================================================>


git clone https://github.com/GoogleCloudPlatform/training-data-analyst
ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
cd ~/ak8s/Cloud_Build/a



student_02_7bdddbe2d53f@cloudshell:~ (qwiklabs-gcp-04-d46e3912368e)$ git clone https://github.com/GoogleCloudPlatform/training-data-analyst
Cloning into 'training-data-analyst'...
remote: Enumerating objects: 48964, done.
remote: Counting objects: 100% (1319/1319), done.
remote: Compressing objects: 100% (529/529), done.
remote: Total 48964 (delta 718), reused 1230 (delta 678), pack-reused 47645
Receiving objects: 100% (48964/48964), 575.51 MiB | 14.97 MiB/s, done.
Resolving deltas: 100% (30586/30586), done.
Checking out files: 100% (10001/10001), done.
student_02_7bdddbe2d53f@cloudshell:~ (qwiklabs-gcp-04-d46e3912368e)$ ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
student_02_7bdddbe2d53f@cloudshell:~ (qwiklabs-gcp-04-d46e3912368e)$ ls -rtlh
total 20K
-rwxr-xr-x  1 student_02_7bdddbe2d53f student_02_7bdddbe2d53f   52 Jun  9 03:55 quickstart.sh
-rw-r--r--  1 student_02_7bdddbe2d53f student_02_7bdddbe2d53f  913 Jun  9 03:59 README-cloudshell.txt
-rw-r--r--  1 student_02_7bdddbe2d53f student_02_7bdddbe2d53f   56 Jun  9 04:00 Dockerfile
drwxr-xr-x 12 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 training-data-analyst
lrwxrwxrwx  1 student_02_7bdddbe2d53f student_02_7bdddbe2d53f   69 Jun  9 04:09 ak8s -> /home/student_02_7bdddbe2d53f/training-data-analyst/courses/ak8s/v1.1
student_02_7bdddbe2d53f@cloudshell:~ (qwiklabs-gcp-04-d46e3912368e)$ cd ak8s
student_02_7bdddbe2d53f@cloudshell:~/ak8s (qwiklabs-gcp-04-d46e3912368e)$ ls -lrth
total 76K
drwxr-xr-x 2 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 Jobs_CronJobs
drwxr-xr-x 2 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 Helm_Charts
drwxr-xr-x 2 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 GKE_Shell
drwxr-xr-x 2 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 GKE_Services
drwxr-xr-x 2 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 GKE_Networks
drwxr-xr-x 2 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 GKE_Console
drwxr-xr-x 2 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 GCP_Console
drwxr-xr-x 2 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 Deployments
drwxr-xr-x 2 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 Cloud_SQL
drwxr-xr-x 4 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 Cloud_Build
drwxr-xr-x 2 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 Autoscaling
drwxr-xr-x 2 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 Upgrading_GKE
drwxr-xr-x 2 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 Storage
drwxr-xr-x 2 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 Security
drwxr-xr-x 2 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 Secrets
-rw-r--r-- 1 student_02_7bdddbe2d53f student_02_7bdddbe2d53f  341 Jun  9 04:08 README.md
drwxr-xr-x 2 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 RBAC
drwxr-xr-x 2 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 Probes
drwxr-xr-x 3 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 Monitoring
student_02_7bdddbe2d53f@cloudshell:~/ak8s (qwiklabs-gcp-04-d46e3912368e)$ cd Cloud_Build/
student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build (qwiklabs-gcp-04-d46e3912368e)$ LS -RTLH
-bash: LS: command not found
student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build (qwiklabs-gcp-04-d46e3912368e)$ ls -rtlh
total 20K
-rw-r--r-- 1 student_02_7bdddbe2d53f student_02_7bdddbe2d53f   52 Jun  9 04:08 quickstart.sh
-rw-r--r-- 1 student_02_7bdddbe2d53f student_02_7bdddbe2d53f   56 Jun  9 04:08 Dockerfile
-rw-r--r-- 1 student_02_7bdddbe2d53f student_02_7bdddbe2d53f  164 Jun  9 04:08 cloudbuild.yaml
drwxr-xr-x 2 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 b
drwxr-xr-x 2 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 4.0K Jun  9 04:08 a
student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build (qwiklabs-gcp-04-d46e3912368e)$ cd a
student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build/a (qwiklabs-gcp-04-d46e3912368e)$ ls -rtlh
total 12K
-rw-r--r-- 1 student_02_7bdddbe2d53f student_02_7bdddbe2d53f  53 Jun  9 04:08 quickstart.sh
-rw-r--r-- 1 student_02_7bdddbe2d53f student_02_7bdddbe2d53f  56 Jun  9 04:08 Dockerfile
-rw-r--r-- 1 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 164 Jun  9 04:08 cloudbuild.yaml
student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build/a (qwiklabs-gcp-04-d46e3912368e)$ cat cloudbuild.yaml
steps:
- name: 'gcr.io/cloud-builders/docker'
  args: [ 'build', '-t', 'gcr.io/$PROJECT_ID/quickstart-image', '.' ]
images:
- 'gcr.io/$PROJECT_ID/quickstart-image'
student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build/a (qwiklabs-gcp-04-d46e3912368e)$









student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build/a (qwiklabs-gcp-04-d46e3912368e)$ gcloud builds submit --config cloudbuild.yaml .
Creating temporary tarball archive of 3 file(s) totalling 273 bytes before compression.
Uploading tarball of [.] to [gs://qwiklabs-gcp-04-d46e3912368e_cloudbuild/source/1623211877.966243-a3079470219541c5aabba428c77d2462.tgz]
Created [https://cloudbuild.googleapis.com/v1/projects/qwiklabs-gcp-04-d46e3912368e/locations/global/builds/6906f862-2ec9-4829-bf1a-4d48717bf00f].
Logs are available at [https://console.cloud.google.com/cloud-build/builds/6906f862-2ec9-4829-bf1a-4d48717bf00f?project=1030276288500].
--------------------------------------------------------------------------------------------------------------------------------------- REMOTE BUILD OUTPUT ----------------------------------------------------------------------------------------------------------------------------------------
starting build "6906f862-2ec9-4829-bf1a-4d48717bf00f"

FETCHSOURCE
Fetching storage object: gs://qwiklabs-gcp-04-d46e3912368e_cloudbuild/source/1623211877.966243-a3079470219541c5aabba428c77d2462.tgz#1623211878909835
Copying gs://qwiklabs-gcp-04-d46e3912368e_cloudbuild/source/1623211877.966243-a3079470219541c5aabba428c77d2462.tgz#1623211878909835...
/ [1 files][  359.0 B/  359.0 B]
Operation completed over 1 objects/359.0 B.
BUILD
Already have image (with digest): gcr.io/cloud-builders/docker
Sending build context to Docker daemon  4.096kB
Step 1/3 : FROM alpine
latest: Pulling from library/alpine
Digest: sha256:69e70a79f2d41ab5d637de98c1e0b055206ba40a8145e7bddb55ccc04e13cf8f
Status: Downloaded newer image for alpine:latest
 ---> 6dbb9cc54074
Step 2/3 : COPY quickstart.sh /
 ---> 70fbcaf54aae
Step 3/3 : CMD ["/quickstart.sh"]
 ---> Running in 3217da0f79a4
Removing intermediate container 3217da0f79a4
 ---> c4ef504fbf05
Successfully built c4ef504fbf05
Successfully tagged gcr.io/qwiklabs-gcp-04-d46e3912368e/quickstart-image:latest
PUSH
Pushing gcr.io/qwiklabs-gcp-04-d46e3912368e/quickstart-image
The push refers to repository [gcr.io/qwiklabs-gcp-04-d46e3912368e/quickstart-image]
c44056bf4452: Preparing
b2d5eeeaba3a: Preparing
b2d5eeeaba3a: Layer already exists
c44056bf4452: Pushed
latest: digest: sha256:34e032fd25d2b5cc292b7f725f75222c6aadaee116d1b2ef910726300880e090 size: 735
DONE
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ID                                    CREATE_TIME                DURATION  SOURCE                                                                                                      IMAGES                                                          STATUS
6906f862-2ec9-4829-bf1a-4d48717bf00f  2021-06-09T04:11:19+00:00  13S       gs://qwiklabs-gcp-04-d46e3912368e_cloudbuild/source/1623211877.966243-a3079470219541c5aabba428c77d2462.tgz  gcr.io/qwiklabs-gcp-04-d46e3912368e/quickstart-image (+1 more)  SUCCESS
student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build/a (qwiklabs-gcp-04-d46e3912368e)$




student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build/b (qwiklabs-gcp-04-d46e3912368e)$ ls -rtlh
total 12K
-rw-r--r-- 1 student_02_7bdddbe2d53f student_02_7bdddbe2d53f  99 Jun  9 04:08 quickstart.sh
-rw-r--r-- 1 student_02_7bdddbe2d53f student_02_7bdddbe2d53f  56 Jun  9 04:08 Dockerfile
-rw-r--r-- 1 student_02_7bdddbe2d53f student_02_7bdddbe2d53f 227 Jun  9 04:08 cloudbuild.yaml
student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build/b (qwiklabs-gcp-04-d46e3912368e)$ cat cloudbuild.yaml
steps:
- name: 'gcr.io/cloud-builders/docker'
  args: [ 'build', '-t', 'gcr.io/$PROJECT_ID/quickstart-image', '.' ]
- name: 'gcr.io/$PROJECT_ID/quickstart-image'
  args: ['fail']
images:
- 'gcr.io/$PROJECT_ID/quickstart-image'


In addition to its previous actions, this build configuration file runs the quickstart-image it has created.
In this task, the quickstart.sh script has been modified so that it simulates a test failure when an argument ['fail'] is passed to it.

student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build/b (qwiklabs-gcp-04-d46e3912368e)$ cat Dockerfile
FROM alpine
COPY quickstart.sh /
CMD ["/quickstart.sh"]
student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build/b (qwiklabs-gcp-04-d46e3912368e)$ cat quickstart.sh
#!/bin/sh
if [ -z "$1" ]
then
        echo "Hello, world! The time is $(date)."
        exit 0
else
        exit 1
fi

student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build/b (qwiklabs-gcp-04-d46e3912368e)$ sh quickstart.sh
Hello, world! The time is Wed 09 Jun 2021 04:17:05 AM UTC.
student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build/b (qwiklabs-gcp-04-d46e3912368e)$ sh ./quickstart.sh
Hello, world! The time is Wed 09 Jun 2021 04:17:17 AM UTC.
student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build/b (qwiklabs-gcp-04-d46e3912368e)$ sh ./quickstart.sh  123
student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build/b (qwiklabs-gcp-04-d46e3912368e)$
student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build/b (qwiklabs-gcp-04-d46e3912368e)$






student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build/b (qwiklabs-gcp-04-d46e3912368e)$ gcloud builds submit --config cloudbuild.yaml .
Creating temporary tarball archive of 3 file(s) totalling 382 bytes before compression.
Uploading tarball of [.] to [gs://qwiklabs-gcp-04-d46e3912368e_cloudbuild/source/1623212397.72324-5732044a3b2346129fbce8658b914a5b.tgz]
Created [https://cloudbuild.googleapis.com/v1/projects/qwiklabs-gcp-04-d46e3912368e/locations/global/builds/4a8161d0-7e74-41c8-a7bd-b00ebd7d55c3].
Logs are available at [https://console.cloud.google.com/cloud-build/builds/4a8161d0-7e74-41c8-a7bd-b00ebd7d55c3?project=1030276288500].
--------------------------------------------------------------------------------------------------------------------------------------- REMOTE BUILD OUTPUT ----------------------------------------------------------------------------------------------------------------------------------------
starting build "4a8161d0-7e74-41c8-a7bd-b00ebd7d55c3"

FETCHSOURCE
Fetching storage object: gs://qwiklabs-gcp-04-d46e3912368e_cloudbuild/source/1623212397.72324-5732044a3b2346129fbce8658b914a5b.tgz#1623212398875704
Copying gs://qwiklabs-gcp-04-d46e3912368e_cloudbuild/source/1623212397.72324-5732044a3b2346129fbce8658b914a5b.tgz#1623212398875704...
/ [1 files][  405.0 B/  405.0 B]
Operation completed over 1 objects/405.0 B.
BUILD
Starting Step #0
Step #0: Already have image (with digest): gcr.io/cloud-builders/docker
Step #0: Sending build context to Docker daemon  4.096kB
Step #0: Step 1/3 : FROM alpine
Step #0: latest: Pulling from library/alpine
Step #0: Digest: sha256:69e70a79f2d41ab5d637de98c1e0b055206ba40a8145e7bddb55ccc04e13cf8f
Step #0: Status: Downloaded newer image for alpine:latest
Step #0:  ---> 6dbb9cc54074
Step #0: Step 2/3 : COPY quickstart.sh /
Step #0:  ---> 7e65100b6c3c
Step #0: Step 3/3 : CMD ["/quickstart.sh"]
Step #0:  ---> Running in 9a9ba1eaa8f7
Step #0: Removing intermediate container 9a9ba1eaa8f7
Step #0:  ---> 74ec6cc634a7
Step #0: Successfully built 74ec6cc634a7
Step #0: Successfully tagged gcr.io/qwiklabs-gcp-04-d46e3912368e/quickstart-image:latest
Finished Step #0
Starting Step #1
Step #1: Already have image: gcr.io/qwiklabs-gcp-04-d46e3912368e/quickstart-image
Finished Step #1
ERROR
ERROR: build step 1 "gcr.io/qwiklabs-gcp-04-d46e3912368e/quickstart-image" failed: starting step container failed: Error response from daemon: OCI runtime create failed: container_linux.go:367: starting container process caused: exec: "fail": executable file not found in $PATH: unknown
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
ERROR: (gcloud.builds.submit) build 4a8161d0-7e74-41c8-a7bd-b00ebd7d55c3 completed with status "FAILURE"
student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build/b (qwiklabs-gcp-04-d46e3912368e)$


student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build/b (qwiklabs-gcp-04-d46e3912368e)$ echo $?
1
student_02_7bdddbe2d53f@cloudshell:~/ak8s/Cloud_Build/b (qwiklabs-gcp-04-d46e3912368e)$

In addition to its previous actions, this build configuration file runs the quickstart-image it has created.
In this task, the quickstart.sh script has been modified so that it simulates a test failure when an argument ['fail'] is passed to it.


The command will reply with a non-zero value.
If you had embedded this build in a script, your script would be able to act up on the builds failure.
