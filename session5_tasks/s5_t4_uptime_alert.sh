#!/bin/bash

uptime_seconds=$(cut -d. -f1 /proc/uptime)
uptime_minutes=$((uptime_seconds / 60 ))

echo "System uptime: ${uptime_minutes} minutes"

if [ "$uptime_minutes" -lt 5 ]; then
    echo "System was recently rebooted"
else
    echo "System is stable"
fi