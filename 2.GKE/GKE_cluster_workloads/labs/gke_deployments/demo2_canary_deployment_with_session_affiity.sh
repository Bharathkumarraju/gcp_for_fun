Session affinity
------------------------------>
The service configuration used in the lab does not ensure that all requests from a single client will always connect to the same Pod.
Each request is treated separately and can connect to either the normal nginx deployment or to the nginx-canary deployment.

This potential to switch between different versions may cause problems if there are significant changes in functionality in the canary release.
To prevent this you can set the sessionAffinity field to ClientIP in the specification of the service
if you need a clients first request to determine which Pod will be used for all subsequent connections.


apiVersion: v1
kind: Service
metadata:
  name: nginx
spec:
  type: LoadBalancer
  sessionAffinity: ClientIP
  selector:
    app: nginx
  ports:
  - protocol: TCP
    port: 60000
    targetPort: 80
