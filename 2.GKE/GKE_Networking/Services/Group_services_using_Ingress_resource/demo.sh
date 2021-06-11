A way to group services together using the Ingress resource.
one most powerful tools to direct the traffic to cluster.

Ingress resource operates one layer higher than the services.

Ingress is not a service or even type service.
It is a collection of rules that direct external inbound connections to a set of servcices within the cluster.

In GKE an ingress resource exposes these services using a single public IP Address bound to http or https loadbalancer provisioned within the google cloud.


On GKE Kubernetes ingress resources are implemented using cloud loadbalancing.
When you create a ingress resource in your cluster GKE creates HTTP(or) HTTPS Loadbalancer and configures it to route traffic to your application.

ingress service directs traffic to NodePort services or loadbalancer.



$ kubectl edit ingress [NAME]

$ kubectl replace -f [FILE]

