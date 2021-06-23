bharathdasaraju@MacBook-Pro demos (main) $ pulumi new
Please choose a template: gcp-csharp                   A minimal GCP C# Pulumi program
This command will walk you through creating a new Pulumi project.

Enter a value or leave blank to accept the (default), and press <ENTER>.
Press ^C at any time to quit.

project name: (demos) testbkr
project description: (A minimal GCP C# Pulumi program)
Created project 'testbkr'

Please enter your desired stack name.
To create a stack in an organization, use the format <org-name>/<stack-name> (e.g. `acmecorp/dev`).
stack name: (dev) test
Created stack 'test'

gcp:project: The Google Cloud project to deploy into: learngcp-316009
Saved config

Installing dependencies...

running 'dotnet build -nologo .'


Welcome to .NET 5.0!
---------------------
SDK Version: 5.0.204


Telemetry
---------
The .NET tools collect usage data in order to help us improve your experience. It is collected by Microsoft and shared with the community. You can opt-out of telemetry by setting the DOTNET_CLI_TELEMETRY_OPTOUT environment variable to '1' or 'true' using your favorite shell.

Read more about .NET CLI Tools telemetry: https://aka.ms/dotnet-cli-telemetry

----------------
Installed an ASP.NET Core HTTPS development certificate.
To trust the certificate run 'dotnet dev-certs https --trust' (Windows and macOS only).
Learn about HTTPS: https://aka.ms/dotnet-https
----------------
Write your first app: https://aka.ms/dotnet-hello-world
Find out what's new: https://aka.ms/dotnet-whats-new
Explore documentation: https://aka.ms/dotnet-docs
Report issues and find source on GitHub: https://github.com/dotnet/core
Use 'dotnet --help' to see available commands or visit: https://aka.ms/dotnet-cli
--------------------------------------------------------------------------------------


  Determining projects to restore...

  Restored /Users/bharathdasaraju/git/gcp_for_fun/4.Pulumi/demos/testbkr.csproj (in 26.87 sec).

  testbkr -> /Users/bharathdasaraju/git/gcp_for_fun/4.Pulumi/demos/bin/Debug/netcoreapp3.1/testbkr.dll


Build succeeded.

    0 Warning(s)
    0 Error(s)

Time Elapsed 00:00:49.61

'dotnet build -nologo .' completed successfully
[resource plugin gcp-5.10.0] installing
Downloading plugin: 36.55 MiB / 36.55 MiB [=========================] 100.00% 7s
Finished installing dependencies

Your new project is ready to go! ✨

To perform an initial deployment, run 'pulumi up'

bharathdasaraju@MacBook-Pro demos (main) $

