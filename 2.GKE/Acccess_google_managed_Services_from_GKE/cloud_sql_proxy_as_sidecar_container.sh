
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ kubectl get all
NAME                             READY   STATUS    RESTARTS   AGE
pod/wordpress-5fd7755c6c-rhbhz   2/2     Running   0          6m5s

NAME                        TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)        AGE
service/kubernetes          ClusterIP      10.11.240.1     <none>          443/TCP        33m
service/wordpress-service   LoadBalancer   10.11.251.118   34.122.226.57   80:31018/TCP   6m6s

NAME                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/wordpress   1/1     1            1           6m6s

NAME                                   DESIRED   CURRENT   READY   AGE
replicaset.apps/wordpress-5fd7755c6c   1         1         1       6m6s
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ kubectl get pod wordpress-5fd7755c6c-rhbhz -o wide
NAME                         READY   STATUS    RESTARTS   AGE     IP         NODE                                                NOMINATED NODE   READINESS GATES
wordpress-5fd7755c6c-rhbhz   2/2     Running   0          6m34s   10.8.1.7   gke-standard-cluster-1-default-pool-a5fa1f88-bs7j   <none>           <none>




student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ kubectl describe pod wordpress-5fd7755c6c-rhbhz
Name:         wordpress-5fd7755c6c-rhbhz
Namespace:    default
Priority:     0
Node:         gke-standard-cluster-1-default-pool-a5fa1f88-bs7j/10.128.0.2
Start Time:   Sun, 13 Jun 2021 06:33:41 +0000
Labels:       app=wordpress
              pod-template-hash=5fd7755c6c
Annotations:  <none>
Status:       Running
IP:           10.8.1.7
IPs:
  IP:           10.8.1.7
