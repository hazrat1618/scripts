#!/bin/bash

#Define repo path and target directory
#cd into target
#Run git pull
#Restart apache
#Log output and timestamp

#Define repo path and target directory
REPO_DIR="/root/scripts/mywebsite"
TARGET_DIR="/var/www/html"
LOG_FILE="/var/log/site_deploy.log"
TIMESTAMP=$(date)

echo "Deploymetn at $TIMESTAMP" >> $LOG_FILE

#cd into target
cd $REPO_DIR 

#Run git pull
git pull >> $LOG_FILE

systemctl restart httpd

echo "Deployed at $(date)" >> $LOG_FILE
