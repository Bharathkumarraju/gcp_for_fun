gcloud compute networks create managementnet --project=qwiklabs-gcp-01-22d3600635fa --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional

gcloud compute networks subnets create managementsubnet-us --project=qwiklabs-gcp-01-22d3600635fa --range=10.130.0.0/20 --network=managementnet --region=us-central1




student_02_b523ad7a5612@cloudshell:~ (qwiklabs-gcp-01-22d3600635fa)$ gcloud compute networks create privatenet --subnet-mode=custom
Created [https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-01-22d3600635fa/global/networks/privatenet].
NAME        SUBNET_MODE  BGP_ROUTING_MODE  IPV4_RANGE  GATEWAY_IPV4
privatenet  CUSTOM       REGIONAL

Instances on this network will not be reachable until firewall rules
are created. As an example, you can allow all internal traffic between
instances as well as SSH, RDP, and ICMP by running:

$ gcloud compute firewall-rules create <FIREWALL_NAME> --network privatenet --allow tcp,udp,icmp --source-ranges <IP_RANGE>
$ gcloud compute firewall-rules create <FIREWALL_NAME> --network privatenet --allow tcp:22,tcp:3389,icmp

student_02_b523ad7a5612@cloudshell:~ (qwiklabs-gcp-01-22d3600635fa)$ gcloud compute networks subnets create privatesubnet-us --network=privatenet --region=us-central1 --range=172.16.0.0/24
Created [https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-01-22d3600635fa/regions/us-central1/subnetworks/privatesubnet-us].
NAME              REGION       NETWORK     RANGE
privatesubnet-us  us-central1  privatenet  172.16.0.0/24
student_02_b523ad7a5612@cloudshell:~ (qwiklabs-gcp-01-22d3600635fa)$ gcloud compute networks subnets create privatesubnet-eu --network=privatenet --region=europe-west3 --range=172.20.0.0/20
Created [https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-01-22d3600635fa/regions/europe-west3/subnetworks/privatesubnet-eu].
NAME              REGION        NETWORK     RANGE
privatesubnet-eu  europe-west3  privatenet  172.20.0.0/20
student_02_b523ad7a5612@cloudshell:~ (qwiklabs-gcp-01-22d3600635fa)$ gcloud compute networks list
NAME           SUBNET_MODE  BGP_ROUTING_MODE  IPV4_RANGE  GATEWAY_IPV4
default        AUTO         REGIONAL
managementnet  CUSTOM       REGIONAL
mynetwork      AUTO         REGIONAL
privatenet     CUSTOM       REGIONAL
student_02_b523ad7a5612@cloudshell:~ (qwiklabs-gcp-01-22d3600635fa)$






