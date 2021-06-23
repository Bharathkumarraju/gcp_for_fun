using Pulumi;
using Pulumi.Gcp.Sql;
class Database
{
    public Database()
    {
        var config = new Pulumi.Config();
        var dbServer = new DatabaseInstance("db-server", new DatabaseInstanceArgs {
            DatabaseVersion = "POSTGRES_13",
            DeletionProtection = Deployment.Instance.StackName == "prod",
            Settings = new Pulumi.Gcp.Sql.Inputs.DatabaseInstanceSettingsArgs {
                Tier = config.Get("databaseTier") ?? "db-f1-micro",
                IpConfiguration = new Pulumi.Gcp.Sql.Inputs.DatabaseInstanceSettingsIpConfigurationArgs {
                    AuthorizedNetworks = new [] {
                        // SECURITY WARNING!!! May increase vulnerability
                        new Pulumi.Gcp.Sql.Inputs.DatabaseInstanceSettingsIpConfigurationAuthorizedNetworkArgs {
                            Name = "Cox Internet",
                            Value = "72.192.75.0/24",
                        }
                    }

                }
            },
            Region = "us-central1",
        });

        var password = new Pulumi.Random.RandomPassword("dbuser-password", new Pulumi.Random.RandomPasswordArgs {
            Length = 32,
        });

        var user = new User("cloudfunction-submitter", new UserArgs {
            Name = "cloudfunction-submitter",
            Password = password.Result,
            Instance = dbServer.Name,
        });

        var db = new Pulumi.PostgreSql.Database("db", new Pulumi.PostgreSql.DatabaseArgs {
            Name = "submissions",
            Owner = user.Name,
        }, new Pulumi.CustomResourceOptions {
            Provider = new Pulumi.PostgreSql.Provider("pgProvider", new Pulumi.PostgreSql.ProviderArgs {
                Host = dbServer.PublicIpAddress,
                Username = user.Name,
                Password = password.Result,
            })
        });

        InstanceConnectionName = dbServer.ConnectionName;
        DbUsername = user.Name;
        DbPassword = password.Result;
        DatabaseName = db.Name;
    }

    public Output<string> InstanceConnectionName { get; }
    public Output<string> DbUsername { get; }
    public Output<string> DbPassword { get; }
    public Output<string> DatabaseName { get; }
}