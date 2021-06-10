A note about Services
--------------------------------->

Services provide load-balanced access to specified Pods. There are three primary types of
Services:
● ClusterIP: Exposes the service on an IP address that is only accessible from within this cluster. This is the default type.
● NodePort: Exposes the service on the IP address of each node in the cluster, at a specific port number.
● LoadBalancer: Exposes the service externally, using a load balancing service provided by a cloud provider.

In Google Kubernetes Engine, LoadBalancers give you access to a regional Network Load Balancing configuration by default.

To get access to a global HTTP(S) Load Balancing configuration, you can use an Ingress object.
You will learn more about Services and Ingress objects in a later module in this learning path.