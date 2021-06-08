Create a VPC network and firewall rules
First, create a VPC network for the VM instance and a firewall rule to allow SSH access.

In the Cloud Console, on the Navigation menu (Navigation menu), click VPC network > VPC networks.

Click Create VPC network.

For Name, type privatenet.

For Subnet creation mode, click Custom.

Specify the following, and leave the remaining settings as their defaults:

Property	Value (type value or select option as specified)
Name	privatenet-us
Region	us-central1
IP address range	10.130.0.0/20
Do not enable Private Google access yet!
Click Done.

Click Create and wait for the network to be created.

In the left pane, click Firewall.

Click Create firewall rule.

Specify the following, and leave the remaining settings as their defaults:

Property	Value (type value or select option as specified)
Name	privatenet-allow-ssh
Network	privatenet
Targets	All instances in the network
Source filter	IP ranges
Source IP ranges	35.235.240.0/20
Protocols and ports	Specified protocols and ports
For tcp, click the checkbox and specify port 22.

Click Create.

In order to connect to your private instance using SSH, you need to open an appropriate port on the firewall.
IAP connections come from a specific set of IP addresses (35.235.240.0/20). Therefore, you can limit the rule to this CIDR range.

======================================================================================================================================>

Create the VM instance with no public IP address
In the Cloud Console, on the Navigation menu (Navigation menu), click Compute Engine > VM instances.

Click Create.

Specify the following, and leave the remaining settings as their defaults:

Property	Value (type value or select option as specified)
Name	  vm-internal
Region	us-central1
Zone	  us-central1-c
Series	N1
Machine type	n1-standard-1 (1vCPU, 3.75 GB memory)
Boot disk	Debian GNU/Linux 10 (buster)

Click Management, security, disks, networking, sole tenancy.

Click Networking.

For Network interfaces, click the pencil icon to edit.

Specify the following, and leave the remaining settings as their defaults:

Property	Value (type value or select option as specified)
Network	privatenet
Subnetwork	privatenet-us
External IP	None

Click Done.
Click Create, and wait for the VM instance to be created.


--------------------------------------------------------------------------------->

gcloud compute ssh vm-internal --zone us-central1-c --tunnel-through-iap


student_02_752d7ef40849@cloudshell:~ (qwiklabs-gcp-00-dbf53ee777b3)$ gcloud compute ssh vm-internal --zone us-central1-c --tunnel-through-iap
WARNING: The private SSH key file for gcloud does not exist.
WARNING: The public SSH key file for gcloud does not exist.
WARNING: You do not have an SSH key for gcloud.
WARNING: SSH keygen will be executed to generate a key.
This tool needs to create the directory
[/home/student_02_752d7ef40849/.ssh] before being able to generate SSH
 keys.

Do you want to continue (Y/n)?  Y

Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/student_02_752d7ef40849/.ssh/google_compute_engine.
Your public key has been saved in /home/student_02_752d7ef40849/.ssh/google_compute_engine.pub.
The key fingerprint is:
SHA256:YwxWdCnrh7nwD2Jh8lnqKJK9ofQidXHDz+UniGIk5b8 student_02_752d7ef40849@cs-402372396434-default-default-zfxpx
The keys randomart image is:
+---[RSA 2048]----+
|       .o ..     |
|    .  ....      |
|   o .o  o       |
|  . +.+o. .      |
|   o.+o*S*       |
|  . +++*B.+ .    |
| =.o .*+.o o     |
|=o+. +E.o.       |
|o.o+. .  ..      |
+----[SHA256]-----+
Warning: Permanently added 'compute.2833619661865847902' (ECDSA) to the list of known hosts.
Linux vm-internal 4.19.0-16-cloud-amd64 #1 SMP Debian 4.19.181-1 (2021-03-19) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Creating directory '/home/student-02-752d7ef40849'.
student-02-752d7ef40849@vm-internal:~$

--------------------------------------------------------------------------------------------------------------->

student-02-752d7ef40849@vm-internal:~$ ping -c 2 www.google.com
PING www.google.com (209.85.234.105) 56(84) bytes of data.

--- www.google.com ping statistics ---
2 packets transmitted, 0 received, 100% packet loss, time 4ms

student-02-752d7ef40849@vm-internal:~$




When instances do not have external IP addresses,
they can only be reached by other instances on the network via a managed VPN gateway or via a Cloud IAP tunnel.

Cloud IAP enables context-aware access to VMs via SSH and RDP without bastion hosts. For more information about this, see this blog post.



bucket_name: bharathrajustest

gsutil mb -l asia gs://bharathrajustest
gsutil cp gs://cloud-training/gcpnet/private/access.svg gs://bharathrajustest

-------------------------------------------------------------------------------------------------------------------------------------------------------->


