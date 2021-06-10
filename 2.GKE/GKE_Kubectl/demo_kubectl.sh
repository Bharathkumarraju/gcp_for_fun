kubectl get pods

kubectl describe pod posname

kubectl exec demo -- env
kubectl exec demo -- ps aux
kubectl exec demo -- cat /proc/1/mounts
kubectl exec demo -- ls /

kubectl exec -it demo -- /bin/bash

kubectl logs demo



