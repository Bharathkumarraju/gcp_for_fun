student_04_1d7d2f48968f@cloudshell:~ (qwiklabs-gcp-04-7c288c13cbef)$ cd ~/ak8s/GKE_Services/
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ ls
dns-demo.yaml  hello-ingress.yaml  hello-lb-svc.yaml  hello-nodeport-svc.yaml  hello-svc.yaml  hello-v1.yaml  hello-v2.yaml



student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ kubectl create -f hello-v1.yaml
deployment.apps/hello-v1 created
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ kubectl apply -f hello-svc.yaml
service/hello-svc created
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ kubectl get service hello-svc
NAME        TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
hello-svc   ClusterIP   10.11.242.227   <none>        80/TCP    33s
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$


student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ kubectl get service hello-svc
NAME        TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
hello-svc   ClusterIP   10.11.242.227   <none>        80/TCP    33s
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ curl hello-svc.default.svc.cluster.local
curl: (6) Could not resolve host: hello-svc.default.svc.cluster.local
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$


root@dns-demo-1:/# apt-get install -y curl
Reading package lists... Done
Building dependency tree
Reading state information... Done
curl is already the newest version (7.64.0-4+deb10u2).
0 upgraded, 0 newly installed, 0 to remove and 2 not upgraded.
root@dns-demo-1:/#
root@dns-demo-1:/# curl hello-svc.default.svc.cluster.local
Hello, world!
Version: 1.0.0
Hostname: hello-v1-695896495d-bczl7
root@dns-demo-1:/#

###################### Change service type to NodePort ######################################################

student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ kubectl apply -f hello-nodeport-svc.yaml
service/hello-svc configured
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ kubectl get service hello-svc
NAME        TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
hello-svc   NodePort   10.11.242.227   <none>        80:30100/TCP   5m3s
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$


student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ curl hello-svc.default.svc.cluster.local
curl: (6) Could not resolve host: hello-svc.default.svc.cluster.local
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$

root@dns-demo-1:/# curl hello-svc.default.svc.cluster.local
Hello, world!
Version: 1.0.0
Hostname: hello-v1-695896495d-bczl7
root@dns-demo-1:/#

student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ kubectl get services -o wide
NAME           TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)        AGE     SELECTOR
dns-demo       ClusterIP      None            <none>          1234/TCP       30m     name=dns-demo
hello-lb-svc   LoadBalancer   10.11.241.39    34.68.114.122   80:32188/TCP   2m30s   name=hello-v2
hello-svc      NodePort       10.11.242.227   <none>          80:30100/TCP   18m     name=hello-v1
kubernetes     ClusterIP      10.11.240.1     <none>          443/TCP        45m     <none>
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$

root@dns-demo-1:/# curl hello-lb-svc.default.svc.cluster.local
Hello, world!
Version: 2.0.0
Hostname: hello-v2-569cc4bf64-zhvk4
root@dns-demo-1:/#


root@dns-demo-1:/# curl 34.68.114.122
Hello, world!
Version: 2.0.0
Hostname: hello-v2-569cc4bf64-zhvk4
root@dns-demo-1:/#