student_02_752d7ef40849@cloudshell:~ (qwiklabs-gcp-00-dbf53ee777b3)$ gsutil cp gs://cloud-training/gcpnet/private/access.svg gs://bharathrajustest
Copying gs://cloud-training/gcpnet/private/access.svg [Content-Type=image/svg+xml]...
/ [1 files][ 24.8 KiB/ 24.8 KiB]
Operation completed over 1 objects/24.8 KiB.
student_02_752d7ef40849@cloudshell:~ (qwiklabs-gcp-00-dbf53ee777b3)$

student_02_752d7ef40849@cloudshell:~ (qwiklabs-gcp-00-dbf53ee777b3)$
student_02_752d7ef40849@cloudshell:~ (qwiklabs-gcp-00-dbf53ee777b3)$ gsutil cp gs://bharathrajustest/*.svg .
Copying gs://bharathrajustest/access.svg...
/ [1 files][ 24.8 KiB/ 24.8 KiB]
Operation completed over 1 objects/24.8 KiB.
student_02_752d7ef40849@cloudshell:~ (qwiklabs-gcp-00-dbf53ee777b3)$


student_02_752d7ef40849@cloudshell:~ (qwiklabs-gcp-00-dbf53ee777b3)$ gcloud compute ssh vm-internal --zone us-central1-c --tunnel-through-iap
Linux vm-internal 4.19.0-16-cloud-amd64 #1 SMP Debian 4.19.181-1 (2021-03-19) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Mon Jun  7 14:55:12 2021 from 35.235.241.19
student-02-752d7ef40849@vm-internal:~$

student-02-752d7ef40849@vm-internal:~$ gsutil cp gs://bhararthrajustest/*.svg .
^CCaught CTRL-C (signal 2) - exiting
student-02-752d7ef40849@vm-internal:~$



student-02-752d7ef40849@vm-internal:~$
student-02-752d7ef40849@vm-internal:~$ gsutil cp gs://bharathrajustest/*.svg .
Copying gs://bharathrajustest/access.svg...
/ [1 files][ 24.8 KiB/ 24.8 KiB]
Operation completed over 1 objects/24.8 KiB.
student-02-752d7ef40849@vm-internal:~$


Task 3. Configure a Cloud NAT gateway
-------------------------------------------------------------------------------------------------->
Although vm-internal can now access certain Google APIs and services without an external IP address,
the instance cannot access the internet for updates and patches. Configure a Cloud NAT gateway, which allows vm-internal to reach the internet.




student_02_752d7ef40849@cloudshell:~ (qwiklabs-gcp-00-dbf53ee777b3)$ gcloud compute ssh vm-internal --zone us-central1-c --tunnel-through-iap
Linux vm-internal 4.19.0-16-cloud-amd64 #1 SMP Debian 4.19.181-1 (2021-03-19) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Mon Jun  7 15:12:42 2021 from 35.235.241.17

student-02-752d7ef40849@vm-internal:~$
student-02-752d7ef40849@vm-internal:~$ sudo apt-get update -y
Get:1 http://packages.cloud.google.com/apt cloud-sdk-buster InRelease [6774 B]
Get:2 http://packages.cloud.google.com/apt google-cloud-packages-archive-keyring-buster InRelease [5553 B]
Get:3 http://packages.cloud.google.com/apt google-compute-engine-buster-stable InRelease [5526 B]
Get:4 http://packages.cloud.google.com/apt cloud-sdk-buster/main amd64 Packages [166 kB]
Get:5 http://packages.cloud.google.com/apt google-cloud-packages-archive-keyring-buster/main amd64 Packages [398 B]
Get:6 http://packages.cloud.google.com/apt google-compute-engine-buster-stable/main amd64 Packages [2022 B]
0% [Connecting to deb.debian.org (151.101.186.132)] [Connecting to security.debian.org (151.101.66.132)]



Configure a Cloud NAT gateway
--------------------------------------------------------------------------------------------------->
Cloud NAT is a regional resource.
You can configure it to allow traffic from all ranges of all subnets in a region,
from specific subnets in the region only, or from specific primary and secondary CIDR ranges only.



In the Cloud Console, on the Navigation menu (Navigation menu), click Network services > Cloud NAT.

Click Get started to configure a NAT gateway.

Specify the following:

Property	Value (type value or select option as specified)
Gateway name	nat-config
VPC network	privatenet
Region	us-central1
For Cloud Router, select Create new router.

For Name, type nat-router

Click Create

The NAT mapping section allows you to choose the subnets to map to the NAT gateway.
You can also manually assign static IP addresses that should be used when performing NAT.
Do not change the NAT mapping configuration in this lab.
Click Create.
Wait for the gateways status to change to Running.




The Cloud NAT gateway implements outbound NAT, but not inbound NAT.
In other words, hosts outside of your VPC network can only respond to connections initiated by your instances;
they cannot initiate their own, new connections to your instances via NAT.




Private connections are a one-to-one relationship between your VPC network and a service producer and connect to a Private Service Connect endpoint in your VPC network,
which forwards requests to Google APIs and services.

Without external IP address assigned must be connected to a subnet with Private Google Access enabled.

