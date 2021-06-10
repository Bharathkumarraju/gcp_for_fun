GCS_bucket_naming:
-------------------------->
https://cloud.google.com/storage/docs/best-practices

student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ MY_BUCKET_NAME=qwiklabs-gcp-02-9a1190ec1578
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ MY_BUCKET_NAME_1=qwiklabs-gcp-02-9a1190ec1578
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ MY_BUCKET_NAME_2=qwiklabs-gcp-02-9a1190ec1578_test
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ MY_REGION=us-central1
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ ls
credentials.json  README-cloudshell.txt
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ pwd
/home/student_02_cbb04b1269cd
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$


student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gsutil mb gs://$MY_BUCKET_NAME_2
Creating gs://qwiklabs-gcp-02-9a1190ec1578_test/...
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gcloud compute zones list | grep $MY_REGION
us-central1-c              us-central1              UP
us-central1-a              us-central1              UP
us-central1-f              us-central1              UP
us-central1-b              us-central1              UP
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$




student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ MY_ZONE=us-central1-a
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gcloud config set compute/zone $MY_ZONE
Updated property [compute/zone].
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gcloud compute instances list
NAME      ZONE           MACHINE_TYPE  PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP  STATUS
first-vm  us-central1-c  e2-micro                   10.128.0.2   34.70.49.98  RUNNING
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ MY_VMNAME=second-vm
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gcloud compute instances create $MY_VMNAME \
> --machine-type "e2-standard-2" \
> --image-project "debian-cloud" \
> --image-family "debian-9" \
> --subnet "default"

Created [https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-02-9a1190ec1578/zones/us-central1-a/instances/second-vm].
NAME       ZONE           MACHINE_TYPE   PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP    STATUS
second-vm  us-central1-a  e2-standard-2               10.128.0.3   35.192.41.161  RUNNING
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$



student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gcloud compute instances list
NAME       ZONE           MACHINE_TYPE   PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP    STATUS
second-vm  us-central1-a  e2-standard-2               10.128.0.3   35.192.41.161  RUNNING
first-vm   us-central1-c  e2-micro                    10.128.0.2   34.70.49.98    RUNNING
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$



student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gcloud iam service-accounts create test-service-account2 --display-name "test-service-account2"
Created service account [test-service-account2].
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$



student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ env | grep "GOOGLE"
GOOGLE_CLOUD_PROJECT=qwiklabs-gcp-02-9a1190ec1578
BASHRC_GOOGLE_PATH=/google/devshell/bashrc.google
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gcloud projects add-iam-policy-binding $GOOGLE_CLOUD_PROJECT --member serviceAccount:test-service-account2@${GOOGLE_CLOUD_PROJECT}.iam.gserviceaccount.com --role roles/viewer
Updated IAM policy for project [qwiklabs-gcp-02-9a1190ec1578].
bindings:
- members:
  - serviceAccount:qwiklabs-gcp-02-9a1190ec1578@qwiklabs-gcp-02-9a1190ec1578.iam.gserviceaccount.com
  role: roles/bigquery.admin
- members:
  - serviceAccount:439798909863@cloudbuild.gserviceaccount.com
  role: roles/cloudbuild.builds.builder
- members:
  - serviceAccount:service-439798909863@gcp-sa-cloudbuild.iam.gserviceaccount.com
  role: roles/cloudbuild.serviceAgent
- members:
  - serviceAccount:service-439798909863@compute-system.iam.gserviceaccount.com
  role: roles/compute.serviceAgent
- members:
  - serviceAccount:service-439798909863@container-engine-robot.iam.gserviceaccount.com
  role: roles/container.serviceAgent
- members:
  - serviceAccount:439798909863-compute@developer.gserviceaccount.com
  - serviceAccount:439798909863@cloudservices.gserviceaccount.com
  - serviceAccount:test-service-account@qwiklabs-gcp-02-9a1190ec1578.iam.gserviceaccount.com
  role: roles/editor
