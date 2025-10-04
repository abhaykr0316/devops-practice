#!/bin/bash
# log_cleanup.sh - Delete logs older than 7 days

LOG_DIR="/var/log/"
find $LOG_DIR -type f -name ".log" -mtime +7 -exec rm -rf {} \;
echo "Old logs cleaned up successfully!"
