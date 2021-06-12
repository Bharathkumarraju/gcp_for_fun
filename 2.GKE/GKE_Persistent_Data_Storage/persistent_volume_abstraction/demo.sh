ReadWriteOnce mounts to single node.
ReadOnlyMany mounts to many nodes.

ReadWriteMany mounts to many nodes.



We can use persistent volumes for deployments i.e. pods that is deployment replicas(i.e. set of identical pods)
We can use these deployments for stateless applications.

Deployment replicas can share an existing persistent volumes using ReadOnlyMany (or) ReadWriteMany access modes.
ReadWriteMany access mode can only used storage type that supported such as NFS systems.


The other mode called ReadWriteOnce is not recommended for deployments because the replicas need to attach and reattach the persistent volumes dynamically.
If a first pod need to detach itself, the second pod needs to be attached first, however the second pod cannot attach because the first pod is already attached.
This creates a deadlock so neither pod can make progress.

StatefulSets resolves this deadlock. Whenever your application needs to maintain state in persistent volumes managing it with statefulset rather than a deployment is the way to go.




