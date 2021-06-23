using Pulumi;
using Pulumi.Gcp.Compute;
using Pulumi.Gcp.Compute.Inputs;

class DnsHosting
{
    public DnsHosting(Input<string> bucketName)
    {
        var backendBucket = new BackendBucket("lb-backend-bucket", new BackendBucketArgs{
            BucketName = bucketName
        });

        var cert = new ManagedSslCertificate("public-cert", new ManagedSslCertificateArgs {
            Managed = new ManagedSslCertificateManagedArgs {
                Domains = {
                    "dev.carvedrocktraining.com."
                }
            }
        });
        var urlMap = new URLMap("url-map", new URLMapArgs {
            DefaultService = backendBucket.Id,
        });

        var backend = new TargetHttpsProxy("backend-proxy", new TargetHttpsProxyArgs {
            SslCertificates = {
                cert.Name
            },
            UrlMap = urlMap.Name,
        });

        var forwardingRule = new GlobalForwardingRule("http-forwarding-rule", new GlobalForwardingRuleArgs {
            Target = backend.Id,
            LoadBalancingScheme = "EXTERNAL",
            PortRange = "443",
        });

        var dnsRecord = new Pulumi.Gcp.Dns.RecordSet("public-dns", new Pulumi.Gcp.Dns.RecordSetArgs {
            ManagedZone = "carved-rock-training-dns-zone",
            Rrdatas = new InputList<string> {
                forwardingRule.IpAddress
            },
            Type = "A",
            Name = "dev.carvedrocktraining.com.",
            Ttl = 300,
        });
    }
}