Set up a private cluster
On the Navigation menu (8c24be286e75dbe7.png), click Kubernetes Engine > Clusters.
Click Create.

Click Configure to select Standard mode for the cluster.

Name the cluster private-cluster.

Select us-central1-a as the zone.

Click on default-pool under NODE POOLS section and then enter 2 in Number of nodes section.

Click on Networking section, select Enable VPC-native traffic routing (uses alias IP).

In the Networking section, select Private cluster and select Access control plane using its external IP address.

For Control plane IP Range, enter 172.16.0.0/28.
Note: This step assumes that you donot have this range assigned to a subnet.
Check VPC Networks in the Google Cloud Console, and select a different range if necessary.
Behind the scenes, Google Cloud uses VPC peering to connect the VPC of the cluster master with your default VPC network.



Deselect Enable control plane authorized networks.
This setting allows you to define the range of addresses that can access the cluster master externally.
When this checkbox is not selected, you can access kubectl only from within the Google Cloud network.
In this lab, you will only access kubectl through the Google Cloud network but you will modify this setting later.

Click Create.
