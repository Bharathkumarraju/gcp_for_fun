Task 2. Create and Use Pod Security Policies

When you enable pod security policy admission control on a cluster the default security policies configured by Kubernetes Engine prevent non-admin users running privileged pods.

Users that are bound to the cluster-admin role are allowed to use the default policies that are installed when you enable Pod Security policies.
You have to explicitly bind other users to roles that grant them the right to use specific policies, and this allows you to control what those users can and cannot deploy.

In this task you create a pod security policy that allows the creation of unprivileged Pods in the default namespace of the cluster.
Unprivileged Pods do not allow users to execute code as root, and have limited access to devices on the host.

You create a ClusterRole that can then be used in a role binding that ties the policy to accounts that require the ability to deploy pods with unprivileged access.

Users that require the ability to deploy privileged Pods can be granted access to the built in PSP that is provided to allow admin users to deploy pods after Pod Security Policies are enabled.

When you have the components configured you will enable the PodSecurityPolicy controller, which enforces these policies, and then test how they impact users with different privileges.







This policy will only allow unprivileged Pods to be deployed and prevents privilege elevation using runAsUser with root account access.

apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: restricted-psp
spec:
  privileged: false  # Don't allow privileged pods!
  seLinux:
    rule: RunAsAny
  supplementalGroups:
    rule: RunAsAny
  runAsUser:
    rule: MustRunAsNonRoot
  fsGroup:
    rule: RunAsAny
  volumes:
  - '*'

This security policy can be used to provide users with accounts that
are not bound to the Kubernetes cluster admin roles with the ability to deploy only unprivileged pods
when the PodSecurityPolicy admission controller is enabled.




