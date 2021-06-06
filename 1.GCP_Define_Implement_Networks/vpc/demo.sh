
1. VMs can be on the same subnet but in different zones.
2. A single firewall rule can apply to both the VMs.



IP space is exhausted.



View the routes
------------------>
Routes tell VM instances and the VPC network how to send traffic from an instance to a destination, either inside the network or outside Google Cloud.
Each VPC network comes with some default routes to route traffic among its subnets and send traffic from eligible instances to the internet.

In the left pane, click Routes.

Notice that there is a route for each subnet and one for the Default internet gateway (0.0.0.0/0).
These routes are managed for you.

but you can create custom static routes to direct some packets to specific destinations.

For example:
===============>
you can create a route that sends all outbound traffic to an instance configured as a NAT gateway.


View the firewall rules
------------------------------>
Each VPC network implements a distributed virtual firewall that you can configure.
Firewall rules allow you to control which packets are allowed to travel to which destinations.
Every VPC network has two implied firewall rules that block all incoming connections and allow all outgoing connections.

In the left pane, click Firewall.
Notice that there are 4 Ingress firewall rules for the default network:
default-allow-icmp
default-allow-rdp
default-allow-ssh
default-allow-internal

These firewall rules allow ICMP, RDP, and SSH ingress traffic from anywhere (0.0.0.0/0)
and all TCP, UDP, and ICMP traffic within the network (10.128.0.0/9) and  The Targets, Filters, Protocols/ports, and Action columns explain these rules.

