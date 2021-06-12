student_01_a1c78d6badfb@cloudshell:~ (qwiklabs-gcp-01-95d5588bf27e)$ gcloud container clusters describe private-cluster --region us-central1-a
addonsConfig:
  dnsCacheConfig: {}
  gcePersistentDiskCsiDriverConfig:
    enabled: true
  horizontalPodAutoscaling: {}
  httpLoadBalancing: {}
  kubernetesDashboard:
    disabled: true
  networkPolicyConfig:
    disabled: true
authenticatorGroupsConfig: {}
autoscaling: {}
clusterIpv4Cidr: 10.32.0.0/14
createTime: '2021-06-11T23:32:32+00:00'
currentMasterVersion: 1.19.9-gke.1900
currentNodeCount: 2
currentNodeVersion: 1.19.9-gke.1900
databaseEncryption:
  state: DECRYPTED
defaultMaxPodsConstraint:
  maxPodsPerNode: '110'
endpoint: 23.251.153.130
id: ad473ee3ea7f4ba48afec88fb4430a22b0d648a41a3c4c5e88110f259ff8c1b3
initialClusterVersion: 1.19.9-gke.1900
instanceGroupUrls:
- https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-01-95d5588bf27e/zones/us-central1-a/instanceGroupManagers/gke-private-cluster-default-pool-766a3273-grp
ipAllocationPolicy:
  clusterIpv4Cidr: 10.32.0.0/14
  clusterIpv4CidrBlock: 10.32.0.0/14
  clusterSecondaryRangeName: gke-private-cluster-pods-ad473ee3
  servicesIpv4Cidr: 10.36.0.0/20
  servicesIpv4CidrBlock: 10.36.0.0/20
  servicesSecondaryRangeName: gke-private-cluster-services-ad473ee3
  useIpAliases: true
labelFingerprint: a9dc16a7
legacyAbac: {}
location: us-central1-a
locations:
- us-central1-a
loggingService: logging.googleapis.com/kubernetes
maintenancePolicy:
  resourceVersion: e3b0c442
masterAuth:
  clusterCaCertificate: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURLakNDQWhLZ0F3SUJBZ0lRYnZwUjlYc0R3dk1tMU54TGdQdmRxakFOQmdrcWhraUc5dzBCQVFzRkFEQXYKTVMwd0t3WURWUVFERXlRMFpqZGtaVGN4Wmkwell6WmtMVFJrTmpjdFlqVXpaaTFtTURaallqazBORE5qTWpjdwpIaGNOTWpFd05qRXhNakl6TWpNeVdoY05Nall3TmpFd01qTXpNak15V2pBdk1TMHdLd1lEVlFRREV5UTBaamRrClpUY3haaTB6WXpaa0xUUmtOamN0WWpVelppMW1NRFpqWWprME5ETmpNamN3Z2dFaU1BMEdDU3FHU0liM0RRRUIKQVFVQUE0SUJEd0F3Z2dFS0FvSUJBUURHZEZSMUxJWm5LalNhN3ZUYm1qUnpTeVc5Sy9jSmdpWGZWMEpGMDIyeAo1bWZHR2UyQ21sMFNkN0RmYUZlb0NRTmlRRldvRnE1YktKOTBOL3VoV005dExHQm5OOE81WFJHT25IMERySmpoCkx4YWZ1L0NtcGNIZEVLVG9DelZnb2dkVGxkWVJNQmIvbVBUQzF6UlhDTVpRY0dWVUNTZzVuazN6ZHpsMmRLbXYKOHliTEUxTEQxMnpCc1ZtYnNTOGl1eG5RL3VBdno2dm5vU0pRcUE0aUZWVmc4QlhCTzVPVW4vQ3B0WWtBWXNPbgpyUDF5ZC8vK21pRGt3bEdvalRWcTREekthY0d2RjFUQVM0NUFpSjFJcEZwZTlNeDAvb3FzMEV6Lysvb1ZPczFiCmJQNTBuMytwVVVWYXlQaTN6TU4yNEJ5d1gxMDk0ZmJkVVZHenBwTEhOeW8xQWdNQkFBR2pRakJBTUE0R0ExVWQKRHdFQi93UUVBd0lDQkRBUEJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJRYWZIa3FIQmRyK3VsUwpCbEk3Z2liajJQSHdRakFOQmdrcWhraUc5dzBCQVFzRkFBT0NBUUVBTzNyUjlFaGZWS201enFpUzZBTkJZbys1CmxTR2UrMSsxSTZnWVlKNnNHbU9xaXVmOFBHUEl1a0QvL0pOdGJQOXBzVGJ3eUVkMU83QnBhR1RRYUZoaEtyWEgKS1h3azlScVlEYXRUdlllNlkwK250UllwR0Uyekc5VnJTWmRZeEVnWW5oOXFZZVlYdFQwcjBqV3ZWUTR4eTkrOQpmOUVkQWFHN3ByUFZHZkpWUWIyZFVBMnpyMXBTU0luR3lCeW1JZ0JGWW5yaFNjYldwMjJNOEFuekdOVlZTZkpoCmlJMFhPTnVSbm1rSC9NSzE2Y3BtUDBTQWg0VVoxbXpYTWxBN0RtZHMzak5IeHhLQ1R4V2psVGFqUTNzTXIwd1oKckIrNGQ1MFBaOWhQZGwrTlhSbG5HMlRXK0R0L1dVY0NhUTFhYkE3WGNrN3IyMEp3UmpVUjdRaWkwOHRMTVE9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
