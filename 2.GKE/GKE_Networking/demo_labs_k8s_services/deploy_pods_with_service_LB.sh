Reserve two external static IP addresses
1. region static address
2. global static address

student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ kubectl create -f hello-v2.yaml
deployment.apps/hello-v2 created
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ kubectl get deployments
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
hello-v1   3/3     3            3           14m
hello-v2   3/3     3            3           13s
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$



Define service types in the manifest

student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ gcloud compute addresses describe regional-loadbalancer --region us-central1 --format json | jq -r '.address'
34.68.114.122
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$




student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ export STATIC_LB=$(gcloud compute addresses describe regional-loadbalancer --region us-central1 --format json | jq -r '.address')
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ sed -i "s/10\.10\.10\.10/$STATIC_LB/g" hello-lb-svc.yaml


student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ cat hello-lb-svc.yaml
apiVersion: v1
kind: Service
metadata:
  name: hello-lb-svc
spec:
  type: LoadBalancer
  loadBalancerIP: 34.68.114.122
  selector:
    name: hello-v2
  ports:
  - protocol: TCP
    port: 80
    targetPort: 8080
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$


student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ kubectl apply -f hello-lb-svc.yaml
service/hello-lb-svc created
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ kubectl get services
NAME           TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
dns-demo       ClusterIP      None            <none>        1234/TCP       27m
hello-lb-svc   LoadBalancer   10.11.241.39    <pending>     80:32188/TCP   9s
hello-svc      NodePort       10.11.242.227   <none>        80:30100/TCP   16m
kubernetes     ClusterIP      10.11.240.1     <none>        443/TCP        42m
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$

student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ kubectl get services -o wide
NAME           TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)        AGE     SELECTOR
dns-demo       ClusterIP      None            <none>          1234/TCP       30m     name=dns-demo
hello-lb-svc   LoadBalancer   10.11.241.39    34.68.114.122   80:32188/TCP   2m30s   name=hello-v2
hello-svc      NodePort       10.11.242.227   <none>          80:30100/TCP   18m     name=hello-v1
kubernetes     ClusterIP      10.11.240.1     <none>          443/TCP        45m     <none>
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$


student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ curl hello-lb-svc.default.svc.cluster.local
curl: (6) Could not resolve host: hello-lb-svc.default.svc.cluster.local
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$

The connection should fail because that service name is not exposed outside of the cluster.
This occurs because the external IP address is not registered with this hostname..

student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ curl 34.68.114.122
Hello, world!
Version: 2.0.0
Hostname: hello-v2-569cc4bf64-66dbp
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$




