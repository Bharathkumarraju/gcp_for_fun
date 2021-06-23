using System;
using System.Linq;
using Pulumi;
using Pulumi.Gcp.CloudFunctions;
using Pulumi.Gcp.Storage;

class SignupFunction
{
    public SignupFunction()
    {
        var database = new Database();

        var functionCodeBucket = new Bucket("function-code");
        var cloudFunctionFileArchive = new FileArchive("../backend/handleSignup");
        var functionCodeObject = new BucketObject("function-code", new BucketObjectArgs {
            Bucket = functionCodeBucket.Name,
            Source = cloudFunctionFileArchive,
            Name = "source"
        });
        var serviceAccount = new Pulumi.Gcp.ServiceAccount.Account("handle-signup-account", new Pulumi.Gcp.ServiceAccount.AccountArgs {
            AccountId = "handle-signup-account",
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
            Name = sanitizedHash.Apply(hash => $"handle-signup-{hash}"),
            ServiceAccountEmail = serviceAccount.Email,
            EnvironmentVariables = new InputMap<object> {
                ["DB_USER"] = database.DbUsername,
                ["DB_PASS"] = database.DbPassword,
                ["DB_NAME"] = database.DatabaseName,
                ["CLOUD_SQL_CONNECTION_NAME"] = database.InstanceConnectionName,
            },

        });

        new FunctionIamBinding("allow-all", new FunctionIamBindingArgs {
            Members = "allUsers",
            Role = "roles/cloudfunctions.invoker",
            CloudFunction = function.Name,
            Region = "us-central1",
        });

        var memberId = serviceAccount.Email.Apply(x => $"serviceAccount:{x}");

        new FunctionIamBinding("service-agent", new FunctionIamBindingArgs {
            Members = memberId,
            Role = "roles/cloudfunctions.serviceAgent",
            CloudFunction = function.Name,
            Region = "us-central1",
        });
        new Pulumi.Gcp.Projects.IAMBinding("service-agent-cloudsql-client", new Pulumi.Gcp.Projects.IAMBindingArgs {
            Members = memberId,
            Role = "roles/cloudsql.client",
        });

        FunctionUrl = function.HttpsTriggerUrl;
    }

    public Output<string> FunctionUrl { get; }
}
