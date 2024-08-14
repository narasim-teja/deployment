# FastLane Deployment Guide

## Description

This guide covers the steps to install and configure the Caddy server on an Ubuntu system, setting it up as a reverse proxy. After setting up Caddy, you can use the provided deploy script to deploy your application in production or staging environments.

## Installation Steps

### Step 1: Import Caddy GPG Key and Add Repository

Import the GPG key for the Caddy repository and add the Caddy stable repository to your system's sources list.

```bash
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg

curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
```

### Step 2: Update Package List and Install Caddy

Update the package list and install Caddy.

```bash
sudo apt update
sudo apt install caddy -y
```

### Step 3: Stop Caddy Service and Change Ownership of Caddyfile

Stop the Caddy service and change the ownership of the Caddyfile to the current user (replace `ubuntu` with your username if different).

```bash
sudo systemctl stop caddy
sudo chown ubuntu:ubuntu /etc/caddy/Caddyfile
```

### Step 4: Configure Caddyfile

Export your domain name as an environment variable, create and configure the Caddyfile for your domain. This sets up a reverse proxy to a local server running on port 8080.

- Move *Caddyfile* to */etc/caddy/* directory OR create a new file in */etc/caddy/* directory.

```bash
export DOMAIN=YOUR_DOMAIN_NAME

cat << EOF > /etc/caddy/Caddyfile
$DOMAIN {
    reverse_proxy localhost:3000
}
EOF

cat /etc/caddy/Caddyfile
```

### Step 5: Enable and Start Caddy Service

Enable the Caddy service to start on boot and then start the Caddy service.

```bash
sudo systemctl enable caddy
sudo systemctl restart caddy
```

### Step 6: Verify Domain Configuration

Ensure that your domain name is correctly configured to return the IP address of the server running Caddy using your domain registrar's DNS management tools.

## Deploying Your Application

Now, use the deploy script to deploy your application in production or staging environments.

```bash
./deploy.sh [--prod | --staging]
```

## Troubleshooting

If you encounter any issues, check the status and logs of the Caddy service:

```bash
sudo systemctl status caddy
sudo journalctl -u caddy
```

For additional support, visit the [Caddy community forum](https://caddy.community/).
