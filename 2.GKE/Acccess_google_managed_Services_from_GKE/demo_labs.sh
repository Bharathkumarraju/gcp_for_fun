Create a Cloud SQL instance and database for Wordpress

Create credentials and Kubernetes Secrets for application authentication

Configure a Deployment with a Wordpress image to use SQL Proxy

Install SQL Proxy as a sidecar container and use it to provide SSL access to a CloudSQL instance external to the GKE Cluster



student_01_4bb38c26a39e@cloudshell:~ (qwiklabs-gcp-01-8b06e7044b5a)$ export my_zone=us-central1-a
student_01_4bb38c26a39e@cloudshell:~ (qwiklabs-gcp-01-8b06e7044b5a)$ export my_cluster=standard-cluster-1
student_01_4bb38c26a39e@cloudshell:~ (qwiklabs-gcp-01-8b06e7044b5a)$ source <(kubectl completion bash)
student_01_4bb38c26a39e@cloudshell:~ (qwiklabs-gcp-01-8b06e7044b5a)$ gcloud container clusters get-credentials $my_cluster --zone $my_zone
Fetching cluster endpoint and auth data.
kubeconfig entry generated for standard-cluster-1.
student_01_4bb38c26a39e@cloudshell:~ (qwiklabs-gcp-01-8b06e7044b5a)$ git clone https://github.com/GoogleCloudPlatform/training-data-analyst
Cloning into 'training-data-analyst'...
remote: Enumerating objects: 48994, done.
remote: Counting objects: 100% (1349/1349), done.
remote: Compressing objects: 100% (549/549), done.
remote: Total 48994 (delta 725), reused 1249 (delta 682), pack-reused 47645
Receiving objects: 100% (48994/48994), 575.52 MiB | 18.58 MiB/s, done.
Resolving deltas: 100% (30593/30593), done.
Checking out files: 100% (10001/10001), done.
student_01_4bb38c26a39e@cloudshell:~ (qwiklabs-gcp-01-8b06e7044b5a)$ gcloud sql instances create sql-instance --tier=db-n1-standard-2 --region=us-central1
Creating Cloud SQL instance...done.
Created [https://sqladmin.googleapis.com/sql/v1beta4/projects/qwiklabs-gcp-01-8b06e7044b5a/instances/sql-instance].
NAME          DATABASE_VERSION  LOCATION       TIER              PRIMARY_ADDRESS  PRIVATE_ADDRESS  STATUS
sql-instance  MYSQL_5_7         us-central1-f  db-n1-standard-2  34.67.37.131     -                RUNNABLE
student_01_4bb38c26a39e@cloudshell:~ (qwiklabs-gcp-01-8b06e7044b5a)$
student_01_4bb38c26a39e@cloudshell:~ (qwiklabs-gcp-01-8b06e7044b5a)$



student_01_4bb38c26a39e@cloudshell:~ (qwiklabs-gcp-01-8b06e7044b5a)$ ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
student_01_4bb38c26a39e@cloudshell:~ (qwiklabs-gcp-01-8b06e7044b5a)$ cd ~/ak8s/Cloud_SQL/
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ ls
sql-proxy.yaml  wordpress-service.yaml
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$




student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ export SQL_NAME=qwiklabs-gcp-01-8b06e7044b5a:us-central1:sql-instance


student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ gcloud sql connect sql-instance
Allowlisting your IP for incoming connection for 5 minutes...⠧

Allowlisting your IP for incoming connection for 5 minutes...done.
Connecting to database with SQL user [root].Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 72
Server version: 5.7.33-google (Google)

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql>
mysql> create database wordpress;
Query OK, 1 row affected (0.20 sec)

mysql> use wordpress;
Database changed
mysql> show tables;
Empty set (0.20 sec)

mysql> exit;
Bye
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$


student_01_4bb38c26a39e@cloudshell:~ (qwiklabs-gcp-01-8b06e7044b5a)$ mv qwiklabs-gcp-01-8b06e7044b5a-63d4b6c8a619.json credentials.json
student_01_4bb38c26a39e@cloudshell:~ (qwiklabs-gcp-01-8b06e7044b5a)$ kubectl create secret generic sql-credentials \
>    --from-literal=username=sqluser\
>    --from-literal=password=sqlpassword
secret/sql-credentials created
student_01_4bb38c26a39e@cloudshell:~ (qwiklabs-gcp-01-8b06e7044b5a)$



student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ mv ~/credentials.json .
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ kubectl create secret generic google-credentials\
>    --from-file=key.json=credentials.json
secret/google-credentials created
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ kubectl get secrets
NAME                  TYPE                                  DATA   AGE
default-token-vc2dq   kubernetes.io/service-account-token   3      23m
google-credentials    Opaque                                1      18s
sql-credentials       Opaque                                2      112s
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$



student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ kubectl apply -f sql-proxy.yaml
deployment.apps/wordpress created
service/wordpress-service created
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ kubectl get deployment wordpress
NAME        READY   UP-TO-DATE   AVAILABLE   AGE
wordpress   0/1     1            0           6s
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ kubectl get deployment wordpress
NAME        READY   UP-TO-DATE   AVAILABLE   AGE
wordpress   0/1     1            0           9s
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ kubectl get deployment wordpress
NAME        READY   UP-TO-DATE   AVAILABLE   AGE
wordpress   0/1     1            0           13s
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ kubectl get services
NAME                TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
kubernetes          ClusterIP      10.11.240.1     <none>        443/TCP        28m
wordpress-service   LoadBalancer   10.11.251.118   <pending>     80:31018/TCP   21s
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ kubectl get deployment wordpress
NAME        READY   UP-TO-DATE   AVAILABLE   AGE
wordpress   1/1     1            1           26s
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$


student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ kubectl get services
NAME                TYPE           CLUSTER-IP      EXTERNAL-IP     PORT(S)        AGE
kubernetes          ClusterIP      10.11.240.1     <none>          443/TCP        29m
wordpress-service   LoadBalancer   10.11.251.118   34.122.226.57   80:31018/TCP   77s
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$

username: 0Aywmh8bGP31VAG(#v
password: bharath



student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ gcloud sql connect sql-instance
Allowlisting your IP for incoming connection for 5 minutes...done.
Connecting to database with SQL user [root].Enter password:
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 187
Server version: 5.7.33-google (Google)

Copyright (c) 2000, 2021, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> use wordpress;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> show tables;
+-----------------------+
| Tables_in_wordpress   |
+-----------------------+
| wp_commentmeta        |
| wp_comments           |
| wp_links              |
| wp_options            |
| wp_postmeta           |
| wp_posts              |
| wp_term_relationships |
| wp_term_taxonomy      |
| wp_termmeta           |
| wp_terms              |
| wp_usermeta           |
| wp_users              |
+-----------------------+
12 rows in set (0.20 sec)

mysql>


mysql>
mysql> select * from wp_users;
+----+------------+------------------------------------+---------------+-----------------------+----------+---------------------+---------------------+-------------+--------------+
| ID | user_login | user_pass                          | user_nicename | user_email            | user_url | user_registered     | user_activation_key | user_status | display_name |
+----+------------+------------------------------------+---------------+-----------------------+----------+---------------------+---------------------+-------------+--------------+
|  1 | bharath    | $P$BYPv.dM.w0b75h5OU57QTdaRiGsLQu1 | bharath       | bhrth.dsra1@gmail.com |          | 2021-06-13 06:36:09 |                     |           0 | bharath      |
+----+------------+------------------------------------+---------------+-----------------------+----------+---------------------+---------------------+-------------+--------------+
1 row in set (0.20 sec)

mysql>