Controlled By:  ReplicaSet/wordpress-5fd7755c6c
Containers:
  web:
    Container ID:   containerd://a4fdaf2b4fa5296798eae042ba88c925ec3060f27102a0f25e642f1b9b4f981e
    Image:          gcr.io/cloud-marketplace/google/wordpress:5.3
    Image ID:       gcr.io/cloud-marketplace/google/wordpress@sha256:125368cb569cc2f73dbe3e268f52438e7154a7499563a80ac01945b260f8876c
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Sun, 13 Jun 2021 06:33:57 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      WORDPRESS_DB_HOST:      127.0.0.1:3306
      WORDPRESS_DB_USER:      <set to the key 'username' in secret 'sql-credentials'>  Optional: false
      WORDPRESS_DB_PASSWORD:  <set to the key 'password' in secret 'sql-credentials'>  Optional: false
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-vc2dq (ro)
  cloudsql-proxy:
    Container ID:  containerd://1fee0b45b7d9ba5de6b5ceedd21e7811accf158727e74b093da83f47360629f4
    Image:         gcr.io/cloudsql-docker/gce-proxy:1.11
    Image ID:      gcr.io/cloudsql-docker/gce-proxy@sha256:5c690349ad8041e8b21eaa63cb078cf13188568e0bfac3b5a914da3483079e2b
    Port:          <none>
    Host Port:     <none>
    Command:
      /cloud_sql_proxy
      -instances=qwiklabs-gcp-01-8b06e7044b5a:us-central1:sql-instance=tcp:3306
      -credential_file=/secrets/cloudsql/key.json
    State:          Running
      Started:      Sun, 13 Jun 2021 06:33:58 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /secrets/cloudsql from cloudsql-instance-credentials (ro)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-vc2dq (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  cloudsql-instance-credentials:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  google-credentials
    Optional:    false
  default-token-vc2dq:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-vc2dq
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                 node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  6m50s  default-scheduler  Successfully assigned default/wordpress-5fd7755c6c-rhbhz to gke-standard-cluster-1-default-pool-a5fa1f88-bs7j
  Normal  Pulling    6m49s  kubelet            Pulling image "gcr.io/cloud-marketplace/google/wordpress:5.3"
  Normal  Pulled     6m36s  kubelet            Successfully pulled image "gcr.io/cloud-marketplace/google/wordpress:5.3" in 13.351690873s
  Normal  Created    6m34s  kubelet            Created container web
  Normal  Started    6m34s  kubelet            Started container web
  Normal  Pulling    6m34s  kubelet            Pulling image "gcr.io/cloudsql-docker/gce-proxy:1.11"
  Normal  Pulled     6m33s  kubelet            Successfully pulled image "gcr.io/cloudsql-docker/gce-proxy:1.11" in 721.501878ms
  Normal  Created    6m33s  kubelet            Created container cloudsql-proxy
  Normal  Started    6m33s  kubelet            Started container cloudsql-proxy
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$





student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ kubectl logs  wordpress-5fd7755c6c-rhbhz -c cloudsql-proxy
2021/06/13 06:33:58 using credential file for authentication; email=sql-access@qwiklabs-gcp-01-8b06e7044b5a.iam.gserviceaccount.com
2021/06/13 06:33:58 Listening on 127.0.0.1:3306 for qwiklabs-gcp-01-8b06e7044b5a:us-central1:sql-instance
2021/06/13 06:33:58 Ready for new connections
2021/06/13 06:34:00 New connection for "qwiklabs-gcp-01-8b06e7044b5a:us-central1:sql-instance"
2021/06/13 06:34:01 Client closed local connection on 127.0.0.1:3306
2021/06/13 06:35:16 New connection for "qwiklabs-gcp-01-8b06e7044b5a:us-central1:sql-instance"
2021/06/13 06:35:16 Client closed local connection on 127.0.0.1:3306
2021/06/13 06:35:16 New connection for "qwiklabs-gcp-01-8b06e7044b5a:us-central1:sql-instance"
2021/06/13 06:35:17 Client closed local connection on 127.0.0.1:3306
2021/06/13 06:35:21 New connection for "qwiklabs-gcp-01-8b06e7044b5a:us-central1:sql-instance"
2021/06/13 06:35:21 Client closed local connection on 127.0.0.1:3306
2021/06/13 06:36:08 New connection for "qwiklabs-gcp-01-8b06e7044b5a:us-central1:sql-instance"
2021/06/13 06:36:09 New connection for "qwiklabs-gcp-01-8b06e7044b5a:us-central1:sql-instance"
2021/06/13 06:36:09 New connection for "qwiklabs-gcp-01-8b06e7044b5a:us-central1:sql-instance"
2021/06/13 06:36:10 Client closed local connection on 127.0.0.1:3306
2021/06/13 06:36:10 Client closed local connection on 127.0.0.1:3306
2021/06/13 06:36:11 New connection for "qwiklabs-gcp-01-8b06e7044b5a:us-central1:sql-instance"
2021/06/13 06:36:11 Client closed local connection on 127.0.0.1:3306
2021/06/13 06:36:12 Client closed local connection on 127.0.0.1:3306
2021/06/13 06:36:13 New connection for "qwiklabs-gcp-01-8b06e7044b5a:us-central1:sql-instance"
2021/06/13 06:36:13 New connection for "qwiklabs-gcp-01-8b06e7044b5a:us-central1:sql-instance"
2021/06/13 06:36:13 Client closed local connection on 127.0.0.1:3306
2021/06/13 06:36:13 Client closed local connection on 127.0.0.1:3306
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$




student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ kubectl logs  wordpress-5fd7755c6c-rhbhz -c web
WordPress not found in /var/www/html - copying now...
Complete! WordPress has been successfully copied to /var/www/html

Warning: mysqli::__construct(): (HY000/2002): Connection refused in Standard input code on line 22

MySQL Connection Error: (2002) Connection refused
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 10.8.1.7. Set the 'ServerName' directive globally to suppress this message
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 10.8.1.7. Set the 'ServerName' directive globally to suppress this message
[Sun Jun 13 06:34:01.718543 2021] [mpm_prefork:notice] [pid 1] AH00163: Apache/2.4.25 (Debian) PHP/7.3.20 configured -- resuming normal operations
[Sun Jun 13 06:34:01.718718 2021] [core:notice] [pid 1] AH00094: Command line: 'apache2 -D FOREGROUND'
10.128.0.3 - - [13/Jun/2021:06:35:16 +0000] "GET / HTTP/1.1" 302 404 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.128.0.3 - - [13/Jun/2021:06:35:16 +0000] "GET /wp-admin/install.php HTTP/1.1" 200 4521 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.128.0.3 - - [13/Jun/2021:06:35:18 +0000] "GET /wp-includes/css/dashicons.min.css?ver=5.3.2 HTTP/1.1" 200 28819 "http://34.122.226.57/wp-admin/install.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.8.1.1 - - [13/Jun/2021:06:35:18 +0000] "GET /wp-includes/css/buttons.min.css?ver=5.3.2 HTTP/1.1" 200 1796 "http://34.122.226.57/wp-admin/install.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.8.1.1 - - [13/Jun/2021:06:35:18 +0000] "GET /wp-admin/css/l10n.min.css?ver=5.3.2 HTTP/1.1" 200 1022 "http://34.122.226.57/wp-admin/install.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.8.1.1 - - [13/Jun/2021:06:35:18 +0000] "GET /wp-admin/css/install.min.css?ver=5.3.2 HTTP/1.1" 200 2177 "http://34.122.226.57/wp-admin/install.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.128.0.3 - - [13/Jun/2021:06:35:18 +0000] "GET /wp-includes/js/jquery/jquery.js?ver=1.12.4-wp HTTP/1.1" 200 34130 "http://34.122.226.57/wp-admin/install.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.8.1.1 - - [13/Jun/2021:06:35:18 +0000] "GET /wp-admin/css/forms.min.css?ver=5.3.2 HTTP/1.1" 200 6304 "http://34.122.226.57/wp-admin/install.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.8.1.1 - - [13/Jun/2021:06:35:19 +0000] "GET /wp-admin/js/language-chooser.min.js?ver=5.3.2 HTTP/1.1" 200 590 "http://34.122.226.57/wp-admin/install.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.8.1.1 - - [13/Jun/2021:06:35:19 +0000] "GET /wp-includes/js/jquery/jquery-migrate.min.js?ver=1.4.1 HTTP/1.1" 200 4365 "http://34.122.226.57/wp-admin/install.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.128.0.3 - - [13/Jun/2021:06:35:19 +0000] "GET /wp-admin/images/wordpress-logo.svg?ver=20131107 HTTP/1.1" 200 1810 "http://34.122.226.57/wp-admin/css/install.min.css?ver=5.3.2" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.8.1.1 - - [13/Jun/2021:06:35:19 +0000] "GET /wp-admin/images/spinner.gif HTTP/1.1" 200 3941 "http://34.122.226.57/wp-admin/css/install.min.css?ver=5.3.2" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.8.1.1 - - [13/Jun/2021:06:35:19 +0000] "GET /favicon.ico HTTP/1.1" 200 228 "http://34.122.226.57/wp-admin/install.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.8.1.1 - - [13/Jun/2021:06:35:21 +0000] "POST /wp-admin/install.php?step=1 HTTP/1.1" 200 2547 "http://34.122.226.57/wp-admin/install.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.128.0.3 - - [13/Jun/2021:06:35:22 +0000] "GET /wp-includes/js/underscore.min.js?ver=1.8.3 HTTP/1.1" 200 6027 "http://34.122.226.57/wp-admin/install.php?step=1" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.128.0.3 - - [13/Jun/2021:06:35:22 +0000] "GET /wp-admin/js/user-profile.min.js?ver=5.3.2 HTTP/1.1" 200 2426 "http://34.122.226.57/wp-admin/install.php?step=1" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.8.1.1 - - [13/Jun/2021:06:35:22 +0000] "GET /wp-admin/js/password-strength-meter.min.js?ver=5.3.2 HTTP/1.1" 200 801 "http://34.122.226.57/wp-admin/install.php?step=1" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.8.1.1 - - [13/Jun/2021:06:35:22 +0000] "GET /wp-includes/js/wp-util.min.js?ver=5.3.2 HTTP/1.1" 200 914 "http://34.122.226.57/wp-admin/install.php?step=1" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.8.1.1 - - [13/Jun/2021:06:35:22 +0000] "GET /wp-includes/js/zxcvbn-async.min.js?ver=1.0 HTTP/1.1" 200 581 "http://34.122.226.57/wp-admin/install.php?step=1" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.8.1.1 - - [13/Jun/2021:06:35:22 +0000] "GET /favicon.ico HTTP/1.1" 200 228 "http://34.122.226.57/wp-admin/install.php?step=1" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.128.0.3 - - [13/Jun/2021:06:35:22 +0000] "GET /wp-includes/js/zxcvbn.min.js HTTP/1.1" 200 400374 "http://34.122.226.57/wp-admin/install.php?step=1" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
::1 - - [13/Jun/2021:06:35:29 +0000] "OPTIONS * HTTP/1.0" 200 126 "-" "Apache/2.4.25 (Debian) PHP/7.3.20 (internal dummy connection)"
::1 - - [13/Jun/2021:06:35:30 +0000] "OPTIONS * HTTP/1.0" 200 126 "-" "Apache/2.4.25 (Debian) PHP/7.3.20 (internal dummy connection)"
::1 - - [13/Jun/2021:06:35:31 +0000] "OPTIONS * HTTP/1.0" 200 126 "-" "Apache/2.4.25 (Debian) PHP/7.3.20 (internal dummy connection)"
10.8.1.1 - - [13/Jun/2021:06:36:09 +0000] "GET /2021/06/13/hello-world/ HTTP/1.1" 200 8743 "http://34.122.226.57/2021/06/13/hello-world/" "WordPress/5.3.2; http://34.122.226.57"
sh: 1: /usr/sbin/sendmail: not found
10.128.0.3 - - [13/Jun/2021:06:36:08 +0000] "POST /wp-admin/install.php?step=2 HTTP/1.1" 200 1524 "http://34.122.226.57/wp-admin/install.php?step=1" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.128.0.3 - - [13/Jun/2021:06:36:11 +0000] "GET /favicon.ico HTTP/1.1" 200 228 "http://34.122.226.57/wp-admin/install.php?step=2" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.8.1.1 - - [13/Jun/2021:06:36:11 +0000] "POST /wp-admin/upgrade.php?step=upgrade_db HTTP/1.1" 200 286 "http://34.122.226.57/wp-admin/upgrade.php?step=upgrade_db" "WordPress/5.3.2; http://34.122.226.57"
sh: 1: /usr/sbin/sendmail: not found
10.8.1.1 - - [13/Jun/2021:06:36:09 +0000] "POST /wp-cron.php?doing_wp_cron=1623566169.6015210151672363281250 HTTP/1.1" 200 192 "http://34.122.226.57/wp-cron.php?doing_wp_cron=1623566169.6015210151672363281250" "WordPress/5.3.2; http://34.122.226.57"
10.8.1.1 - - [13/Jun/2021:06:36:13 +0000] "POST /wp-cron.php?doing_wp_cron=1623566173.6115450859069824218750 HTTP/1.1" 200 192 "http://34.122.226.57/wp-cron.php?doing_wp_cron=1623566173.6115450859069824218750" "WordPress/5.3.2; http://34.122.226.57"
10.128.0.3 - - [13/Jun/2021:06:36:13 +0000] "GET /wp-login.php HTTP/1.1" 200 2279 "http://34.122.226.57/wp-admin/install.php?step=2" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.128.0.3 - - [13/Jun/2021:06:36:14 +0000] "GET /wp-admin/css/login.min.css?ver=5.3.2 HTTP/1.1" 200 2136 "http://34.122.226.57/wp-login.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
10.128.0.3 - - [13/Jun/2021:06:36:14 +0000] "GET /favicon.ico HTTP/1.1" 200 228 "http://34.122.226.57/wp-login.php" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.72 Safari/537.36"
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$






