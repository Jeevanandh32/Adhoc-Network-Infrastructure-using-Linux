#!/bin/bash

# Script to configure Bind9 DNS server on a Linux system

# Variables
DOMAIN_NAME="example.com"
ZONE_FILE="/etc/bind/db.${DOMAIN_NAME}"
REV_ZONE_FILE="/etc/bind/db.192"
BIND_DIR="/etc/bind"

# Install Bind9
echo "Installing Bind9 DNS server..."
sudo apt update && sudo apt install -y bind9 bind9utils bind9-doc

# Configure named.conf.local
echo "Configuring named.conf.local..."
cat <<EOL | sudo tee ${BIND_DIR}/named.conf.local
zone "${DOMAIN_NAME}" {
    type master;
    file "${ZONE_FILE}";
};

zone "192.168.1.in-addr.arpa" {
    type master;
    file "${REV_ZONE_FILE}";
};
EOL

# Create forward zone file
echo "Creating forward zone file..."
cat <<EOL | sudo tee ${ZONE_FILE}
\$TTL 86400
@   IN  SOA ns.${DOMAIN_NAME}. admin.${DOMAIN_NAME}. (
        2024010101 ; Serial
        3600       ; Refresh
        1800       ; Retry
        604800     ; Expire
        86400 )    ; Minimum TTL

    IN  NS  ns.${DOMAIN_NAME}.
ns  IN  A   192.168.1.10
www IN  A   192.168.1.20
EOL

# Create reverse zone file
echo "Creating reverse zone file..."
cat <<EOL | sudo tee ${REV_ZONE_FILE}
\$TTL 86400
@   IN  SOA ns.${DOMAIN_NAME}. admin.${DOMAIN_NAME}. (
        2024010101 ; Serial
        3600       ; Refresh
        1800       ; Retry
        604800     ; Expire
        86400 )    ; Minimum TTL

    IN  NS  ns.${DOMAIN_NAME}.
10  IN  PTR ns.${DOMAIN_NAME}.
20  IN  PTR www.${DOMAIN_NAME}.
EOL

# Restart Bind9
echo "Restarting Bind9 DNS server..."
sudo systemctl restart bind9

# Test configuration
echo "Testing DNS configuration..."
sudo named-checkconf
sudo named-checkzone ${DOMAIN_NAME} ${ZONE_FILE}
sudo named-checkzone 192.168.1.in-addr.arpa ${REV_ZONE_FILE}

echo "DNS server setup completed successfully!"
