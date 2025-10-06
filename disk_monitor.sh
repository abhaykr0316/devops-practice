#!/bin/bash
# disk_monitor.sh - Check disk usage and alert if > 80%

THRESHOLD=80
df -h | grep '^/dev/' | while read line; do
  usage=$(echo $line | awk '{print $5}' | tr -d '%')
  mount_point=$(echo $line | awk '{print $6}')
  if [ $usage -gt $THRESHOLD ]; then
    echo "Warning: Disk usage at $mount_point is ${usage}"
  fi
done
