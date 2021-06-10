student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ kubectl apply -f service-nginx.yaml
service/nginx created
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ kubectl get service
NAME         TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)           AGE
kubernetes   ClusterIP      10.11.240.1     <none>        443/TCP           23m
nginx        LoadBalancer   10.11.252.174   <pending>     60000:30195/TCP   11s
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$


student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ kubectl get service nginx
NAME    TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)           AGE
nginx   LoadBalancer   10.11.252.174   34.136.4.151   60000:30195/TCP   72s
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$



student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ kubectl apply -f nginx-canary.yaml
deployment.apps/nginx-canary created
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ kubectl get deployments
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-canary       1/1     1            1           17s
nginx-deployment   3/3     3            3           17m
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$

kubectl scale --replicas=0 deployment nginx-deployment


student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ kubectl scale --replicas=0 deployment nginx-deployment
deployment.apps/nginx-deployment scaled
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$ kubectl get deployments
NAME               READY   UP-TO-DATE   AVAILABLE   AGE
nginx-canary       1/1     1            1           2m28s
nginx-deployment   0/0     0            0           19m
student_03_e616be0ba762@cloudshell:~/ak8s/Deployments (qwiklabs-gcp-03-64ef984edf9e)$



