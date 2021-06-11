Create a cluster with autoscaling enabled:
------------------------------------------------->
gcloud container clusters create [CLUSTER_NAME] --num-nodes 30 \
--enable-autoscaling --min-nodes 15 --max-nodes 50 [ --zone COMPUTE_ZONE]

Add a node pool with autoscaling enabled:
--------------------------------------------->
gcloud container node-pools create [POOL_NAME] --cluster [CLUSTER_NAME] --enable-autoscaling --min-nodes 15 \
--max-nodes 50 [--zone COMPUTE_ZONE]

Enable autoscaling for an existing node pool:
------------------------------------------------>
gcloud container clusters update [CLUSTER_NAME] --enable-autoscaling \
--min-nodes 1 --max-nodes 10 --zone [COMPUTE_ZONE] --node-pool [POOL_NAME]

disable autoscaling for an existing node pool:
------------------------------------------------>
gcloud container clusters update [CLUSTER_NAME] --no-enable-autoscaling \
--node-pool [POOL_NAME] --zone [COMPUTE_ZONE] --project [PROJECT_ID]