student_02_b523ad7a5612@cloudshell:~ (qwiklabs-gcp-01-22d3600635fa)$ gcloud compute networks subnets list --sort-by=NETWORK
NAME                 REGION                   NETWORK        RANGE
default              us-central1              default        10.128.0.0/20
default              europe-west1             default        10.132.0.0/20
default              us-west1                 default        10.138.0.0/20
default              asia-east1               default        10.140.0.0/20
default              us-east1                 default        10.142.0.0/20
default              asia-northeast1          default        10.146.0.0/20
default              asia-southeast1          default        10.148.0.0/20
default              us-east4                 default        10.150.0.0/20
default              australia-southeast1     default        10.152.0.0/20
default              europe-west2             default        10.154.0.0/20
default              europe-west3             default        10.156.0.0/20
default              southamerica-east1       default        10.158.0.0/20
default              asia-south1              default        10.160.0.0/20
default              northamerica-northeast1  default        10.162.0.0/20
default              europe-west4             default        10.164.0.0/20
default              europe-north1            default        10.166.0.0/20
default              us-west2                 default        10.168.0.0/20
default              asia-east2               default        10.170.0.0/20
default              europe-west6             default        10.172.0.0/20
default              asia-northeast2          default        10.174.0.0/20
default              asia-northeast3          default        10.178.0.0/20
default              us-west3                 default        10.180.0.0/20
default              us-west4                 default        10.182.0.0/20
default              asia-southeast2          default        10.184.0.0/20
default              europe-central2          default        10.186.0.0/20
default              asia-south2              default        10.190.0.0/20
default              australia-southeast2     default        10.192.0.0/20
managementsubnet-us  us-central1              managementnet  10.130.0.0/20
mynetwork            us-central1              mynetwork      10.128.0.0/20
mynetwork            europe-west1             mynetwork      10.132.0.0/20
mynetwork            us-west1                 mynetwork      10.138.0.0/20
mynetwork            asia-east1               mynetwork      10.140.0.0/20
mynetwork            us-east1                 mynetwork      10.142.0.0/20
mynetwork            asia-northeast1          mynetwork      10.146.0.0/20
mynetwork            asia-southeast1          mynetwork      10.148.0.0/20
mynetwork            us-east4                 mynetwork      10.150.0.0/20
mynetwork            australia-southeast1     mynetwork      10.152.0.0/20
mynetwork            europe-west2             mynetwork      10.154.0.0/20
mynetwork            europe-west3             mynetwork      10.156.0.0/20
mynetwork            southamerica-east1       mynetwork      10.158.0.0/20
mynetwork            asia-south1              mynetwork      10.160.0.0/20
mynetwork            northamerica-northeast1  mynetwork      10.162.0.0/20
mynetwork            europe-west4             mynetwork      10.164.0.0/20
mynetwork            europe-north1            mynetwork      10.166.0.0/20
mynetwork            us-west2                 mynetwork      10.168.0.0/20
mynetwork            asia-east2               mynetwork      10.170.0.0/20
mynetwork            europe-west6             mynetwork      10.172.0.0/20
mynetwork            asia-northeast2          mynetwork      10.174.0.0/20
mynetwork            asia-northeast3          mynetwork      10.178.0.0/20
mynetwork            us-west3                 mynetwork      10.180.0.0/20
mynetwork            us-west4                 mynetwork      10.182.0.0/20
mynetwork            asia-southeast2          mynetwork      10.184.0.0/20
mynetwork            europe-central2          mynetwork      10.186.0.0/20
privatesubnet-us     us-central1              privatenet     172.16.0.0/24
privatesubnet-eu     europe-west3             privatenet     172.20.0.0/20
student_02_b523ad7a5612@cloudshell:~ (qwiklabs-gcp-01-22d3600635fa)$



gcloud compute --project=qwiklabs-gcp-01-22d3600635fa firewall-rules create managementnet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=managementnet --action=ALLOW --rules=tcp:22,tcp:3389,icmp --source-ranges=0.0.0.0/0


student_02_b523ad7a5612@cloudshell:~ (qwiklabs-gcp-01-22d3600635fa)$ gcloud compute firewall-rules create privatenet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=privatenet --action=ALLOW --rules=icmp,tcp:22,tcp:3389 --source-ranges=0.0.0.0/0
Creating firewall...⠹Created [https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-01-22d3600635fa/global/firewalls/privatenet-allow-icmp-ssh-rdp].
Creating firewall...done.
NAME                           NETWORK     DIRECTION  PRIORITY  ALLOW                 DENY  DISABLED
privatenet-allow-icmp-ssh-rdp  privatenet  INGRESS    1000      icmp,tcp:22,tcp:3389        False
student_02_b523ad7a5612@cloudshell:~ (qwiklabs-gcp-01-22d3600635fa)$



student_02_b523ad7a5612@cloudshell:~ (qwiklabs-gcp-01-22d3600635fa)$ gcloud compute firewall-rules list --sort-by=NETWORK
NAME                              NETWORK        DIRECTION  PRIORITY  ALLOW                         DENY  DISABLED
default-allow-icmp                default        INGRESS    65534     icmp                                False
default-allow-internal            default        INGRESS    65534     tcp:0-65535,udp:0-65535,icmp        False
default-allow-rdp                 default        INGRESS    65534     tcp:3389                            False
default-allow-ssh                 default        INGRESS    65534     tcp:22                              False
managementnet-allow-icmp-ssh-rdp  managementnet  INGRESS    1000      tcp:22,tcp:3389,icmp                False
mynetwork-allow-icmp              mynetwork      INGRESS    1000      icmp                                False
mynetwork-allow-rdp               mynetwork      INGRESS    1000      tcp:3389                            False
mynetwork-allow-ssh               mynetwork      INGRESS    1000      tcp:22                              False
privatenet-allow-icmp-ssh-rdp     privatenet     INGRESS    1000      icmp,tcp:22,tcp:3389                False

