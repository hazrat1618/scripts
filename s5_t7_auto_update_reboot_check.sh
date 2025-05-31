#!/bin/bash

#Run dnf list --upgradable
#If 'linux-image' is in the list:
#   Print "Kernel update detected, reboot required"
#Else:
#   Print "No reboot required"

echo "Checking for system updates"

# Get list of upgradable packages
updates=$(dnf list --upgrades 2>/dev/null)

# Check for kernel-related updates
if echo "$update" | grep -qE 'kernel|kernel-core'; then 
    echo "Kernel update detected, reboot required"
else 
    echo "No reboot required"
fi