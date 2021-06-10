The canary method is another update strategy based on the blue green method. The traffic is gradually shifted to the new version.

The main advantages of using canary deployments are
1. We can minimize the extra resource usage during the update
2. And because the rollout is gradual issues can be identified before they affect all instances of the application.

kubectl apply -f my-app-v2.yaml
kubectl scale deploy/my-app-v2 --replicas=10
kubectl delete -f my-app-v1.yaml


A service configuration does not normally ensures that all requests from a single client will always connect to the same pod.
Each request is treated separately and can connect to any pod deployment. THis potentially can cause issues if there is significant chages in the functionality between pods as may happen with canary deployment.

To prevent the above issue, we can set the session affinity field to the client IP in the specification of the service, if you need the clients first request to determine which pod will be used for
all subsequent connections.






