tudent_02_b89333821a92@cloudshell:~ (qwiklabs-gcp-03-eec58c2c6c6a)$ git clone https://github.com/GoogleCloudPlatform/training-data-analyst
Cloning into 'training-data-analyst'...
remote: Enumerating objects: 48994, done.
remote: Counting objects: 100% (1349/1349), done.
remote: Compressing objects: 100% (548/548), done.
remote: Total 48994 (delta 725), reused 1250 (delta 683), pack-reused 47645
Receiving objects: 100% (48994/48994), 575.36 MiB | 18.28 MiB/s, done.
Resolving deltas: 100% (30586/30586), done.
Checking out files: 100% (10001/10001), done.
student_02_b89333821a92@cloudshell:~ (qwiklabs-gcp-03-eec58c2c6c6a)$ export my_zone=us-central1-a
student_02_b89333821a92@cloudshell:~ (qwiklabs-gcp-03-eec58c2c6c6a)$ export my_cluster=standard-cluster-1
student_02_b89333821a92@cloudshell:~ (qwiklabs-gcp-03-eec58c2c6c6a)$ source <(kubectl completion bash)
student_02_b89333821a92@cloudshell:~ (qwiklabs-gcp-03-eec58c2c6c6a)$ gcloud container clusters get-credentials $my_cluster --zone $my_zone
Fetching cluster endpoint and auth data.
kubeconfig entry generated for standard-cluster-1.
student_02_b89333821a92@cloudshell:~ (qwiklabs-gcp-03-eec58c2c6c6a)$ ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
student_02_b89333821a92@cloudshell:~ (qwiklabs-gcp-03-eec58c2c6c6a)$ cd ~/ak8s/RBAC/
student_02_b89333821a92@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$ kubectl apply -f ./production-pod.yaml
Error from server (Forbidden): error when creating "./production-pod.yaml": pods is forbidden: User "student-02-b89333821a92@qwiklabs.net" cannot create resource "pods" in API group "" in the namespace "production": requires one of ["container.pods.create"] permission(s).
student_02_b89333821a92@cloudshell:~/ak8s/RBAC (qwiklabs-gcp-03-eec58c2c6c6a)$




