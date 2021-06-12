student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ kubectl apply -f hello-ingress.yaml
Warning: extensions/v1beta1 Ingress is deprecated in v1.14+, unavailable in v1.22+; use networking.k8s.io/v1 Ingress
ingress.extensions/hello-ingress created
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$



student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ kubectl describe ingress hello-ingress
Name:             hello-ingress
Namespace:        default
Address:          34.102.164.246
Default backend:  default-http-backend:80 (10.8.1.8:8080)
Rules:
  Host        Path  Backends
  ----        ----  --------
  *
              /v1   hello-svc:80 (10.8.0.6:8080,10.8.0.7:8080,10.8.1.9:8080)
              /v2   hello-lb-svc:80 (10.8.0.8:8080,10.8.0.9:8080,10.8.1.10:8080)
Annotations:  ingress.kubernetes.io/backends:
                {"k8s-be-30100--3d8c63561d567e1a":"Unknown","k8s-be-30864--3d8c63561d567e1a":"HEALTHY","k8s-be-32188--3d8c63561d567e1a":"Unknown"}
              ingress.kubernetes.io/forwarding-rule: k8s2-fr-uwowpjwo-default-hello-ingress-qr1jnicu
              ingress.kubernetes.io/target-proxy: k8s2-tp-uwowpjwo-default-hello-ingress-qr1jnicu
              ingress.kubernetes.io/url-map: k8s2-um-uwowpjwo-default-hello-ingress-qr1jnicu
              kubernetes.io/ingress.global-static-ip-name: global-ingress
              nginx.ingress.kubernetes.io/rewrite-target: /
Events:
  Type    Reason     Age                  From                     Message
  ----    ------     ----                 ----                     -------
  Normal  Sync       80s                  loadbalancer-controller  UrlMap "k8s2-um-uwowpjwo-default-hello-ingress-qr1jnicu" created
  Normal  Sync       78s                  loadbalancer-controller  TargetProxy "k8s2-tp-uwowpjwo-default-hello-ingress-qr1jnicu" created
  Normal  Sync       69s                  loadbalancer-controller  ForwardingRule "k8s2-fr-uwowpjwo-default-hello-ingress-qr1jnicu" created
  Normal  IPChanged  69s                  loadbalancer-controller  IP is now 34.102.164.246
  Normal  Sync       68s (x4 over 3m13s)  loadbalancer-controller  Scheduled for sync
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$




student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ curl http://34.102.164.246/v1
Hello, world!
Version: 1.0.0
Hostname: hello-v1-695896495d-bczl7
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$ curl http://34.102.164.246/v2
Hello, world!
Version: 2.0.0
Hostname: hello-v2-569cc4bf64-dpk5q
student_04_1d7d2f48968f@cloudshell:~/ak8s/GKE_Services (qwiklabs-gcp-04-7c288c13cbef)$

