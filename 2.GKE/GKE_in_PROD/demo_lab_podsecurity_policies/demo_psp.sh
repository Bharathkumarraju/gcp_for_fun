student_01_843232c53ec8@cloudshell:~ (qwiklabs-gcp-03-1e8e6d8dde95)$ export my_zone=us-central1-a
student_01_843232c53ec8@cloudshell:~ (qwiklabs-gcp-03-1e8e6d8dde95)$ export my_cluster=standard-cluster-1
student_01_843232c53ec8@cloudshell:~ (qwiklabs-gcp-03-1e8e6d8dde95)$ source <(kubectl completion bash)
student_01_843232c53ec8@cloudshell:~ (qwiklabs-gcp-03-1e8e6d8dde95)$ gcloud container clusters get-credentials $my_cluster --zone $my_zone
Fetching cluster endpoint and auth data.
kubeconfig entry generated for standard-cluster-1.
student_01_843232c53ec8@cloudshell:~ (qwiklabs-gcp-03-1e8e6d8dde95)$ git clone https://github.com/GoogleCloudPlatform/training-data-analyst
Cloning into 'training-data-analyst'...
remote: Enumerating objects: 48994, done.
remote: Counting objects: 100% (1349/1349), done.
remote: Compressing objects: 100% (546/546), done.
remote: Total 48994 (delta 725), reused 1247 (delta 685), pack-reused 47645
Receiving objects: 100% (48994/48994), 575.52 MiB | 18.63 MiB/s, done.
Resolving deltas: 100% (30587/30587), done.
Checking out files: 100% (10001/10001), done.
student_01_843232c53ec8@cloudshell:~ (qwiklabs-gcp-03-1e8e6d8dde95)$ ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
student_01_843232c53ec8@cloudshell:~ (qwiklabs-gcp-03-1e8e6d8dde95)$ cd ~/ak8s/Security/
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ ls
allow-privileged-psp.yaml  privileged-pod.yaml  restricted-pods-role.yaml  restricted-psp.yaml  unprivileged-pod.yaml  unrestricted-pods-role.yaml
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ kubectl apply -f restricted-psp.yaml
podsecuritypolicy.policy/restricted-psp created
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$


This policy has no effect until a cluster role is created and bound to a user or service account with the permission to use the policy.

student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ kubectl get podsecuritypolicy restricted-psp
NAME             PRIV    CAPS   SELINUX    RUNASUSER          FSGROUP    SUPGROUP   READONLYROOTFS   VOLUMES
restricted-psp   false          RunAsAny   MustRunAsNonRoot   RunAsAny   RunAsAny   false            *
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ kubectl describe podsecuritypolicy restricted-psp
Name:         restricted-psp
Namespace:
Labels:       <none>
Annotations:  <none>
API Version:  policy/v1beta1
Kind:         PodSecurityPolicy
Metadata:
  Creation Timestamp:  2021-06-13T02:16:01Z
  Managed Fields:
    API Version:  policy/v1beta1
    Fields Type:  FieldsV1
    fieldsV1:
      f:metadata:
        f:annotations:
          .:
          f:kubectl.kubernetes.io/last-applied-configuration:
      f:spec:
        f:allowPrivilegeEscalation:
        f:fsGroup:
          f:rule:
        f:runAsUser:
          f:rule:
        f:seLinux:
          f:rule:
        f:supplementalGroups:
          f:rule:
        f:volumes:
    Manager:         kubectl-client-side-apply
    Operation:       Update
    Time:            2021-06-13T02:16:01Z
  Resource Version:  3257
  Self Link:         /apis/policy/v1beta1/podsecuritypolicies/restricted-psp
  UID:               30591497-3eab-43b3-ba95-072483b9bff4
Spec:
  Allow Privilege Escalation:  true
  Fs Group:
    Rule:  RunAsAny
  Run As User:
    Rule:  MustRunAsNonRoot
  Se Linux:
    Rule:  RunAsAny
  Supplemental Groups:
    Rule:  RunAsAny
  Volumes:
    *
Events:  <none>
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$


This policy has no effect until a cluster role is created and bound to a user or service account with the permission to use the policy.

Create a ClusterRole for a pod security policy
The file restricted-pods-role.yaml creates a ClusterRole that includes the resource you created in the last task,
restricted-psp, and grants the subject the ability to use the restricted-psp resource.
The subject is the user or service account that is bound to this role. You will bind an account to this role later to enable the use of the policy.

The file restricted-pods-role.yaml has been provided for you.

