

1. ClusterIP
-------------------->
ClusterIP has a static ipaddress and operates as a traffic distributor with in the cluster.
But ClusterIP services are not accessible by resources outside the cluster.


In addition to the setup of a clusterIP service, a specific port is exposed on every node.
thid port is called NodePort...this automatically allocated from the range of 30000 to 32767
In some cases users want to manually specify it which is allowed as long as the value falls within the range.
ClusterIP useful for internal communication with in a cluster? but what about external communication


apiVersion: v1
kind: service
metadata:
  name: my-service
spec:
  type: clusterIP
  selector:
    app: Backend
  ports:
    - protocol: TCP
      nodePort: 30100
      port: 3306
      targetPort: 6000

