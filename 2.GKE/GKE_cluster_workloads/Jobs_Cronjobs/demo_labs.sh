student_01_3539ad58124f@cloudshell:~ (qwiklabs-gcp-01-e255f4d822b0)$ export my_zone=us-central1-a
student_01_3539ad58124f@cloudshell:~ (qwiklabs-gcp-01-e255f4d822b0)$ export my_cluster=standard-cluster-1
student_01_3539ad58124f@cloudshell:~ (qwiklabs-gcp-01-e255f4d822b0)$ source <(kubectl completion bash)
student_01_3539ad58124f@cloudshell:~ (qwiklabs-gcp-01-e255f4d822b0)$ gcloud container clusters $my_cluster --zone $my_zone
student_01_3539ad58124f@cloudshell:~ (qwiklabs-gcp-01-e255f4d822b0)$ gcloud container clusters get-credentials  $my_cluster --zone $my_zone
Fetching cluster endpoint and auth data.
kubeconfig entry generated for standard-cluster-1.
student_01_3539ad58124f@cloudshell:~ (qwiklabs-gcp-01-e255f4d822b0)$ git clone https://github.com/GoogleCloudPlatform/training-data-analyst
Cloning into 'training-data-analyst'...
remote: Enumerating objects: 48994, done.
remote: Counting objects: 100% (1349/1349), done.
remote: Compressing objects: 100% (549/549), done.
remote: Total 48994 (delta 725), reused 1249 (delta 682), pack-reused 47645
Receiving objects: 100% (48994/48994), 575.52 MiB | 18.59 MiB/s, done.
Resolving deltas: 100% (30593/30593), done.
Checking out files: 100% (10001/10001), done.
student_01_3539ad58124f@cloudshell:~ (qwiklabs-gcp-01-e255f4d822b0)$


student_01_3539ad58124f@cloudshell:~ (qwiklabs-gcp-01-e255f4d822b0)$ ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
student_01_3539ad58124f@cloudshell:~ (qwiklabs-gcp-01-e255f4d822b0)$  cd ~/ak8s/Jobs_CronJobs
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ ls
example-cronjob.yaml  example-job.yaml
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ kubectl apply -f example-job.yaml
job.batch/example-job created
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ kubectl describe job example-job
Name:           example-job
Namespace:      default
Selector:       controller-uid=f987d131-b152-4a6d-a2cc-cbd85126c12f
Labels:         controller-uid=f987d131-b152-4a6d-a2cc-cbd85126c12f
                job-name=example-job
Annotations:    <none>
Parallelism:    1
Completions:    1
Start Time:     Thu, 10 Jun 2021 17:50:17 +0000
Completed At:   Thu, 10 Jun 2021 17:50:41 +0000
Duration:       24s
Pods Statuses:  0 Running / 1 Succeeded / 0 Failed
Pod Template:
  Labels:  controller-uid=f987d131-b152-4a6d-a2cc-cbd85126c12f
           job-name=example-job
  Containers:
   pi:
    Image:      perl
    Port:       <none>
    Host Port:  <none>
    Command:
      perl
    Args:
      -Mbignum=bpi
      -wle
      print bpi(2000)
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Events:
  Type    Reason            Age   From            Message
  ----    ------            ----  ----            -------
  Normal  SuccessfulCreate  40s   job-controller  Created pod: example-job-697rm
  Normal  Completed         16s   job-controller  Job completed
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$


student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ kubectl get pods -o wide
NAME                READY   STATUS      RESTARTS   AGE   IP         NODE                                                NOMINATED NODE   READINESS GATES
example-job-697rm   0/1     Completed   0          65s   10.8.1.8   gke-standard-cluster-1-default-pool-90e9ff1b-f440   <none>           <none>
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$

student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ kubectl get all
NAME                    READY   STATUS      RESTARTS   AGE
pod/example-job-697rm   0/1     Completed   0          100s

NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.11.240.1   <none>        443/TCP   8m2s

NAME                    COMPLETIONS   DURATION   AGE
job.batch/example-job   1/1           24s        102s
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ kubectl get jobs -o wide
NAME          COMPLETIONS   DURATION   AGE    CONTAINERS   IMAGES   SELECTOR
example-job   1/1           24s        117s   pi           perl     controller-uid=f987d131-b152-4a6d-a2cc-cbd85126c12f
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$



