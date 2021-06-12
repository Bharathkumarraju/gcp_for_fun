Network loadbalncing has two levels of loadbalacing.

one  by the loadbalancer and another by the kube-proxy. Which results in multiple network hops.
even response traffic also follows the same path. Overall this method is not optimal for loadbalancing.


This process does keep the pod use even but at the expense of increased latency and extra network traffic.

So if you are using traditional kubernetes networking, you should choose what is the most suitable for you.
1. the lowest possible latency or
2. the most even cluster loadbalancing

Suppose that the lowest possible laency is most important  you can configure the loadbalancer service to force kube-proxy to choose the pod local to the node
that received the client traffic. to do that set the `externalTrafficPolicy: Local` as below.

apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  type: LoadBalancer
    externalTrafficPolicy: Local
  selector:
    app: external
   ports:
     - protocol: TCP
       port: 80
       targetPort: 9376

the above choice eliminates the double hop to another node. why?
Because kube-proxy will always choose pod on the receiving node. In addition when packets are forwarded from node to node the source client IP address is preserved
and directly visible to the destination pod. Although it preserves the source IP Address, it introduces the risk of creating imbalance in the load of the cluster.

Whats the best choice...well it depends on the your application.
you can profile both configurations and choose the one that gives best overall application performance.

In the kubernetes the standard workaround for the double hop problem is to use the local externalTrafficPolicy.
http or https LB forwards traffic via nodes instead of addressing the pods directly.

A true container first approach to loadbalancing is now available in GKE.
the solution still leverages the powerful GCPs HTTPS loadbalancer. However the loadbalancer now directs the traffic to the pods directly instead of the nodes.

this method requires your GKE to operate in VPC native mode and it relies on the data model called network endpoint groups(NEGs)
NEGs are a set of network endpoints representing IP to port pairs.
which means that ports cannot simply be just another endpoint within that group equal in standing to the compute VMs.

Every connection is made directly between the loadbalancer and the intended pods.
Traffic intended to pod3 will be routed directly from the LB to the IP address of the pod3 using network endpoint group.

there are many benifits using container native Loadbalancing and NEGs.

1. Pods can be specified directly as an endpoint for GCP loadbalancers. the traffic is appropriately directed to the intended pod, eliminating extra network hops.

2. LB features such as traffic shaping and advanced algorithms are supported.

3. With the direct connection to the pod the LoadBalancer can accurately distribute the traffic.

4. Container native loadbalancing allows direct visibilty to the pods and more accurate healthchecks.

5. sourceIP is preserved, which provides visibility into round trip time for the client to the loadbalancer and helps with troubleshooting.

6. This visibility can be easily extended using stack driver.

7. There are fewer network hops in the path, which optimizes the data path. This improves latency and throughput providing better network performance.

supports cloud armor policies and cloudCDN and IAP(Identity Aware Proxy)




















