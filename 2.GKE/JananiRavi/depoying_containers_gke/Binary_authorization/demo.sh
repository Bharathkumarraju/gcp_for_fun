A deploy-time security control that ensures only trusted containers that have been attested by the proper authority
can be deployed on google kubernetes engine clusters.

this ensures no untrusted containers run on your production environment.

Images used by containers which are running on k8s cluster have to be signed by trusted authorities.These are the attesters.


i.e. signing of the image that created must occur during the development phase.
The validation of this signature occurs during deployment.


the code that goes to production is well-trusted and and well tested.
This seamlessly integrates with container registry vulnerability scanning.

1. Binary authorization API
2. Configure a policy that what images can be deployed on your cluster.
   you can specify default policy to allow or deny images (or)  define cluster specific rules
3. setup a attestor who is trusted authority who is allowed to sign off on the images that will be deployed.
4. The signing of images occurs using a public key and this cab be done by build-and-test system.
5. Attestations are created using the container analysis API available on GCP.


Binary authorization uses the Notes and occurrences from the container analysis API


Use binary authorization tp secure deployments on k8s cluster.
https://codelabs.developers.google.com/codelabs/cloud-binauthz-intro#1