- members:
  - serviceAccount:admiral@qwiklabs-services-prod.iam.gserviceaccount.com
  - serviceAccount:qwiklabs-gcp-02-9a1190ec1578@qwiklabs-gcp-02-9a1190ec1578.iam.gserviceaccount.com
  - user:student-02-cbb04b1269cd@qwiklabs.net
  role: roles/owner
- members:  - serviceAccount:qwiklabs-gcp-02-9a1190ec1578@qwiklabs-gcp-02-9a1190ec1578.iam.gserviceaccount.com
  role: roles/storage.admin
- members:
  - serviceAccount:qwiklabs-gcp-02-9a1190ec1578@qwiklabs-gcp-02-9a1190ec1578.iam.gserviceaccount.com
  - serviceAccount:test-service-account2@qwiklabs-gcp-02-9a1190ec1578.iam.gserviceaccount.com
  - user:student-02-cbb04b1269cd@qwiklabs.net
  role: roles/viewer
etag: BwXETE9IX9o=
version: 1
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$



student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gsutil cp gs://cloud-training/ak8s/cat.jpg cat.jpg
Copying gs://cloud-training/ak8s/cat.jpg...
/ [1 files][ 81.7 KiB/ 81.7 KiB]
Operation completed over 1 objects/81.7 KiB.
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gsutil ls
gs://qwiklabs-gcp-02-9a1190ec1578/
gs://qwiklabs-gcp-02-9a1190ec1578_test/
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ MY_BUCKET_NAME_1=qwiklabs-gcp-02-9a1190ec1578
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ MY_BUCKET_NAME_2=qwiklabs-gcp-02-9a1190ec1578_test
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gsutil cp cat.jpg gs://$MY_BUCKET_NAME_1
Copying file://cat.jpg [Content-Type=image/jpeg]...
- [1 files][ 81.7 KiB/ 81.7 KiB]
Operation completed over 1 objects/81.7 KiB.
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gsutil cp gs://$MY_BUCKET_NAME_1/cat.jpg gs://$MY_BUCKET_NAME_2/cat.jpg
Copying gs://qwiklabs-gcp-02-9a1190ec1578/cat.jpg [Content-Type=image/jpeg]...
/ [1 files][ 81.7 KiB/ 81.7 KiB]
Operation completed over 1 objects/81.7 KiB.
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$



Set the access control list for a Cloud Storage object
To get the default access list thats been assigned to cat.jpg (when you uploaded it to your Cloud Storage bucket), execute the following two commands:

Execute the following command in Cloud Shell:


student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gsutil acl get gs://$MY_BUCKET_NAME_1/cat.jpg
[
  {
    "entity": "project-owners-439798909863",
    "projectTeam": {
      "projectNumber": "439798909863",
      "team": "owners"
    },
    "role": "OWNER"
  },
  {
    "entity": "project-editors-439798909863",
    "projectTeam": {
      "projectNumber": "439798909863",      "team": "editors"
    },
    "role": "OWNER"
  },
  {
    "entity": "project-viewers-439798909863",
    "projectTeam": {
      "projectNumber": "439798909863",
      "team": "viewers"
    },
    "role": "READER"
  },
  {
    "email": "student-02-cbb04b1269cd@qwiklabs.net",
    "entity": "user-student-02-cbb04b1269cd@qwiklabs.net",
    "role": "OWNER"
  }
]

student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gsutil acl set private gs://$MY_BUCKET_NAME_1/cat.jpg
Setting ACL on gs://qwiklabs-gcp-02-9a1190ec1578/cat.jpg...
/ [1 objects]
Operation completed over 1 objects.
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gsutil acl get  gs://$MY_BUCKET_NAME_1/cat.jpg
[
  {
    "email": "student-02-cbb04b1269cd@qwiklabs.net",
    "entity": "user-student-02-cbb04b1269cd@qwiklabs.net",
    "role": "OWNER"
  }
]
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$



student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gcloud config list
[component_manager]
disable_update_check = True
[compute]
gce_metadata_read_timeout_sec = 30
zone = us-central1-a
[core]
account = student-02-cbb04b1269cd@qwiklabs.net
disable_usage_reporting = True
project = qwiklabs-gcp-02-9a1190ec1578
[metrics]
environment = devshell

