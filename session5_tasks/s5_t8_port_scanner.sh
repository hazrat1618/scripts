#!/bin/bash

#pseudocode
#Define list of ports
#For each port:
#   Use nc -zv localhost $port
#   Report if open or closed

PORTS=(22 80 443 3306)
HOST="localhost"

echo "Port availability scan"
echo " ====================="
for port in "${PORTS[@]}";do 
    if nc -zv $HOST $port; then
        echo "Port $port is open"
    else
        echo "Port $port is closed"
    fi 
done