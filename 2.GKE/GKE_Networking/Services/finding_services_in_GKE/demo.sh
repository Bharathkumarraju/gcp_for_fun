There are several ways to find a service in a GKE.

ways of service discovery:
-------------------------------->

1. Environment variables

2. Kubernetes DNS

3. Istio



1. Environment variables(enabled by default but its not most robust way for service discovery):

When a new pod starts running on a node kubelet adds set of environment variables for each active service in the same namespace as pod.


2. Kubernetes DNS for servuice discovery
In kubernetes DNS is optional add on. However DNS is pre-installed in google kubernetes engine.

K8s DNS server watches the API server for the creation of new services.
When a new service is created, kubeDNS automatically creates a set of DNS records for it.

kubernetes is configured to use the kube DNS service IP to resolve DNS names for all pods.
with this all the pods in the cluster can resolve k8s service names automatically.

service_name: lab
namespace: demo

fqdn: lab.demo.svc.cluster.local (or) lab.demo

SRV records for named ports.


3. Istio
Opensource servicemesh
Available as plugin in GKE.


