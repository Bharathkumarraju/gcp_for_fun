what if you want to run web server on the pod which has only SSD disks...

then the nodes must match all the labels present under the nodeSelector field.


node selctors are used only when the pods are scheduling.
