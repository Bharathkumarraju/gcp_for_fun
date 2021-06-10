git clone https://github.com/googlecodelabs/orchestrate-with-kubernetes.git


sudo apt-get update
sudo apt-get install nginx

gcloud compute scp index.html first-vm:index.nginx-debian.html --zone=us-central1-c


student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$ gcloud compute scp index.html first-vm:index.nginx-debian.html --zone=us-central1-c
WARNING: The private SSH key file for gcloud does not exist.
WARNING: The public SSH key file for gcloud does not exist.
WARNING: You do not have an SSH key for gcloud.
WARNING: SSH keygen will be executed to generate a key.
This tool needs to create the directory
[/home/student_02_cbb04b1269cd/.ssh] before being able to generate SSH
 keys.
Do you want to continue (Y/n)?  Y

Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/student_02_cbb04b1269cd/.ssh/google_compute_engine.
Your public key has been saved in /home/student_02_cbb04b1269cd/.ssh/google_compute_engine.pub.
The key fingerprint is:
SHA256:A9x2SStgNfgo9asguHwjCmqAFJCmzoT3l5efjyLfKYQ student_02_cbb04b1269cd@cs-624862243010-default-default-b4q28
The keys randomart image is:
+---[RSA 2048]----+
|o.    ooo .      |
|.o   ooo o o     |
|+ .  .o++ +      |
|oo. . .ooo       |
|*o . . oSo       |
|+o. o E =.       |
|+. . o + . .     |
|++ o  o o.oo     |
|= o .  o.o+..    |
+----[SHA256]-----+

Warning: Permanently added 'compute.8213195710555592766' (ECDSA) to the list of known hosts.
index.html                                                                                                                                                                                                                                                        100%  152     0.8KB/s   00:00
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$
student_02_cbb04b1269cd@cloudshell:~ (qwiklabs-gcp-02-9a1190ec1578)$


sudo cp index.nginx-debian.html /var/www/html

