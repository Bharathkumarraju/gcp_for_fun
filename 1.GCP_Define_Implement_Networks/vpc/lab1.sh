You can SSH because of the allow-ssh firewall rule, which allows incoming traffic from anywhere (0.0.0.0/0) for tcp:22.
The SSH connection works seamlessly because Compute Engine generates an SSH key for you and stores it in one of the following locations:

By default, Compute Engine adds the generated key to project or instance metadata.
If your account is configured to use OS Login, Compute Engine stores the generated key with your user account.
Alternatively, you can control access to Linux instances by creating SSH keys and editing public SSH key metadata.