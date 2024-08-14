# FastLane Deployment Guide

## Installation Steps

### Step 1: Import Caddy GPG Key and Add Repository

First, import the GPG key for the Caddy repository to ensure the package's authenticity and then add the Caddy stable repository to your system's sources list.

```bash
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg

curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
```

### Step 2: Update Package List and Install Caddy

Update the package list to include the newly added Caddy repository and then install Caddy using the `apt` package manager.

```bash
sudo apt update
sudo apt install caddy -y
```

### Step 3: Stop Caddy Service and Change Ownership of Caddyfile

Stop the Caddy service to make configuration changes and change the ownership of the Caddyfile to the current user (replace `ubuntu` with your username if different).

```bash
sudo systemctl stop caddy
sudo chown ubuntu:ubuntu /etc/caddy/Caddyfile
```

### Step 4: Configure Caddyfile

Export your domain name as an environment variable, create and configure the Caddyfile for your domain. This configuration sets up a reverse proxy to a local server running on port 8080.

```bash
export DOMAIN=YOUR_DOMAIN_NAME

cat << EOF > /etc/caddy/Caddyfile
$DOMAIN {
    reverse_proxy localhost:8080
}
EOF

cat /etc/caddy/Caddyfile
```

### Step 5: Enable and Start Caddy Service

Enable the Caddy service to start on boot and then start the Caddy service.

```bash
sudo systemctl enable caddy
sudo systemctl start caddy
```

### Step 6: Verify Domain Configuration

Ensure that your domain name is correctly configured to return the IP address of the server running Caddy. This can be done using DNS management tools provided by your domain registrar.

## Conclusion

You have successfully installed and configured the Caddy server on your Ubuntu system. The Caddy server is now set up to act as a reverse proxy for your application running on port 8080. For further customization and advanced configuration options, refer to the [Caddy documentation](https://caddyserver.com/docs/).

## Troubleshooting

If you encounter any issues, check the status and logs of the Caddy service:

```bash
sudo systemctl status caddy
sudo journalctl -u caddy
```

For additional support, visit the [Caddy community forum](https://caddy.community/).