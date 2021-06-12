student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ kubectl apply -f dns-demo.yaml
service/dns-demo created
pod/dns-demo-1 created
pod/dns-demo-2 created
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$

student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ kubectl get all
NAME             READY   STATUS    RESTARTS   AGE
pod/dns-demo-1   1/1     Running   0          12s
pod/dns-demo-2   1/1     Running   0          11s

NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
service/dns-demo     ClusterIP   None          <none>        1234/TCP   13s
service/kubernetes   ClusterIP   10.11.240.1   <none>        443/TCP    15m
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$


tudent_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ kubectl exec -it dns-demo-1 -- /bin/bash
root@dns-demo-1:/# apt-get update
Get:1 http://deb.debian.org/debian buster InRelease [121 kB]
Get:2 http://security.debian.org/debian-security buster/updates InRelease [65.4 kB]
Get:3 http://deb.debian.org/debian buster-updates InRelease [51.9 kB]
Get:4 http://security.debian.org/debian-security buster/updates/main amd64 Packages [292 kB]
Get:5 http://deb.debian.org/debian buster/main amd64 Packages [7907 kB]
Get:6 http://deb.debian.org/debian buster-updates/main amd64 Packages [10.9 kB]
Fetched 8449 kB in 2s (4527 kB/s)
Reading package lists... Done
root@dns-demo-1:/# apt-get install -y iputils-ping
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following additional packages will be installed:
  libcap2 libcap2-bin libpam-cap
The following NEW packages will be installed:
  iputils-ping libcap2 libcap2-bin libpam-cap
0 upgraded, 4 newly installed, 0 to remove and 2 not upgraded.
Need to get 104 kB of archives.
After this operation, 319 kB of additional disk space will be used.
Get:1 http://deb.debian.org/debian buster/main amd64 libcap2 amd64 1:2.25-2 [17.6 kB]
Get:2 http://deb.debian.org/debian buster/main amd64 iputils-ping amd64 3:20180629-2+deb10u2 [43.4 kB]
Get:3 http://deb.debian.org/debian buster/main amd64 libcap2-bin amd64 1:2.25-2 [28.8 kB]
Get:4 http://deb.debian.org/debian buster/main amd64 libpam-cap amd64 1:2.25-2 [14.3 kB]
Fetched 104 kB in 0s (739 kB/s)
debconf: delaying package configuration, since apt-utils is not installed
Selecting previously unselected package libcap2:amd64.
(Reading database ... 7638 files and directories currently installed.)
Preparing to unpack .../libcap2_1%3a2.25-2_amd64.deb ...
Unpacking libcap2:amd64 (1:2.25-2) ...
Selecting previously unselected package iputils-ping.
Preparing to unpack .../iputils-ping_3%3a20180629-2+deb10u2_amd64.deb ...
Unpacking iputils-ping (3:20180629-2+deb10u2) ...
Selecting previously unselected package libcap2-bin.
Preparing to unpack .../libcap2-bin_1%3a2.25-2_amd64.deb ...
Unpacking libcap2-bin (1:2.25-2) ...
Selecting previously unselected package libpam-cap:amd64.
Preparing to unpack .../libpam-cap_1%3a2.25-2_amd64.deb ...
Unpacking libpam-cap:amd64 (1:2.25-2) ...
Setting up libcap2:amd64 (1:2.25-2) ...
Setting up libcap2-bin (1:2.25-2) ...
Setting up libpam-cap:amd64 (1:2.25-2) ...
debconf: unable to initialize frontend: Dialog
debconf: (No usable dialog-like program is installed, so the dialog based frontend cannot be used. at /usr/share/perl5/Debconf/FrontEnd/Dialog.pm line 76.)
debconf: falling back to frontend: Readline
debconf: unable to initialize frontend: Readline
debconf: (Cant locate Term/ReadLine.pm in @INC (you may need to install the Term::ReadLine module) (@INC contains: /etc/perl /usr/local/lib/x86_64-linux-gnu/perl/5.28.1 /usr/local/share/perl/5.28.1 /usr/lib/x86_64-linux-gnu/perl5/5.28 /usr/share/perl5 /usr/lib/x86_64-linux-gnu/perl/5.28 /usr/share/perl/5.28 /usr/local/lib/site_perl /usr/lib/x86_64-linux-gnu/perl-base) at /usr/share/perl5/Debconf/FrontEnd/Readline.pm line 7.)
debconf: falling back to frontend: Teletype
Setting up iputils-ping (3:20180629-2+deb10u2) ...
Processing triggers for libc-bin (2.28-10) ...
root@dns-demo-1:/#





student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ kubectl get all
NAME             READY   STATUS    RESTARTS   AGE
pod/dns-demo-1   1/1     Running   0          5m41s
pod/dns-demo-2   1/1     Running   0          5m40s

NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)    AGE
service/dns-demo     ClusterIP   None          <none>        1234/TCP   5m42s
service/kubernetes   ClusterIP   10.11.240.1   <none>        443/TCP    20m
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ kubectl exec -it dns-demo-1 -- /bin/bash
root@dns-demo-1:/# ping dns-demo-2.dns-demo.default.svc.cluster.local
PING dns-demo-2.dns-demo.default.svc.cluster.local (10.8.0.5) 56(84) bytes of data.
64 bytes from dns-demo-2.dns-demo.default.svc.cluster.local (10.8.0.5): icmp_seq=1 ttl=63 time=0.085 ms
64 bytes from dns-demo-2.dns-demo.default.svc.cluster.local (10.8.0.5): icmp_seq=2 ttl=63 time=0.066 ms
64 bytes from dns-demo-2.dns-demo.default.svc.cluster.local (10.8.0.5): icmp_seq=3 ttl=63 time=0.039 ms
^C
--- dns-demo-2.dns-demo.default.svc.cluster.local ping statistics ---
9 packets transmitted, 9 received, 0% packet loss, time 157ms
rtt min/avg/max/mdev = 0.039/0.059/0.085/0.015 ms
root@dns-demo-1:/# ping dns-demo.default.svc.cluster.local
PING dns-demo.default.svc.cluster.local (10.8.0.4) 56(84) bytes of data.
64 bytes from dns-demo-1.dns-demo.default.svc.cluster.local (10.8.0.4): icmp_seq=1 ttl=64 time=0.020 ms
64 bytes from dns-demo-1.dns-demo.default.svc.cluster.local (10.8.0.4): icmp_seq=2 ttl=64 time=0.041 ms
64 bytes from dns-demo-1.dns-demo.default.svc.cluster.local (10.8.0.4): icmp_seq=3 ttl=64 time=0.033 ms
^C
--- dns-demo.default.svc.cluster.local ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 85ms
rtt min/avg/max/mdev = 0.020/0.031/0.041/0.009 ms
root@dns-demo-1:/#