Your active configuration is: [cloudshell-19210]
student_02_cbb04b1269cd@cloudshell:~
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ ls -rtlh
total 96K
-rw-r--r-- 1 student_02_cbb04b1269cd student_02_cbb04b1269cd 2.4K Jun  9 02:36 credentials.json
-rw-r--r-- 1 student_02_cbb04b1269cd student_02_cbb04b1269cd  913 Jun  9 02:41 README-cloudshell.txt
-rw-r--r-- 1 student_02_cbb04b1269cd student_02_cbb04b1269cd  82K Jun  9 02:50 cat.jpg
-rw-r--r-- 1 student_02_cbb04b1269cd student_02_cbb04b1269cd  641 Jun  9 02:53 acl.json
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$


student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gcloud auth activate-service-account --key-file credentials.json
Activated service account credentials for: [test-service-account@qwiklabs-gcp-02-9a1190ec1578.iam.gserviceaccount.com]
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gcloud config list
[component_manager]
disable_update_check = True
[compute]
gce_metadata_read_timeout_sec = 30
zone = us-central1-a
[core]
account = test-service-account@qwiklabs-gcp-02-9a1190ec1578.iam.gserviceaccount.com
disable_usage_reporting = True
project = qwiklabs-gcp-02-9a1190ec1578
[metrics]
environment = devshell

Your active configuration is: [cloudshell-19210]
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$



student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gcloud auth list
                              Credentialed Accounts
ACTIVE  ACCOUNT
        student-02-cbb04b1269cd@qwiklabs.net
*       test-service-account@qwiklabs-gcp-02-9a1190ec1578.iam.gserviceaccount.com

To set the active account, run:
    $ gcloud config set account `ACCOUNT`

student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$


student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gsutil cp gs://$MY_BUCKET_NAME_1/cat.jpg ./cat-copy.jpg
Copying gs://qwiklabs-gcp-02-9a1190ec1578/cat.jpg...
AccessDeniedException: 403 HttpError accessing <https://storage.googleapis.com/download/storage/v1/b/qwiklabs-gcp-02-9a1190ec1578/o/cat.jpg?generation=1623207080820270&alt=media>: response: <{'x-guploader-uploadid': 'ABg5-UzVBNldr5a3hNLMoNIxaYBqlzxmcd3YhZUmlYwzfqdbalPun-5mxggZ7NJl59OR9r06thygCpCz2R5LKB6Md5U', 'content-type': 'text/html; charset=UTF-8', 'date': 'Wed, 09 Jun 2021 03:00:06 GMT', 'vary': 'Origin, X-Origin', 'expires': 'Wed, 09 Jun 2021 03:00:06 GMT', 'cache-control': 'private, max-age=0', 'content-length': '150', 'server': 'UploadServer', 'status': '403'}>, content <test-service-account@qwiklabs-gcp-02-9a1190ec1578.iam.gserviceaccount.com does not have storage.objects.get access to the Google Cloud Storage object.>
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$


student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gsutil cp gs://$MY_BUCKET_NAME_2/cat.jpg ./cat-copy.jpg
Copying gs://qwiklabs-gcp-02-9a1190ec1578_test/cat.jpg...
/ [1 files][ 81.7 KiB/ 81.7 KiB]
Operation completed over 1 objects/81.7 KiB.
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$



student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gcloud config set account student-02-cbb04b1269cd@qwiklabs.net
Updated property [core/account].
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gsutil cp gs://$MY_BUCKET_NAME_1/cat.jpg ./cat-copy.jpg
Copying gs://qwiklabs-gcp-02-9a1190ec1578/cat.jpg...
/ [1 files][ 81.7 KiB/ 81.7 KiB]
Operation completed over 1 objects/81.7 KiB.
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$



Make the first Cloud Storage bucket readable by everyone, including unauthenticated users.

gsutil iam ch allUsers:objectViewer gs://$MY_BUCKET_NAME_1

