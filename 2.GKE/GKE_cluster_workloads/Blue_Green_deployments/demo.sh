Applying recreate strategy.


kubernetes Service is a load balancing frontend for pods

kubectl apply -f my-app-v2.yaml

kubectl patch service my-app-service -p \
{"spec":{"selector":{"version":"v2"}}}


Resource usage gets doubled at the time of blue green deployment.

