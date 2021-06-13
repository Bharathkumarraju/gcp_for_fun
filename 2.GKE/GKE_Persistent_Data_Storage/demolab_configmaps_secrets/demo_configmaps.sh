student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$  kubectl create configmap sample --from-literal=message=hello
configmap/sample created
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl describe configmaps sample
Name:         sample
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
message:
----
hello
Events:  <none>
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$


student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ cat sample2.properties
message2=world
foo=bar
meaningOfLife=42
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl create configmap sample2 --from-file=sample2.properties
configmap/sample2 created
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl describe configmaps sample2
Name:         sample2
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
sample2.properties:
----
message2=world
foo=bar
meaningOfLife=42

Events:  <none>
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$


student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl apply -f config-map-3.yaml
configmap/sample3 created
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl describe configmaps sample3
Name:         sample3
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
airspeed:
----
africanOrEuropean
meme:
----
testAllTheThings
Events:  <none>
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$


student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl apply -f pubsub-configmap.yaml
deployment.apps/pubsub unchanged
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ kube
kubectl  kubectx  kubens
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
pubsub-7d68d64b5-qjsnw   1/1     Running   0          5m49s
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl exec -it pubsub-7d68d64b5-qjsnw -- sh
# printenv
KUBERNETES_SERVICE_PORT=443
KUBERNETES_PORT=tcp://10.11.240.1:443
HOSTNAME=pubsub-7d68d64b5-qjsnw
PYTHON_PIP_VERSION=21.1.2
HOME=/root
GPG_KEY=E3FF2839C048B25C084DEBE9B26995E310250568
GOOGLE_APPLICATION_CREDENTIALS=/var/secrets/google/key.json
PYTHON_GET_PIP_URL=https://github.com/pypa/get-pip/raw/936e08ce004d0b2fae8952c50f7ccce1bc578ce5/public/get-pip.py
TERM=xterm
KUBERNETES_PORT_443_TCP_ADDR=10.11.240.1
PATH=/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
KUBERNETES_PORT_443_TCP_PORT=443
KUBERNETES_PORT_443_TCP_PROTO=tcp
LANG=C.UTF-8
PYTHON_VERSION=3.9.5
INSIGHTS=testAllTheThings
KUBERNETES_SERVICE_PORT_HTTPS=443
KUBERNETES_PORT_443_TCP=tcp://10.11.240.1:443
KUBERNETES_SERVICE_HOST=10.11.240.1
PWD=/
PYTHON_GET_PIP_SHA256=8890955d56a8262348470a76dc432825f61a84a54e2985a86cd520f656a6e220
#



student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl get pods
NAME                      READY   STATUS    RESTARTS   AGE
pubsub-54b5858884-shsv8   1/1     Running   0          47s
student_00_57988528be37@cloudshell:~/ak8s/Secrets (qwiklabs-gcp-04-d9c0e8c68ead)$ kubectl exec -it pubsub-54b5858884-shsv8 -- sh
# df -PH
Filesystem      Size  Used Avail Use% Mounted on
overlay         102G  3.3G   99G   4% /
tmpfs            68M     0   68M   0% /dev
tmpfs           2.1G     0  2.1G   0% /sys/fs/cgroup
/dev/sda1       102G  3.3G   99G   4% /etc/hosts
shm              68M     0   68M   0% /dev/shm
tmpfs           2.1G  4.1k  2.1G   1% /var/secrets/google
tmpfs           2.1G   13k  2.1G   1% /run/secrets/kubernetes.io/serviceaccount
tmpfs           2.1G     0  2.1G   0% /proc/acpi
tmpfs           2.1G     0  2.1G   0% /proc/scsi
tmpfs           2.1G     0  2.1G   0% /sys/firmware
# cd /etc/config
# ls
airspeed  meme
# cat   meme
testAllTheThings
#
#
# cat airspeed
africanOrEuropean
#
#



