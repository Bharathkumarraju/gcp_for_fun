Inspect your cluster
In the Cloud Shell, enter the following command to review the details of your new cluster:

gcloud container clusters describe private-cluster --region us-central1-a

The following values appear only under the private cluster:

1. privateEndpoint, an internal IP address. Nodes use this internal IP address to communicate with the cluster master.

2. publicEndpoint, an external IP address. External services and administrators can use the external IP address to communicate with the cluster master.


You have several options to lock down your cluster to varying degrees:

1. The whole cluster can have external access
2. The whole cluster can be private
3. The nodes can be private while the cluster master is public, and you can limit which external networks are authorized to access the cluster master.

Without public IP addresses, code running on the nodes cannot access the public internet unless you configure a NAT gateway such as Cloud NAT.

You might use private clusters to provide services such as

1. internal APIs that are meant only to be accessed by resources inside your network.
For example, the resources might be private tools that only your company uses.
Or they might be backend services accessed by your frontend services,
and perhaps only those frontend services are accessed directly by external customers or users.

In such cases, private clusters are a good way to reduce the surface area of attack for your application.



Task 2. Add an authorized network for cluster master access

After cluster creation, you might want to issue commands to your cluster from outside Google Cloud.
For example, you might decide that only your corporate network should issue commands to your cluster master.
Unfortunately, you didnot specify the authorized network on cluster creation.

you add an authorized network for cluster master access.
you make the Kubernetes master API accessible to a specific range of network addresses.
In a real-world use of GKE, this connection would be used by IT staff and automated processes, not end-users.


Click private-cluster to open the Clusters details page.
In Details tab, for Control plane authorized networks click on the Edit(pencil-icon.png).

Select Enable Control plane authorized networks.
Click Add authorized network.

For Name, type the name for the network, use Corporate.
For Network, type a CIDR range that you want to grant whitelisted access to your cluster master. As an example, you can use 192.168.1.0/24.
Click Done.
Multiple networks can be added here if necessary, but no more than 50 CIDR ranges.

Outside this lab environment,
a practical example might be to whitelist only the public, outside address of your corporate firewall.
For example, if your corporate firewalls IP address were 8.8.8.14, you could whilelist access to 8.8.8.14/32.
