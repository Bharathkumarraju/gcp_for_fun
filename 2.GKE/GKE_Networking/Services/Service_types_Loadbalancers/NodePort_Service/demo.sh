ClusterIP useful for internal communication with in a cluster? but what about external communication


NodePort enables this. NodePort is built on top of clusterIP service.
Therefore, when you create a NodePort service a clusterIP service is automatically created in the process.


