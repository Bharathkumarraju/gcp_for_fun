allow-ssh

In google type: iap connections comes from which ip range google cloud

IAP connections come from a specific set of IP addresses (35.235.240.0/20).

gcloud compute ssh vm-internal --zone asia-southeast1-b --tunnel-through-iap



bharath@cloudshell:~ (learngcp-316009)$ gsutil mb -l asia gs://bharathsrajustest
Creating gs://bharathsrajustest/...
bharath@cloudshell:~ (learngcp-316009)$

bharath@cloudshell:~ (learngcp-316009)$ gsutil cp test.json gs://bharathsrajustest
Copying file://test.json [Content-Type=application/json]...
/ [1 files][ 15.1 KiB/ 15.1 KiB]
Operation completed over 1 objects/15.1 KiB.
bharath@cloudshell:~ (learngcp-316009)$




gcloud compute instances set-service-account private-vm --zone asia-southeast1-a  --scopes 'https://www.googleapis.com/auth/cloud-platform'