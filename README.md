# Adhoc-Network-Infrastructure-using-Linux

## Overview
This project demonstrates the creation of an ad-hoc network infrastructure using Linux, integrating DNS server configuration, automated backup solutions, and VPN security measures. The project highlights efficient network management and security in a dynamic Linux-based environment.

## Features

- DNS Server Configuration: Set up Bind9 DNS server with IPv4/IPv6 integration, forward and reverse domain setups, and master-slave synchronization.
- Automated Backup Solution: Configured crontab for daily backups of 100GB+ data, securely transferring archives to a remote server.
- VPN Deployment: Deployed IPsec VPN using strongSwan for secure communication between remote offices.
- Network Diagnostics: Resolved 95% of connectivity issues using tools like ping, traceroute, and Wireshark.
- Security Analysis: Simulated Man-in-the-Middle (MITM) attacks using Python to identify and mitigate vulnerabilities.

## Technologies
- **Operating System**: Linux (Ubuntu)
- **Tools**: Bind9, Fail2Ban, IPsec, Wireshark, Crontab
- **Languages**: Bash scripting, Python (for attack simulation)
- **Protocols**: IPv4/IPv6, VPN, ARP

## Prerequisites:
Linux-based environment (Ubuntu preferred)
Basic understanding of Linux networking

## Setup Instructions
1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/Adhoc-Network-Infrastructure-Linux.git
   cd Adhoc-Network-Infrastructure-Linux
  
2. DNS Server Configuration: Run the DNS configuration script:
   ```bash
   ./scripts/dns_config.sh

3. Automated Backup: Set up the backup solution:
   ```bash
   ./scripts/backup_script.sh

4. VPN Deployment: Deploy the IPsec VPN:
   ```bash
   ./scripts/vpn_setup.sh

5. Simulate Security Vulnerabilities: Test your network's resilience using:
   ```bash
   python3 ./scripts/python_mitm_attack.py

## Usage
DNS: Verify domain resolution using nslookup or dig.
Backup: Check the backup/ directory for archived data and transfer logs.
VPN: Confirm secure connections using ipsec status.
Diagnostics: Analyze network logs using Wireshark for performance and intrusion detection.
Security: Review ARP spoofing impact and logs to strengthen network defenses.

Adhoc-Network-Infrastructure-Linux/
│
├── README.md                  # Project overview and usage details
├── scripts/                   # Automation scripts for various tasks
│   ├── dns_config.sh          # DNS server configuration
│   ├── backup_script.sh       # Automated backup setup
│   ├── vpn_setup.sh           # VPN deployment
│   ├── python_mitm_attack.py  # MITM attack simulation
├── configs/                   # Configuration files for DNS and VPN
│   ├── named.conf             # Bind9 configuration
│   ├── vpn.conf               # IPsec VPN configuration
├── logs/                      # Logs for network diagnostics
│   ├── connectivity.log       # Ping and traceroute logs
│   ├── intrusion.log          # Fail2Ban intrusion logs
├── outputs/                   # Output samples for analysis
│   ├── ping_results.txt       # Sample ping results
│   ├── vpn_status.txt         # VPN status outputs
└── LICENSE                    # Licensing information

   
