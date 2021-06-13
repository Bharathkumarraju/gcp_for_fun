Task 5. Create the Test Environment and CD Pipeline
Cloud Build is also used for the continuous delivery pipeline. The pipeline runs each time a commit is pushed to the candidate branch of the __hello-cloudbuild-env__repository.
The pipeline applies the new version of the manifest to the Kubernetes cluster and, if successful, copies the manifest over to the production branch. This process has the following properties:

The candidate branch is a history of the deployment attempts.
The production branch is a history of the successful deployments.
You have a view of successful and failed deployments in Cloud Build.
You can rollback to any previous deployment by re-executing the corresponding build in Cloud Build. A rollback also updates the production branch to truthfully reflect the history of deployments.
You will modify the continuous integration pipeline to update the candidate branch of the hello-cloudbuild-env repository, triggering the continuous delivery pipeline.

Grant Cloud Build access to GKE


To deploy the application in your Kubernetes cluster, Cloud Build needs the Kubernetes Engine Developer Identity and Access Management Role.

In Cloud Shell execute the following command:

PROJECT_NUMBER="$(gcloud projects describe ${PROJECT_ID} --format='get(projectNumber)')"
gcloud projects add-iam-policy-binding ${PROJECT_NUMBER} \
    --member=serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com \
    --role=roles/container.developer


student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ PROJECT_NUMBER="$(gcloud projects describe ${PROJECT_ID} --format='get(projectNumber)')"
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ gcloud projects add-iam-policy-binding ${PROJECT_NUMBER} \
>     --member=serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com \
>     --role=roles/container.developer
Updated IAM policy for project [816948167132].
bindings:
- members:
  - serviceAccount:qwiklabs-gcp-02-d9ddfe7472a6@qwiklabs-gcp-02-d9ddfe7472a6.iam.gserviceaccount.com
  - user:student-00-46bc792a0038@qwiklabs.net
  role: roles/appengine.appAdmin
- members:
  - serviceAccount:qwiklabs-gcp-02-d9ddfe7472a6@qwiklabs-gcp-02-d9ddfe7472a6.iam.gserviceaccount.com
  - user:student-00-46bc792a0038@qwiklabs.net
  role: roles/bigquery.admin
- members:
  - serviceAccount:816948167132@cloudbuild.gserviceaccount.com
  role: roles/cloudbuild.builds.builder
- members:
  - serviceAccount:service-816948167132@gcp-sa-cloudbuild.iam.gserviceaccount.com
  role: roles/cloudbuild.serviceAgent
- members:
  - serviceAccount:service-816948167132@compute-system.iam.gserviceaccount.com
  role: roles/compute.serviceAgent
- members:
  - serviceAccount:816948167132@cloudbuild.gserviceaccount.com
  role: roles/container.developer
- members:
  - serviceAccount:service-816948167132@container-engine-robot.iam.gserviceaccount.com
  role: roles/container.serviceAgent
- members:
  - serviceAccount:service-816948167132@container-analysis.iam.gserviceaccount.com
  role: roles/containeranalysis.ServiceAgent
- members:
  - serviceAccount:service-816948167132@containerregistry.iam.gserviceaccount.com
  role: roles/containerregistry.ServiceAgent
- members:
  - serviceAccount:service-816948167132@gcp-sa-containerscanning.iam.gserviceaccount.com
  role: roles/containerscanning.ServiceAgent
- members:
  - serviceAccount:816948167132-compute@developer.gserviceaccount.com
  - serviceAccount:816948167132@cloudservices.gserviceaccount.com
  - serviceAccount:qwiklabs-gcp-02-d9ddfe7472a6@qwiklabs-gcp-02-d9ddfe7472a6.iam.gserviceaccount.com
  - user:student-00-46bc792a0038@qwiklabs.net
  role: roles/editor
- members:
  - serviceAccount:qwiklabs-gcp-02-d9ddfe7472a6@qwiklabs-gcp-02-d9ddfe7472a6.iam.gserviceaccount.com
  - user:student-00-46bc792a0038@qwiklabs.net
  role: roles/iam.serviceAccountAdmin
- members:  - serviceAccount:admiral@qwiklabs-services-prod.iam.gserviceaccount.com
  - serviceAccount:qwiklabs-gcp-02-d9ddfe7472a6@qwiklabs-gcp-02-d9ddfe7472a6.iam.gserviceaccount.com  role: roles/owner
- members:
  - serviceAccount:qwiklabs-gcp-02-d9ddfe7472a6@qwiklabs-gcp-02-d9ddfe7472a6.iam.gserviceaccount.com
  - user:student-00-46bc792a0038@qwiklabs.net
  role: roles/resourcemanager.projectIamAdmin
- members:
  - serviceAccount:qwiklabs-gcp-02-d9ddfe7472a6@qwiklabs-gcp-02-d9ddfe7472a6.iam.gserviceaccount.com
  - user:student-00-46bc792a0038@qwiklabs.net
  role: roles/source.admin
