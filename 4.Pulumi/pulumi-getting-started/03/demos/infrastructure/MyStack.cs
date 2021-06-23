using System.IO;
using Pulumi;
using Pulumi.Gcp.Storage;

class MyStack : Stack
{
    public MyStack()
    {
        var signupFunction = new SignupFunction();

        var frontendConfigJson = signupFunction.FunctionUrl.Apply(url => $@"{{
            ""backendUrl"": ""{url}""
        }}");

        // Create a GCP resource (Storage Bucket)
        var bucket = new Bucket("frontend-files");

        var configBucketObject = new BucketObject("frontend-config", new BucketObjectArgs {
            Bucket = bucket.Name,
            Content = frontendConfigJson,
            Name = "config.json"
        });

        var frontendBuildOutputFolder = "../frontend/build";
        var files = Directory.GetFiles(frontendBuildOutputFolder, "*", SearchOption.AllDirectories);

        foreach(var file in files)
        {
            var filename = Path.GetRelativePath(frontendBuildOutputFolder, file).Replace("\\", "/");
            new BucketObject(filename, new BucketObjectArgs {
                Bucket = bucket.Name,
                Source = new FileAsset(file),
                Name = filename,
                ContentType = filename.EndsWith(".css") ? "text/css; charset=utf-8" : ""
            });
        }

        var allowAllBinding = new BucketIAMBinding("allowAll", new BucketIAMBindingArgs {
            Bucket = bucket.Name,
            Role = "roles/storage.objectViewer",
            Members = new[] { "allUsers" }
        });

        // Export the DNS name of the bucket
        this.BucketName = bucket.Url;
    }

    [Output]
    public Output<string> BucketName { get; set; }
}