student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ kubectl logs example-job-697rm
3.1415926535897932384626433832795028841971693993751058209749445923078164062862089986280348253421170679821480865132823066470938446095505822317253594081284811174502841027019385211055596446229489549303819644288109756659334461284756482337867831652712019091456485669234603486104543266482133936072602491412737245870066063155881748815209209628292540917153643678925903600113305305488204665213841469519415116094330572703657595919530921861173819326117931051185480744623799627495673518857527248912279381830119491298336733624406566430860213949463952247371907021798609437027705392171762931767523846748184676694051320005681271452635608277857713427577896091736371787214684409012249534301465495853710507922796892589235420199561121290219608640344181598136297747713099605187072113499999983729780499510597317328160963185950244594553469083026425223082533446850352619311881710100031378387528865875332083814206171776691473035982534904287554687311595628638823537875937519577818577805321712268066130019278766111959092164201989380952572010654858632788659361533818279682303019520353018529689957736225994138912497217752834791315155748572424541506959508295331168617278558890750983817546374649393192550604009277016711390098488240128583616035637076601047101819429555961989467678374494482553797747268471040475346462080466842590694912933136770289891521047521620569660240580381501935112533824300355876402474964732639141992726042699227967823547816360093417216412199245863150302861829745557067498385054945885869269956909272107975093029553211653449872027559602364806654991198818347977535663698074265425278625518184175746728909777727938000816470600161452491921732172147723501414419735685481613611573525521334757418494684385233239073941433345477624168625189835694855620992192221842725502542568876717904946016534668049886272327917860857843838279679766814541009538837863609506800642251252051173929848960841284886269456042419652850222106611863067442786220391949450471237137869609563643719172874677646575739624138908658326459958133904780275901
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ kubectl delete job example-job
job.batch "example-job" deleted
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ kubectl get all
NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.11.240.1   <none>        443/TCP   9m27s
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$


kubectl apply -f example-cronjob.yaml



student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ kubectl apply -f example-cronjob.yaml
cronjob.batch/hello created
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ kubectl get jobs
No resources found in default namespace.
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ kubectl get all
NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.11.240.1   <none>        443/TCP   10m

NAME                  SCHEDULE      SUSPEND   ACTIVE   LAST SCHEDULE   AGE
cronjob.batch/hello   */1 * * * *   False     0        <none>          18s
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ kubectl get cronjobs
NAME    SCHEDULE      SUSPEND   ACTIVE   LAST SCHEDULE   AGE
hello   */1 * * * *   False     0        <none>          31s
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ kubectl describe cronjob hello
Name:                          hello
Namespace:                     default
Labels:                        <none>
Annotations:                   <none>
Schedule:                      */1 * * * *
Concurrency Policy:            AllowSuspend:                       FalseSuccessful Job History Limit:  3Failed Job History Limit:      1Starting Deadline Seconds:     <unset>Selector:                      <unset>Parallelism:                   <unset>Completions:                   <unset>Pod Template:
  Labels:  <none>
  Containers:
   hello:
    Image:      busybox
    Port:       <none>
    Host Port:  <none>
    Args:
      /bin/sh
      -c
      date; echo "Hello, World!"
    Environment:     <none>
    Mounts:          <none>
  Volumes:           <none>
Last Schedule Time:  Thu, 10 Jun 2021 17:55:00 +0000
Active Jobs:         <none>
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$



student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ kubectl get pods
NAME                     READY   STATUS      RESTARTS   AGE
hello-1623347700-fdxt2   0/1     Completed   0          114s
hello-1623347760-6277v   0/1     Completed   0          54s
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ kubectl get all
NAME                         READY   STATUS      RESTARTS   AGE
pod/hello-1623347700-fdxt2   0/1     Completed   0          2m2s
pod/hello-1623347760-6277v   0/1     Completed   0          62s
pod/hello-1623347820-r79gx   0/1     Completed   0          2s

NAME                 TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.11.240.1   <none>        443/TCP   13m

NAME                         COMPLETIONS   DURATION   AGE
job.batch/hello-1623347700   1/1           2s         2m4s
job.batch/hello-1623347760   1/1           2s         64s
job.batch/hello-1623347820   1/1           2s         4s

NAME                  SCHEDULE      SUSPEND   ACTIVE   LAST SCHEDULE   AGE
cronjob.batch/hello   */1 * * * *   False     1        13s             2m38s
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ kubectl get jobs
NAME               COMPLETIONS   DURATION   AGE
hello-1623347700   1/1           2s         2m28s
hello-1623347760   1/1           2s         88s
hello-1623347820   1/1           2s         28s
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ kubectl get cronjobs
NAME    SCHEDULE      SUSPEND   ACTIVE   LAST SCHEDULE   AGE
hello   */1 * * * *   False     0        46s             3m11s
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ kubectl describe cronjob hello
Name:                          hello
Namespace:                     default
Labels:                        <none>
Annotations:                   <none>
Schedule:                      */1 * * * *
Concurrency Policy:            Allow
Suspend:                       False
Successful Job History Limit:  3
Failed Job History Limit:      1
Starting Deadline Seconds:     <unset>
Selector:                      <unset>
Parallelism:                   <unset>
Completions:                   <unset>
Pod Template:
  Labels:  <none>
  Containers:
   hello:
    Image:      busybox
    Port:       <none>
    Host Port:  <none>
    Args:
      /bin/sh
      -c
      date; echo "Hello, World!"
    Environment:     <none>
    Mounts:          <none>
  Volumes:           <none>
Last Schedule Time:  Thu, 10 Jun 2021 17:57:00 +0000
Active Jobs:         <none>
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$



student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$ kubectl delete cronjob hello
cronjob.batch "hello" deleted
student_01_3539ad58124f@cloudshell:~/ak8s/Jobs_CronJobs (qwiklabs-gcp-01-e255f4d822b0)$

