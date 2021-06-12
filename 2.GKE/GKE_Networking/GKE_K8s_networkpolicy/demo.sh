so far by default all pods can communicate with one and another by default.

inorder to restrict access to certain pods, the solution is to implemet network policy.

Network_Policy:
------------------->
A set of firewall rules at pod level that restrict access to other pods and services in the cluster.



Enable network policy using kubectl commands for new clusters.
gcloud container clusters create [NAME] --enable-network-policy


Enable network policy using kubectl commands for exisitnig clusters.
gcloud container clusters update [NAME] --update-addons-NetworkPolicy=ENABLED
gcloud container clusters update [NAME] --enable-network-policy


disable network policy for a cluster:
gcloud container clusters create [NAME] --no-enable-network-policy


better to use istio for network policies.

