Task 3. Rotate IP Address and Credentials
You perform IP and credential rotation on your cluster. It is a secure practice to do so regularly to reduce credential lifetimes.
While there are separate commands to rotate the serving IP and credentials, rotating credentials additionally rotates the IP as well.

In Cloud Shell, execute the following command:

gcloud container clusters update $my_cluster --zone $my_zone --start-credential-rotation

Enter Y to continue.
Leave the Cloud Shell open until the operation is complete.
After the command completes in the Cloud Shell in this lab the cluster will probably initiate the process to upgrade all of the nodes.
Performing a credential rotation causes GKE to upgrade all node pools to the closest supported node version. For more information, refer to Upgrading a Container Cluster.

Note: You need to wait for about up to 15 minutes for your cluster.
If you are monitoring this in the Google Cloud Console you may need to refresh the page to see the node upgrade progress notifications.

node_upgrade.png

To view the active operations on the cluster execute the following command:

gcloud container operations list
You will see that there is a running process of type UPGRADE_NODES.

Note: This can take upto 10 minutes to begin.
If after 15 minutes you can not see a process type of `UPGRADE_NODES`, you need to run the following command

gcloud container clusters upgrade $my_cluster --zone $my_zone --node-pool=default-pool

This will force the nodes to start the upgrade process. This step is to avoid unnecessary waiting times in this lab.

To save the operations task ID for the node upgrade operation to an environment variable execute the following command:

export UPGRADE_ID=$(gcloud container operations list --filter="operationType=UPGRADE_NODES and status=RUNNING" --format='value(name)')
To monitor the status of the node upgrade operation execute the following command:
gcloud container operations wait $UPGRADE_ID --zone=$my_zone
This command will report the node upgrade process until all nodes have been upgraded. When the operation has finished you will see output similar to the following:

Sample output ( Do not copy)

Waiting for operation-1567076865370-fd0f5914 to complete...done.
endTime: '2019-08-29T11:22:10.190373855Z'
name: operation-1567076865370-fd0f5914
operationType: UPGRADE_NODES
selfLink: https...
startTime: '2019-08-29T11:07:45.370167092Z'
status: DONE
targetLink: https...
zone: us-central1-a
Note: These processes automatically update the kubeconfig entry for the current user. You must update the kubeconfig file on any other system that uses kubectl or API
 to access the master before completing the rotation process to avoid losing access.

The cluster master now temporarily serves the new IP address in addition to the original address. If you initiate a credential rotation,
but do not complete it, GKE automatically completes the rotation after seven days.

To complete the credential and IP rotation tasks execute the following command:

gcloud container clusters update $my_cluster --zone $my_zone --complete-credential-rotation
Enter Y to continue.