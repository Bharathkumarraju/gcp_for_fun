# Network-Tags

Network tags are used by networks to identify which VM instances are subject to certain firewall rules and network routes.

you create a firewall rule to allow HTTP access for VM instances with the web-server tag.
Alternatively, you could select the Allow HTTP traffic checkbox, which would tag this instance as http-server and create the tagged firewall rule for tcp:80 for you.

in blue server:
------------------->
sudo apt-get install nginx-light -y
sudo vim /var/www/html/index.nginx-debian.html


Replace the <h1>Welcome to nginx!</h1> line with <h1>Welcome to the blue server!</h1>.

In green server:
------------------>
sudo apt-get install nginx-light -y
sudo vim /var/www/html/index.nginx-debian.html


Replace the <h1>Welcome to nginx!</h1> line with <h1>Welcome to the green server!</h1>.





Create the firewall rule
Create the tagged firewall rule and test HTTP connectivity.

Create the tagged firewall rule
======================================>
Create a firewall rule that applies to VM instances with the web-server network tag.

In the Cloud Console, on the Navigation menu, click VPC network > Firewall.
Notice the default-allow-internal firewall rule.
The default-allow-internal firewall rule allows traffic on all protocols/ports within the default network.

You want to create a firewall rule to allow traffic from outside this network to only the blue server, by using the network tag web-server.

Click Create Firewall Rule.
------------------------------->
Specify the following, and leave the remaining settings as their defaults:

Property	        Value (type value or select option as specified)
Name	            allow-http-web-server
Network	          default
Targets	          Specified target tags
Target tags	      web-server
Source filter	    IP Ranges
Source IP ranges	0.0.0.0/0
Protocols and ports	  Specified protocols and ports

For tcp, specify port 80.

Make sure to include the /0 in the Source IP ranges to specify all networks.





gcloud compute instances create test-vm --machine-type=n1-standard-1 --subnet=default --zone=us-central1-a


student_04_da35526ce4ff@cloudshell:~ (qwiklabs-gcp-04-fdc559c28044)$ gcloud compute instances create test-vm --machine-type=n1-standard-1 --subnet=default --zone=us-central1-a
Created [https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-04-fdc559c28044/zones/us-central1-a/instances/test-vm].
NAME     ZONE           MACHINE_TYPE   PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP     STATUS
test-vm  us-central1-a  n1-standard-1               10.128.0.4   34.122.177.146  RUNNING
student_04_da35526ce4ff@cloudshell:~ (qwiklabs-gcp-04-fdc559c28044)$






student-04-da35526ce4ff@test-vm:~$ curl 10.128.0.2
<!DOCTYPE html>
<html>
<head>
<title>Welcome to blue server!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>


student-04-da35526ce4ff@test-vm:~$ curl 10.128.0.3
<!DOCTYPE html>
<html>
<head>
<title>Welcome to green server!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
student-04-da35526ce4ff@test-vm:~$



student-04-da35526ce4ff@test-vm:~$ curl 35.226.228.79
<!DOCTYPE html>
<html>
<head>
<title>Welcome to blue server!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>


student-04-da35526ce4ff@test-vm:~$ curl 104.198.165.55
curl: (7) Failed to connect to 104.198.165.55 port 80: Connection timed out
student-04-da35526ce4ff@test-vm:~$
student-04-da35526ce4ff@test-vm:~$

