#!/bin/bash

# Script to automate backups using crontab

# Variables
SOURCE_DIR="/var/www/html"
BACKUP_DIR="/backup"
REMOTE_SERVER="user@192.168.1.100"
REMOTE_DIR="/remote_backup"
LOG_FILE="/var/log/backup.log"

# Create backup directory if not exists
echo "Ensuring backup directory exists..."
mkdir -p ${BACKUP_DIR}

# Perform backup
echo "Creating a tar archive of ${SOURCE_DIR}..."
tar -czf ${BACKUP_DIR}/backup_$(date +%Y%m%d).tar.gz ${SOURCE_DIR}

# Securely transfer to remote server
echo "Transferring backup to remote server..."
scp ${BACKUP_DIR}/backup_$(date +%Y%m%d).tar.gz ${REMOTE_SERVER}:${REMOTE_DIR}

# Log the operation
echo "$(date): Backup completed and transferred to ${REMOTE_SERVER}" >> ${LOG_FILE}

# Set up crontab for daily backups
echo "Setting up daily backups in crontab..."
(crontab -l 2>/dev/null; echo "0 2 * * * /bin/bash $PWD/backup_script.sh") | crontab -

echo "Backup setup complete!"
