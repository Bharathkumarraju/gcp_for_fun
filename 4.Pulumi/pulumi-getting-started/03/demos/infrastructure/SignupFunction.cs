using System;
using System.Linq;
using Pulumi;
using Pulumi.Gcp.CloudFunctions;
using Pulumi.Gcp.Storage;

class SignupFunction
{
    public SignupFunction()
    {
        var functionCodeBucket = new Bucket("function-code");
        var cloudFunctionFileArchive = new FileArchive("../backend/handleSignup");
        var functionCodeObject = new BucketObject("function-code", new BucketObjectArgs {
            Bucket = functionCodeBucket.Name,
            Source = cloudFunctionFileArchive,
            Name = "source"
        });

        var sanitizedHash = functionCodeObject.Md5hash
            .Apply(x => string.Join("", Convert.FromBase64String(x).Select(x => $"{x:x2}")));

        var function = new Function("handle-signup", new FunctionArgs {
            EntryPoint = "handleSignup",
            SourceArchiveBucket = functionCodeBucket.Name,
            SourceArchiveObject = functionCodeObject.OutputName,
            Runtime = "nodejs10",
            Region = "us-central1",
            TriggerHttp = true,
            Name = sanitizedHash.Apply(hash => $"handle-signup-{hash}")
        });

        new FunctionIamBinding("allow-all", new FunctionIamBindingArgs {
            Members = "allUsers",
            Role = "roles/cloudfunctions.invoker",
            CloudFunction = function.Name,
            Region = "us-central1",
        });

        FunctionUrl = function.HttpsTriggerUrl;
    }

    public Output<string> FunctionUrl { get; }
}
