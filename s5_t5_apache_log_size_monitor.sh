#!/bin/bash

#Check /var/log/httpd/access.log size
#If size > 100MB:
#  Move it to access.log.YYYYMMDD.gz
# Touch a new empty access.log
#   Restart Apache

LOG_FILE="/var/log/httpd/access_log"
MAX_MB=100
MAX_BYTES=$(($MAX_MB*1024*1024))

file_size_bytes=$(ls -l "$LOG_FILE" | awk '{print $5}' )

if [ "$file_size_bytes" -gt "$MAX_BYTES" ]; then
    echo "Log exceeds ${MAX_MB}mb. Need to archive"

    timestamp=$(date +%Y%m%d)

    mv "$LOG_FILE" "/var/log/httpd/access_log.${timestamp}"
    gzip "/var/log/httpd/access_log.${timestamp}"

    touch "$LOG_FILE"
    
    systemctl restart httpd
    echo "Done"
else
    size_mb=$(($file_size_bytes/1024/1024))
    echo "Log file size is ${size_mb}mb"
fi 