masterAuthorizedNetworksConfig: {}
monitoringService: monitoring.googleapis.com/kubernetes
name: private-cluster
network: default
networkConfig:
  datapathProvider: LEGACY_DATAPATH
  defaultSnatStatus: {}
  network: projects/qwiklabs-gcp-01-95d5588bf27e/global/networks/default
  subnetwork: projects/qwiklabs-gcp-01-95d5588bf27e/regions/us-central1/subnetworks/default
nodeConfig:
  diskSizeGb: 100
  diskType: pd-standard
  imageType: COS_CONTAINERD
  machineType: e2-medium
  metadata:
    disable-legacy-endpoints: 'true'
  oauthScopes:
  - https://www.googleapis.com/auth/devstorage.read_only
  - https://www.googleapis.com/auth/logging.write
  - https://www.googleapis.com/auth/monitoring
  - https://www.googleapis.com/auth/servicecontrol
  - https://www.googleapis.com/auth/service.management.readonly
  - https://www.googleapis.com/auth/trace.append
  serviceAccount: default
  shieldedInstanceConfig:
    enableIntegrityMonitoring: true
nodePools:
- autoscaling: {}
  config:
    diskSizeGb: 100
    diskType: pd-standard
    imageType: COS_CONTAINERD
    machineType: e2-medium
    metadata:
      disable-legacy-endpoints: 'true'
    oauthScopes:
    - https://www.googleapis.com/auth/devstorage.read_only
    - https://www.googleapis.com/auth/logging.write
    - https://www.googleapis.com/auth/monitoring
    - https://www.googleapis.com/auth/servicecontrol
    - https://www.googleapis.com/auth/service.management.readonly
    - https://www.googleapis.com/auth/trace.append
    serviceAccount: default
    shieldedInstanceConfig:
      enableIntegrityMonitoring: true
  initialNodeCount: 2
  instanceGroupUrls:
  - https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-01-95d5588bf27e/zones/us-central1-a/instanceGroupManagers/gke-private-cluster-default-pool-766a3273-grp
  locations:
  - us-central1-a
  management:
    autoRepair: true
    autoUpgrade: true
  maxPodsConstraint:
    maxPodsPerNode: '110'
  name: default-pool
  podIpv4CidrSize: 24
  selfLink: https://container.googleapis.com/v1/projects/qwiklabs-gcp-01-95d5588bf27e/zones/us-central1-a/clusters/private-cluster/nodePools/default-pool
  status: RUNNING
  upgradeSettings:
    maxSurge: 1
  version: 1.19.9-gke.1900
notificationConfig:
  pubsub: {}
privateClusterConfig:
  enablePrivateNodes: true
  masterIpv4CidrBlock: 172.16.0.0/28
  peeringName: gke-n7f87426f78d949addb9-4899-4da8-peer
  privateEndpoint: 172.16.0.2
  publicEndpoint: 23.251.153.130
releaseChannel:
  channel: REGULAR
selfLink: https://container.googleapis.com/v1/projects/qwiklabs-gcp-01-95d5588bf27e/zones/us-central1-a/clusters/private-cluster
servicesIpv4Cidr: 10.36.0.0/20
shieldedNodes:
  enabled: true
status: RUNNING
subnetwork: default
zone: us-central1-a
student_01_a1c78d6badfb@cloudshell:~ (qwiklabs-gcp-01-95d5588bf27e)$
student_01_a1c78d6badfb@cloudshell:~ (qwiklabs-gcp-01-95d5588bf27e)$