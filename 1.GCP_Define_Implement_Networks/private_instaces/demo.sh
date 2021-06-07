Eevn-though an application is running in the cloud, We might not want it to be accessible to the outside world.

So we configure our VM instances to only to have private IPs but not external or public IPs.


For example:
---------------->
You might have a business critical application running on a VM in your VPC network that can only be accessed by other instances in the same network.

although this helps keeps your VM instances isolated, it also prevents it from accessing the public IPAddresses of google apis and services and
other insternet services for updates and patches.


To work around these constraints:
----------------------------------->

1. You can enable private google access and configure a network address translation or nat gateway.


private google access:
----------------------------->
Private google access allows VM instances that only have internal IPAddresses to reac the external IPAddresses of google APIs and services.


For example:
------------->

If a private VM instance needs to access a cloud storage bucket, we need to enable private google access.
We enable priavte google access on a subnet by subnet basis.

as shown in diagram subnet-a has private google access is enabled and subnet-b private google access is diabled.
This allows VM A1 to access google APIs and services eventhough it does not have an external IP address.

private google access has no effect on instances that have external IPAddresses. thats why VM A2 and B2 can access google APIs and services.
The only VM that can not access the google APIs and services is VM B1.
VM B1 --> Does not a have public IP address and it is in the subnet where the private google access is disabled.





