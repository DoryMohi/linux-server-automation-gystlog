#!/bin/bash

# Define paths
LOG_DIR="/srv/gystlog/logs"
BACKUP_DIR="/srv/gystlog/backups/logs"
DATE=$(date '+%Y-%m-%d')
ARCHIVE_NAME="logs_${DATE}.tar.gz"

# Create backup directory if it doesn't exist
sudo mkdir -p "$BACKUP_DIR"

# Archive active log files
sudo tar -czf "${BACKUP_DIR}/${ARCHIVE_NAME}" -C / srv/gystlog/logs

# Clear active log files without deleting them
sudo truncate -s 0 /srv/gystlog/logs/system/monitor.log 2>/dev/null
sudo truncate -s 0 /srv/gystlog/logs/nginx/access.log 2>/dev/null

# Apply retention policy: remove log archives older than 30 days
sudo find "$BACKUP_DIR" -type f -name "logs_*.tar.gz" -mtime +30 -exec rm -f {} \;

echo "Log rotation completed: ${ARCHIVE_NAME}"