To show all fields of the firewall, please show in JSON format: --format=json
To show all fields in table format, please see the examples in --help.

student_02_b523ad7a5612@cloudshell:~ (qwiklabs-gcp-01-22d3600635fa)$




student_02_b523ad7a5612@cloudshell:~ (qwiklabs-gcp-01-22d3600635fa)$ gcloud compute instances create privatenet-us-vm --zone=us-central1-c --machine-type=n1-standard-1 --subnet=privatesubnet-us
Created [https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-01-22d3600635fa/zones/us-central1-c/instances/privatenet-us-vm].
NAME              ZONE           MACHINE_TYPE   PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP     STATUS
privatenet-us-vm  us-central1-c  n1-standard-1               172.16.0.2   35.202.223.240  RUNNING
student_02_b523ad7a5612@cloudshell:~ (qwiklabs-gcp-01-22d3600635fa)$ gcloud compute instances list --sort-by=ZONE
NAME                 ZONE            MACHINE_TYPE   PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP     STATUS
mynet-eu-vm          europe-west2-a  n1-standard-1               10.154.0.2   34.105.145.58   RUNNING
managementnet-us-vm  us-central1-c   n1-standard-1               10.130.0.2   34.70.242.190   RUNNING
mynet-us-vm          us-central1-c   n1-standard-1               10.128.0.2   34.66.32.176    RUNNING
privatenet-us-vm     us-central1-c   n1-standard-1               172.16.0.2   35.202.223.240  RUNNING
student_02_b523ad7a5612@cloudshell:~ (qwiklabs-gcp-01-22d3600635fa)$





student-02-b523ad7a5612@vm-appliance:~$ sudo ifconfig
ens4: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1460
        inet 172.16.0.3  netmask 255.255.255.255  broadcast 172.16.0.3
        inet6 fe80::4001:acff:fe10:3  prefixlen 64  scopeid 0x20<link>
        ether 42:01:ac:10:00:03  txqueuelen 1000  (Ethernet)
        RX packets 802  bytes 188044 (183.6 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 749  bytes 82333 (80.4 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ens5: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1460
        inet 10.130.0.3  netmask 255.255.255.255  broadcast 10.130.0.3
        inet6 fe80::4001:aff:fe82:3  prefixlen 64  scopeid 0x20<link>
        ether 42:01:0a:82:00:03  txqueuelen 1000  (Ethernet)
        RX packets 4  bytes 2308 (2.2 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 16  bytes 2304 (2.2 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ens6: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1460
        inet 10.128.0.3  netmask 255.255.255.255  broadcast 10.128.0.3
        inet6 fe80::4001:aff:fe80:3  prefixlen 64  scopeid 0x20<link>
        ether 42:01:0a:80:00:03  txqueuelen 1000  (Ethernet)
        RX packets 6  bytes 2420 (2.3 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 16  bytes 2310 (2.2 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 36  bytes 5796 (5.6 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 36  bytes 5796 (5.6 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

student-02-b523ad7a5612@vm-appliance:~$



You can ping privatenet-us-vm by its name because VPC networks have an internal DNS service that allows you to address instances by their DNS names instead of their internal IP addresses.
When an internal DNS query is made with the instance hostname, it resolves to the primary interface (nic0) of the instance. Therefore, this only works for privatenet-us-vm in this case.


student-02-b523ad7a5612@vm-appliance:~$ ip route
default via 172.16.0.1 dev ens4
10.128.0.0/20 via 10.128.0.1 dev ens6
10.128.0.1 dev ens6 scope link
10.130.0.0/20 via 10.130.0.1 dev ens5
10.130.0.1 dev ens5 scope link
172.16.0.0/24 via 172.16.0.1 dev ens4
172.16.0.1 dev ens4 scope link
student-02-b523ad7a5612@vm-appliance:~$



The primary interface eth0 gets the default route (default via 172.16.0.1 dev eth0),
and all three interfaces, eth0, eth1, and eth2, get routes for their respective subnets.
 Because the subnet of mynet-eu-vm (10.132.0.0/20) is not included in this routing table,
the ping to that instance leaves vm-appliance on eth0 (which is on a different VPC network).
You could change this behavior by configuring policy routing as documented https://cloud.google.com/vpc/docs/create-use-multiple-interfaces#configuring_policy_routing






