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