However, before you can create a role, the account you use to create the role must already have the permissions granted in the role being assigned.
For cluster administrators this can be easily accomplished by creating the necessary RoleBinding to grant your own user account the cluster-admin role.
The Username 1 account has project owner rights and this automatically makes this user a cluster administrator.



student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ export USERNAME_1_EMAIL=$(gcloud info --format='value(config.account)')
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ echo $USERNAME_1_EMAIL
student-01-843232c53ec8@qwiklabs.net

To grant your user account cluster-admin privileges, run the following command:

student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user $USERNAME_1_EMAIL
clusterrolebinding.rbac.authorization.k8s.io/cluster-admin-binding created
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$


kubectl get clusterrole restricted-pods-role


student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user $USERNAME_1_EMAIL
clusterrolebinding.rbac.authorization.k8s.io/cluster-admin-binding created
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ kubectl apply -f restricted-pods-role.yaml
clusterrole.rbac.authorization.k8s.io/restricted-pods-role created
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ kubectl get clusterrole restricted-pods-role
NAME                   CREATED AT
restricted-pods-role   2021-06-13T02:22:07Z
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ kubectl describe clusterrole restricted-pods-role
Name:         restricted-pods-role
Labels:       <none>
Annotations:  <none>
PolicyRule:
  Resources                       Non-Resource URLs  Resource Names    Verbs
  ---------                       -----------------  --------------    -----
  podsecuritypolicies.extensions  []                 [restricted-psp]  [use]
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$




Activate Security Policy
-------------------------------->
The PodSecurityPolicy controller must be enabled to affect the admission control of new Pods in the cluster.

execute the following command to enable the PodSecurityPolicy controller:

gcloud beta container clusters update $my_cluster --zone $my_zone --enable-pod-security-policy


execute the following command to check that the PodSecurityPolicy controller is active:

kubectl get podsecuritypolicies

When the PodSecurityPolicy controller is fully active you will see a number of policies starting with gce..
Repeat the command after a minute or two until you see more than one policy listed.

Note that one of the built in policies, gce.privileged, explicitly allows privileged pods to be deployed.
By default, only accounts that are bound to the cluster-admin role have permission to use the gce.privileged policy.



To confirm that the Username 1 account has access to the gce.privileged pod security policy run the following command:

kubectl auth can-i use podsecuritypolicy/gce.privileged



student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ gcloud beta container clusters update $my_cluster --zone $my_zone --enable-pod-security-policy
Updating standard-cluster-1...⠹
Updating standard-cluster-1...⠼
Updating standard-cluster-1...done.
Updated [https://container.googleapis.com/v1beta1/projects/qwiklabs-gcp-03-1e8e6d8dde95/zones/us-central1-a/clusters/standard-cluster-1].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/us-central1-a/standard-cluster-1?project=qwiklabs-gcp-03-1e8e6d8dde95
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$



student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ kubectl get podsecuritypolicies
NAME                           PRIV    CAPS                                                                                                                        SELINUX    RUNASUSER          FSGROUP    SUPGROUP   READONLYROOTFS   VOLUMES
gce.event-exporter             false                                                                                                                               RunAsAny   RunAsAny           RunAsAny   RunAsAny   false            hostPath,secret
gce.fluentbit-gke              false                                                                                                                               RunAsAny   RunAsAny           RunAsAny   RunAsAny   false            configMap,hostPath,secret
gce.gke-metrics-agent          false                                                                                                                               RunAsAny   RunAsAny           RunAsAny   RunAsAny   false            hostPath,secret,configMap
gce.persistent-volume-binder   false                                                                                                                               RunAsAny   RunAsAny           RunAsAny   RunAsAny   false            nfs,secret,projected
gce.privileged                 true    *                                                                                                                           RunAsAny   RunAsAny           RunAsAny   RunAsAny   false            *
gce.unprivileged-addon         false   SETPCAP,MKNOD,AUDIT_WRITE,CHOWN,NET_RAW,DAC_OVERRIDE,FOWNER,FSETID,KILL,SETGID,SETUID,NET_BIND_SERVICE,SYS_CHROOT,SETFCAP   RunAsAny   RunAsAny           RunAsAny   RunAsAny   false            emptyDir,configMap,secret,projected
restricted-psp                 false                                                                                                                               RunAsAny   MustRunAsNonRoot   RunAsAny   RunAsAny   false            *
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$



student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$ kubectl auth can-i use podsecuritypolicy/gce.privileged
Warning: resource 'podsecuritypolicies' is not namespace scoped in group 'policy'
yes
student_01_843232c53ec8@cloudshell:~/ak8s/Security (qwiklabs-gcp-03-1e8e6d8dde95)$







