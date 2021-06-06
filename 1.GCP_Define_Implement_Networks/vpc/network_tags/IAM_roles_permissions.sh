Explore the Network and Security Admin roles
Cloud IAM lets you authorize who can take action on specific resources,
which give you full control and visibility to manage cloud resources centrally.
The following roles are used in conjunction with single-project networking to independently control administrative access to each VPC network:

Network Admin: Permissions to create, modify, and delete networking resources, except for firewall rules and SSL certificates.
Security Admin: Permissions to create, modify, and delete firewall rules and SSL certificates.

Explore these roles by applying them to a service account,
which is a special Google account that belongs to your VM instance instead of to an individual end user.

You will authorize test-vm to use the service account to demonstrate the permissions of the Network Admin and Security Admin roles, instead of creating a new user.



from the test-vm run below:
------------------------------>
gcloud compute firewall-rules list


student-04-da35526ce4ff@test-vm:~$ gcloud compute firewall-rules list

ERROR: (gcloud.compute.firewall-rules.list) Some requests did not succeed:
 - Request had insufficient authentication scopes.

student-04-da35526ce4ff@test-vm:~$
student-04-da35526ce4ff@test-vm:~$

student-04-da35526ce4ff@test-vm:~$ gcloud compute firewall-rules delete allow-http-web-server
The following firewalls will be deleted:
 - [allow-http-web-server]

Do you want to continue (Y/n)?  Y


ERROR: (gcloud.compute.firewall-rules.delete) Could not fetch resource:
 - Request had insufficient authentication scopes.

student-04-da35526ce4ff@test-vm:~$
student-04-da35526ce4ff@test-vm:~$


This is because: Compute Engine default service account
------------------------------------------------------>

The Compute Engine default service account does not have the right permissions to allow you to list or delete firewall rules.
The same applies to other users who do not have the right roles.




Create a service account
Create a service account and apply the Network Admin role.
-------------------------------------------------------------->

In the Cloud Console, on the Navigation menu (Navigation menu), click IAM & admin > Service accounts. Notice the Compute Engine default service account.
Click Create service account.
Set the Service account name to Network-admin.
Click Create.
For Select a role, select Compute Engine > Compute Network Admin.
Click Continue.
Click Done.

Optionally you could create and download a file that contains the private key. However, we can just stop test-vm and authorize it to use the service account


==============================================================================================================================================================================>
On the Navigation menu, click Compute Engine > VM instances.
Click on the name of the test-vm instance to open the VM instance details page.
Click Stop and confirm to Stop the instance. Wait for the instance to stop before proceeding to the next step.
An instance must be stopped to edit its service account.
Once the instance stopped, click Edit.

Select Network-admin for Service account.

Click Save and wait for the instance to update.

Click Start and confirm to Start the instance.

Return to the Vm instances page and wait for test-vm to change to a running state

---------------------------------------------------------------------------------------------------------------------------->

In the Cloud Console, on the Navigation menu (Navigation menu), click IAM & admin > IAM.

Find the Network-admin account. Focus on the Name column to identify this account.

Click on the pencil icon for the Network-admin account.

Change Role to Compute Engine > Compute Security Admin.

Click Save.

Return to the SSH terminal of the test-vm instance.

Run the following command to try to list the available firewall rules:

gcloud compute firewall-rules list
The output should look like this (do not copy; this is example output):





student-04-da35526ce4ff@test-vm:~$ gcloud compute firewall-rules list
NAME                    NETWORK  DIRECTION  PRIORITY  ALLOW                         DENY  DISABLED
allow-http-web-server   default  INGRESS    1000      tcp:80                              False
default-allow-icmp      default  INGRESS    65534     icmp                                False
default-allow-internal  default  INGRESS    65534     tcp:0-65535,udp:0-65535,icmp        False
default-allow-rdp       default  INGRESS    65534     tcp:3389                            False
default-allow-ssh       default  INGRESS    65534     tcp:22                              False

To show all fields of the firewall, please show in JSON format: --format=json
To show all fields in table format, please see the examples in --help.

student-04-da35526ce4ff@test-vm:~$




student-04-da35526ce4ff@test-vm:~$
student-04-da35526ce4ff@test-vm:~$ gcloud compute firewall-rules delete allow-http-web-server
The following firewalls will be deleted:
 - [allow-http-web-server]

Do you want to continue (Y/n)?  Y

ERROR: (gcloud.compute.firewall-rules.delete) Could not fetch resource:
 - Required 'compute.firewalls.delete' permission for 'projects/qwiklabs-gcp-04-fdc559c28044/global/firewalls/allow-http-web-server'

student-04-da35526ce4ff@test-vm:~$





student-04-da35526ce4ff@test-vm:~$ gcloud compute firewall-rules list
NAME                    NETWORK  DIRECTION  PRIORITY  ALLOW                         DENY  DISABLED
allow-http-web-server   default  INGRESS    1000      tcp:80                              False
default-allow-icmp      default  INGRESS    65534     icmp                                False
default-allow-internal  default  INGRESS    65534     tcp:0-65535,udp:0-65535,icmp        False
default-allow-rdp       default  INGRESS    65534     tcp:3389                            False
default-allow-ssh       default  INGRESS    65534     tcp:22                              False

To show all fields of the firewall, please show in JSON format: --format=json
To show all fields in table format, please see the examples in --help.

student-04-da35526ce4ff@test-vm:~$ gcloud compute firewall-rules delete allow-http-web-server
The following firewalls will be deleted:
 - [allow-http-web-server]

Do you want to continue (Y/n)?  Y

Deleted [https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-04-fdc559c28044/global/firewalls/allow-http-web-server].
student-04-da35526ce4ff@test-vm:~$




student-04-da35526ce4ff@test-vm:~$ curl 35.226.228.79
curl: (7) Failed to connect to 35.226.228.79 port 80: Connection timed out
student-04-da35526ce4ff@test-vm:~$

student-04-da35526ce4ff@test-vm:~$ curl 104.198.165.55
curl: (7) Failed to connect to 104.198.165.55 port 80: Connection timed out
student-04-da35526ce4ff@test-vm:~$


