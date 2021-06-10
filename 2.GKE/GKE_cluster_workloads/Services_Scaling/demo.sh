Scaling Deployment Manually:
-------------------------------->
kubectl scale deployment nginx-deployment --replicas=5


Scaling Deployment Automatically:
------------------------------------->
kubectl autoscale deployment nginx-deployment --min=5 --max=15 --cpu-percent=75
it calls the kubernetes object called --> horizontal pod autoscaler


Thrashing is a problem with any type of autoscaling

Cooldown/delay support:
--horizontal-pod-autoscaler-downscale-stabilization

