student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ kubectl exec -it  wordpress-5fd7755c6c-rhbhz -c cloudsql-proxy -- sh
/ $ cat /etc/*release*
3.5.2
NAME="Alpine Linux"
ID=alpine
VERSION_ID=3.5.2
PRETTY_NAME="Alpine Linux v3.5"
HOME_URL="http://alpinelinux.org"
BUG_REPORT_URL="http://bugs.alpinelinux.org"
/ $ ps aux | grep cloudsql
    1 daemon     0:00 /cloud_sql_proxy -instances=qwiklabs-gcp-01-8b06e7044b5a:us-central1:sql-instance=tcp:3306 -credential_file=/secrets/cloudsql/key.json
   20 daemon     0:00 grep cloudsql
/ $




student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ kubectl exec -it  wordpress-5fd7755c6c-rhbhz -c cloudsql-proxy -- sh
/ $ cat /etc/*release*
3.5.2
NAME="Alpine Linux"
ID=alpine
VERSION_ID=3.5.2
PRETTY_NAME="Alpine Linux v3.5"
HOME_URL="http://alpinelinux.org"
BUG_REPORT_URL="http://bugs.alpinelinux.org"
/ $ ps aux | grep cloudsql
    1 daemon     0:00 /cloud_sql_proxy -instances=qwiklabs-gcp-01-8b06e7044b5a:us-central1:sql-instance=tcp:3306 -credential_file=/secrets/cloudsql/key.json
   20 daemon     0:00 grep cloudsql
/ $ exit
student_01_4bb38c26a39e@cloudshell:~/ak8s/Cloud_SQL (qwiklabs-gcp-01-8b06e7044b5a)$ kubectl exec -it  wordpress-5fd7755c6c-rhbhz -c web -- sh
# cat /etc/*release*
PRETTY_NAME="Debian GNU/Linux 9 (stretch)"
NAME="Debian GNU/Linux"
VERSION_ID="9"
VERSION="9 (stretch)"
VERSION_CODENAME=stretch
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
# ps aux | grep wordpress
root         108  0.0  0.0  11112   936 pts/0    S+   06:45   0:00 grep wordpress
# ps aux
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.0  0.7 392544 30004 ?        Ss   06:33   0:00 apache2 -DFOREGROUND
www-data      80  0.0  1.0 472248 43548 ?        S    06:34   0:00 apache2 -DFOREGROUND
www-data      81  0.0  0.7 393308 30816 ?        S    06:34   0:00 apache2 -DFOREGROUND
www-data      82  0.0  0.2 392820  9648 ?        S    06:34   0:00 apache2 -DFOREGROUND
www-data      83  0.0  0.2 392788  9572 ?        S    06:34   0:00 apache2 -DFOREGROUND
www-data      84  0.0  0.7 393080 31820 ?        S    06:34   0:00 apache2 -DFOREGROUND
www-data      85  0.0  0.2 392788  9504 ?        S    06:35   0:00 apache2 -DFOREGROUND
www-data      90  0.0  0.9 393340 38076 ?        S    06:35   0:00 apache2 -DFOREGROUND
www-data      91  0.0  0.8 393740 33248 ?        S    06:35   0:00 apache2 -DFOREGROUND
www-data      92  0.0  1.0 472064 42076 ?        S    06:35   0:00 apache2 -DFOREGROUND
www-data      93  0.0  0.8 397420 33252 ?        S    06:35   0:00 apache2 -DFOREGROUND
root         100  0.0  0.0   4280   772 pts/0    Ss   06:45   0:00 sh
root         109  0.0  0.0  36636  2908 pts/0    R+   06:46   0:00 ps aux
#
