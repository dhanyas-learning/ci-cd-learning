#!/bin/bash

# Configuration
CPU_THRESHOLD=80  # CPU usage threshold in percentage
LOG_FILE="/tmp/cpu_monitor.log"

# Check CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
CPU_USAGE=${CPU_USAGE%.*}  # Convert to integer for comparison

# Log CPU usage
echo "$(date): Current CPU usage is ${CPU_USAGE}%" >> "$LOG_FILE"

if [ "$CPU_USAGE" -gt "$CPU_THRESHOLD" ]; then
    echo "ALERT: CPU usage is at ${CPU_USAGE}%!" >> "$LOG_FILE"
    exit 1  # Exit with an error code to trigger Jenkins failure
else
    echo "CPU usage is normal: ${CPU_USAGE}%" >> "$LOG_FILE"
    exit 0
fi

