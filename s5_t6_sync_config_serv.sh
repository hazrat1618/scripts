#!/bin/bash

#Define remote IP, user, and config path
#Use scp to copy config file
#Use ssh to restart apache2 on remote host
#Log success or failure

REMOTE_USER="root"
REMOTE_IP="143.198.2.255"
LOCAL_CONFIG="/etc/httpd/conf/httpd.conf"
REMOTE_CONFIG="/etc/httpd/conf/httpd.conf"
LOG_FILE="/var/log/sync_apache_conf.log"

echo "Starting Apache config sync at $(date)" | tee -a $LOG_FILE

if scp "$LOCAL_CONFIG" "${REMOTE_USER}@${REMOTE_IP}:$REMOTE_CONFIG"; then
    echo "Config copied successfully." | tee -a "$LOG_FILE"
else
    echo "Failed to copy config" | tee -a "$LOG_FILE"   
    exit 1
fi

if ssh "${REMOTE_USER}@${REMOTE_IP}" "systemctl restart httpd"; then 
    echo "Apache restarted successfully on remote server." | tee -a "$LOG_FILE"
else
    echo "Failed to restart Apache remotely" | tee -a "$LOG_FILE"
fi

echo "Sync completed on $(date) | tee -a $LOG_FILE