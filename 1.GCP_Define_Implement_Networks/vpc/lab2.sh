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

