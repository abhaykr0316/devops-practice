#!/bin/bash
# system_health_check.sh - Check system health

#THRESHOLDS
DISK_THRESHOLD=80
MEMORY_THRESHOLD=80
CPU_THRESHOLD=80

# Log file
LOG_FILE="/tmp/system_health.log"

# Function: Disk usage check

check_disk() {
    mount_point="/"
    usage=$(df -h $mount_point | awk 'NR==2 {print $5}' | tr -d '%')

    if [ "$usage" -gt "$DISK_THRESHOLD" ]; then
        echo "Warning: Disk usage at $mount_point is ${usage}% (above ${DISK_THRESHOLD}%)" | tee -a $LOG_FILE
    else
        echo "Disk usage at $mount_point is ${usage} (within limit)" | tee -a $LOG_FILE
    fi
}

# Function: Memory usage check

check_memory() {
    mem_usage=$(free | awk '/Mem/ {printf "%.0f", $3/$2 * 100}')

    if [ "$mem_usage" -gt "$MEMORY_THRESHOLD" ]; then
        echo "Warning: Memory usage is ${mem_usage}% (above ${MEMORY_THRESHOLD}%)" | tee -a $LOG_FILE
    else
        echo "Memory usage is ${mem_usage}% (within limit)" | tee - $LOG_FILE
    fi
}

# Function: CPU usage check

check_cpu() {
    cpu_idle=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | tr -d ',%')
    cpu_usage=$((100 - ${cpu_idle%.*}))

    if [ "$cpu_usage" -gt "$CPU_THRESHOLD" ]; then
        echo "Warning: CPU usage is ${cpu_usage}% (above ${CPU_THRESHOLD})" | tee -a $LOG_FILE
    else
        echo "CPU usage is ${cpu_usage}% (within limit)" | tee -a $LOG_FILE
    fi
}


# Main

echo "===========================System Health Check=============================" | tee -a $LOG_FILE
date | tee -a $LOG_FILE
check_disk
check_memory
check_cpu
echo "===========================================================================" | tee -a $LOG_FILE
