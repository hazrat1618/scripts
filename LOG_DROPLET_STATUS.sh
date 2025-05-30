#!/bin/bash

LOG_FILE="/var/log/droplet-health.log"
TIMESTAMP=$(date)

if [[ "$(ping -c 1 8.8.8.8 | grep '100% packet loss' )" != "" ]]; then
    echo "Internet isn't present" | tee -a $LOG_FILE
else
    echo "Internet is present" | tee -a $LOG_FILE
fi

read -p "Enter droplet name: " droplet
if ! doctl compute droplet get $droplet &> /dev/null; then
    "Failed to get droplet info Starting installation of doctl"
    dnf install epel-release -y
    dnf install snapd
    systemctl enable --now snapd.socket
    ln -s /var/lib/snapd/snap /snap
    snap install doctl
    echo "Droplet cli installation successful" | tee -a $LOG_FILE
else
    echo "Droplet $droplet info is available" | tee -a $LOG_FILE
fi

DROPLET_STATUS=$(doctl compute droplet get "$droplet")

echo "$TIMESTAMP, Droplet $droplet status is $DROPLET_STATUS" | tee -a $LOG_FILE