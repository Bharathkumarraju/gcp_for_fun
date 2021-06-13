student_03_84ffe14eedb5@cloudshell:~ (qwiklabs-gcp-03-1e8e6d8dde95)$ export my_zone=us-central1-a
student_03_84ffe14eedb5@cloudshell:~ (qwiklabs-gcp-03-1e8e6d8dde95)$ export my_cluster=standard-cluster-1
student_03_84ffe14eedb5@cloudshell:~ (qwiklabs-gcp-03-1e8e6d8dde95)$ source <(kubectl completion bash)
student_03_84ffe14eedb5@cloudshell:~ (qwiklabs-gcp-03-1e8e6d8dde95)$ gcloud container clusters get-credentials $my_cluster --zone $my_zone
Fetching cluster endpoint and auth data.
kubeconfig entry generated for standard-cluster-1.
student_03_84ffe14eedb5@cloudshell:~ (qwiklabs-gcp-03-1e8e6d8dde95)$ gcloud container clusters get-credentials $my_cluster --zone $my_zone
Fetching cluster endpoint and auth data.
kubeconfig entry generated for standard-cluster-1.
student_03_84ffe14eedb5@cloudshell:~ (qwiklabs-gcp-03-1e8e6d8dde95)$ git clone https://github.com/GoogleCloudPlatform/training-data-analyst
Cloning into 'training-data-analyst'...
remote: Enumerating objects: 48994, done.
remote: Counting objects: 100% (1349/1349), done.
remote: Compressing objects: 100% (546/546), done.
remote: Total 48994 (delta 725), reused 1247 (delta 685), pack-reused 47645
Receiving objects: 100% (48994/48994), 575.52 MiB | 18.30 MiB/s, done.
Resolving deltas: 100% (30587/30587), done.
Checking out files: 100% (10001/10001), done.
student_03_84ffe14eedb5@cloudshell:~ (qwiklabs-gcp-03-1e8e6d8dde95)$ ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
student_03_84ffe14eedb5@cloudshell:~ (qwiklabs-gcp-03-1e8e6d8dde95)$ cd ~/ak8s/Security/
student_03_84ffe14eedb5@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ kubectl apply -f unprivileged-pod.yaml
Error from server (Forbidden): error when creating "unprivileged-pod.yaml": pods "unprivileged-pod" is forbidden: PodSecurityPolicy: unable to admit pod: []
student_03_84ffe14eedb5@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ kubectl apply -f privileged-pod.yaml
Error from server (Forbidden): error when creating "privileged-pod.yaml": pods "privileged-pod" is forbidden: PodSecurityPolicy: unable to admit pod: []
student_03_84ffe14eedb5@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$




You should not be able to deploy the unprivileged Pod because the Username 2 account has not yet been bound to any role that allows pods to be deployed.


You should also not be able to deploy the privileged Pod because the Username 2 account has not yet been bound to any role that allows privileged pods to be deploye


student_03_84ffe14eedb5@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ kubectl auth can-i use podsecuritypolicy/restricted-psp
Warning: resource 'podsecuritypolicies' is not namespace scoped in group 'policy'
no - requires one of ["container.podSecurityPolicies.use"] permission(s).
student_03_84ffe14eedb5@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$

student_03_84ffe14eedb5@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ kubectl auth can-i use podsecuritypolicy/gce.privileged
Warning: resource 'podsecuritypolicies' is not namespace scoped in group 'policy'
no - requires one of ["container.podSecurityPolicies.use"] permission(s).
student_03_84ffe14eedb5@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$



student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ export USERNAME_2_EMAIL=student-03-84ffe14eedb5@qwiklabs.net
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ kubectl create clusterrolebinding restricted-pods-binding --clusterrole restricted-pods-role --user $USERNAME_2_EMAIL
clusterrolebinding.rbac.authorization.k8s.io/restricted-pods-binding created
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$





student_03_84ffe14eedb5@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ kubectl apply -f unprivileged-pod.yaml
pod/unprivileged-pod created
student_03_84ffe14eedb5@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ kubectl apply -f privileged-pod.yaml
Error from server (Forbidden): error when creating "privileged-pod.yaml": pods "privileged-pod" is forbidden: PodSecurityPolicy: unable to admit pod: [spec.containers[0].securityContext.privileged: Invalid value: true: Privileged containers are not allowed]
student_03_84ffe14eedb5@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$

This command will still fail because Username 2 still does not have access to the any PSP that allows users to deploy privileged pods.






