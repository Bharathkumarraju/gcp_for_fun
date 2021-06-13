student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ cd ~/hello-cloudbuild-app
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ sed -i 's/Hello World/Hello Cloud Build/g' app.py
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ sed -i 's/Hello World/Hello Cloud Build/g' test_app.py
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ git add app.py test_app.py
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ git commit -m "Hello Cloud Build"
[master 31341a2] Hello Cloud Build 2 files changed, 2 insertions(+), 2 deletions(-)
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$ git push google masterEnumerating objects: 7, done.
Counting objects: 100% (7/7), done.
Delta compression using up to 2 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 376 bytes | 376.00 KiB/s, done.
Total 4 (delta 3), reused 0 (delta 0)
remote: Resolving deltas: 100% (3/3)
To https://source.developers.google.com/p/qwiklabs-gcp-02-d9ddfe7472a6/r/hello-cloudbuild-app
   43d9988..31341a2  master -> master
student_00_46bc792a0038@cloudshell:~/hello-cloudbuild-app (qwiklabs-gcp-02-d9ddfe7472a6)$
