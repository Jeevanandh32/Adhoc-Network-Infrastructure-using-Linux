#!/bin/bash

# Script to set up IPsec VPN using strongSwan

# Variables
VPN_SERVER_IP="192.168.1.1"
VPN_CLIENT_IP="192.168.1.2"
VPN_PSK="SecureKey123"

# Install strongSwan
echo "Installing strongSwan for VPN setup..."
sudo apt update && sudo apt install -y strongswan strongswan-pki

# Configure IPsec
echo "Configuring IPsec VPN..."
cat <<EOL | sudo tee /etc/ipsec.conf
config setup
    charondebug="ike 1, knl 1, cfg 0"

conn vpn-connection
    keyexchange=ikev2
    auto=start
    left=${VPN_SERVER_IP}
    leftid=${VPN_SERVER_IP}
    leftsubnet=0.0.0.0/0
    right=${VPN_CLIENT_IP}
    rightid=${VPN_CLIENT_IP}
    rightsubnet=192.168.1.0/24
    authby=secret
EOL

# Configure secrets
echo "Adding VPN secrets..."
cat <<EOL | sudo tee /etc/ipsec.secrets
${VPN_SERVER_IP} ${VPN_CLIENT_IP} : PSK "${VPN_PSK}"
EOL

# Restart IPsec
echo "Restarting IPsec service..."
sudo systemctl restart strongswan

echo "IPsec VPN setup complete!"
