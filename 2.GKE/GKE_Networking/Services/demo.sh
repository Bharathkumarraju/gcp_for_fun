kubernetes service is an object that creates dynamic collection of IP Addresses called endpoints
that belong to pods matching the services label Selector.


When we create a service that service is issued a static virtual ip address from the pool of IP addresses that the cluster reserves for services.

The virtual IP is durable, it is published to all nodes in the cluster.
It does not change even if all the pods behind it chnage.

In GKE this range is automatically managed for you. by default it contains 4000 addresses per cluster.




