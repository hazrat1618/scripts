#!/bin/bash
LOG_FILE="/root/scripts/health.log"
{
echo "$(date)"
echo "Services provided:
apache2 
mysql
ssh
cron"
 
if ! rpm -q httpd &>/dev/null; then
    echo "Apache2 service is not active"
    dnf install httpd -y
else
    echo "Apache2 service is installed"
fi
if ! rpm -q mariadb &>/dev/null; then
    echo "MySQL not found. Installing"
    dnf install mariadb -y
else
    echo "MySQL is installed"
fi
if ! systemctl is-active --quiet httpd; then
    echo "Apache2 Status not active"
else 
    echo "Apache Status active" 
fi 
if ! systemctl is-active --quiet mariadb; then
    echo "MySQL not active" 
else
    echo "MySQL is active"
fi
if ! systemctl is-active --quiet sshd; then
    echo "SSH is not active"  
else
    echo "SSH is active"
fi
if ! systemctl is-active --quiet crond; then
    echo "Cron service is not active" 
else
    echo "cron service is active" 
fi
} >> $LOG_FILE