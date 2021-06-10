A note about Deployments and ReplicaSets:
--------------------------------------------------->

The example nginx Deployment you saw in the previous video was simplified. In practice, you
would launch a Deployment object to manage your desired three nginx Pods, just as the video
described. Note, though, that the Deployment object would create a ReplicaSet object to
manage the Pods. The diagram in the video leaves out this detail.

You will work with Deployment objects directly much more often than ReplicaSet objects.
But its still helpful to know about ReplicaSets, so that you can better understand how Deployments
work.

For example, one capability of a Deployment is to allow a rolling upgrade of the Pods it manages.
To perform the upgrade, the Deployment object will create a second ReplicaSet object, and then increase the number of (upgraded) Pods in the second ReplicaSet while it
decreases the number in the first ReplicaSet.

