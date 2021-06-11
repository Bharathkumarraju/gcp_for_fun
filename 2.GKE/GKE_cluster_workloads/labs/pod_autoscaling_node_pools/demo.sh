Configuring Pod Autoscaling and NodePools
----------------------------------------------->

Overview:
------------>

In this lab, you set up an application in Google Kubernetes Engine (GKE),
and then use a HorizontalPodAutoscaler to autoscale the web application.
You then work with multiple node pools of different types, and you apply taints and tolerations to control the scheduling of Pods with respect to the underlying node pool.

Objectives:
--------------->

In this lab, you learn how to perform the following tasks:

Configure autoscaling and HorizontalPodAutoscaler

Add a node pool and configure taints on the nodes for Pod anti-affinity

Configure an exception for the node taint by adding a toleration to a Pod's manifest