- members:
  - serviceAccount:qwiklabs-gcp-02-d9ddfe7472a6@qwiklabs-gcp-02-d9ddfe7472a6.iam.gserviceaccount.com
  role: roles/storage.admin
- members:
  - serviceAccount:qwiklabs-gcp-02-d9ddfe7472a6@qwiklabs-gcp-02-d9ddfe7472a6.iam.gserviceaccount.com
  - user:student-00-46bc792a0038@qwiklabs.net
  role: roles/viewer
etag: BwXEoLNTXTM=
version: 1
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$


student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ cd ~
student_00_46bc792a0038@cloudshell:~ (qwiklabs-gcp-02-d9ddfe7472a6)$ gcloud source repos clone hello-cloudbuild-env
Cloning into '/home/student_00_46bc792a0038/hello-cloudbuild-env'...
warning: You appear to have cloned an empty repository.
Project [qwiklabs-gcp-02-d9ddfe7472a6] repository [hello-cloudbuild-env] was cloned to [/home/student_00_46bc792a0038/hello-cloudbuild-env].
student_00_46bc792a0038@cloudshell:~ (qwiklabs-gcp-02-d9ddfe7472a6)$ cd ~/hello-cloudbuild-env
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$ git checkout -b production
Switched to a new branch 'production'
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$ cd ~/hello-cloudbuild-env
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$ cp ~/hello-cloudbuild-app/cloudbuild-delivery.yaml ~/hello-cloudbuild-env/cloudbuild.yaml
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$ git add .
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$ git commit -m "Create cloudbuild.yaml for deployment"
[production (root-commit) 7040e8a] Create cloudbuild.yaml for deployment
 1 file changed, 49 insertions(+)
 create mode 100644 cloudbuild.yaml
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$


student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$ git checkout -b candidate
Switched to a new branch 'candidate'
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$ git push origin production
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Delta compression using up to 2 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 1.17 KiB | 1.17 MiB/s, done.
Total 3 (delta 0), reused 0 (delta 0)
To https://source.developers.google.com/p/qwiklabs-gcp-02-d9ddfe7472a6/r/hello-cloudbuild-env
 * [new branch]      production -> production
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$ git push origin candidate
Total 0 (delta 0), reused 0 (delta 0)
To https://source.developers.google.com/p/qwiklabs-gcp-02-d9ddfe7472a6/r/hello-cloudbuild-env
 * [new branch]      candidate -> candidate
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$



Grant the Source Repository Writer IAM role to the Cloud Build service account for the hello-cloudbuild-env repository.

student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$ PROJECT_NUMBER="$(gcloud projects describe ${PROJECT_ID} \
>     --format='get(projectNumber)')"
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$ cat >/tmp/hello-cloudbuild-env-policy.yaml <<EOF
> bindings:
> - members:
>   - serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com
>   role: roles/source.writer
> EOF
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$ gcloud source repos set-iam-policy \
>     hello-cloudbuild-env /tmp/hello-cloudbuild-env-policy.yaml
Updated IAM policy for repo [hello-cloudbuild-env].
bindings:
- members:
  - serviceAccount:816948167132@cloudbuild.gserviceaccount.com
  role: roles/source.writer
etag: BwXEoMLVo0o=
version: 1
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$




student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$ PROJECT_NUMBER="$(gcloud projects describe ${PROJECT_ID} \
>     --format='get(projectNumber)')"
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$ cat >/tmp/hello-cloudbuild-env-policy.yaml <<EOF
> bindings:
> - members:
>   - serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com
>   role: roles/source.writer
> EOF
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$ gcloud source repos set-iam-policy \
>     hello-cloudbuild-env /tmp/hello-cloudbuild-env-policy.yaml
Updated IAM policy for repo [hello-cloudbuild-env].
bindings:
- members:
  - serviceAccount:816948167132@cloudbuild.gserviceaccount.com
  role: roles/source.writer
etag: BwXEoMLVo0o=
version: 1
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-env (qwiklabs-gcp-02-d9ddfe7472a6)$ cd ~/hello-cloudbuild-app
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ cp cloudbuild-trigger-cd.yaml cloudbuild.yaml
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ cd ~/hello-cloudbuild-app
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ git add cloudbuild.yaml
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ git commit -m "Trigger CD pipeline"
[master 43d9988] Trigger CD pipeline
 1 file changed, 40 insertions(+)
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ git push google master

Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Delta compression using up to 2 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (2/2), 236 bytes | 236.00 KiB/s, done.
Total 2 (delta 1), reused 0 (delta 0)
remote: Resolving deltas: 100% (1/1)
To https://source.developers.google.com/p/qwiklabs-gcp-02-d9ddfe7472a6/r/hello-cloudbuild-app
   5b55cac..43d9988  master -> master
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$






