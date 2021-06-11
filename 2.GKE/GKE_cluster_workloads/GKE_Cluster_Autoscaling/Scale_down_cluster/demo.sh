scaledown a cluster with autoscaling:

1. There can be no scale-up events pending.
2. Can the node be deleted  safely?

pod conditions that prevent deletion are:

1. Pods not run by a controller
2. Pods that have local storage
3. Restricted by constraint rules
4. cluster-autoscaler.kubernetes.io/safe-to-evict is set to False
5. Restrictive PodDisruptionBudget
6. at node level kubernetes.io/scale-down-disabled set to True


