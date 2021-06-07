Cloud NAT is googles managed network address translation service.

It lets you provision your application instances without public ip adresses while also allowing them to access the internet in controlled and efficient manner.


This means your private instances can access the internet for updates, patching configuration management and more.


In the diagram,
----------------->
CLoud NAT enables two private instances to access and update server on the internet, which is referred to as outbound NAT.

However cloud NAT does not implement inbound-NAT,
In other words hosts outside of your VPC network can not directly access any of the private instances behind the cloud NAT gateway.
This helps you keep your VPC networks isolated and secure.



Cloud NAT offers a number of advantages when compared to other NAT offerings.

As a fully managed software defined service cloud NAT differs from traditional NAT proxy solutions because,
there are no NAT middle proxies in the path from the instance to the destination, instead each instance is allocated a NAT IPAddress along with a slice of these associated port range.

This allocated IP address and port range are programmed by Andromeda, which is google clouds network virtualization stack into the instance
and then used by the instance to perform that.

This provides a chokepoint free design that is highly reliable performance and scalable.



For scalability:
------------------>
Cloud NAT provides the ability to configure multiple NAT IPAddresses per NAT Gateway.
This allows us to scale based on the size of the network without having to add or manage another NAT gateway.

As for the NAT IP allocation, you can choose between manual and auto modes.

The manual mode provides full control when specifying IP addresses
which you might prefer if you need NAT IP addresses on the receiving side.

The auto mode enables that NAT IP addresses to be allocated and scaled automatically based on the number of instances.







