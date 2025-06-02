#!/bin/bash

# Define a list of URLs
URLS=(
    "https://code.akumotechnology.com"
)

echo "Web Server Availability Checker"

# Loop through each URL
for url in "${URLS[@]}"; do
    # Get HTTP status code using curl
    status_code=$(curl -o /dev/null -s -w "%{http_code}" "$url")
    
    # Check status
    if [ "$status_code" -eq 200 ]; then
        echo "$url - OK (200)"
    else
        echo "$url - ERROR ($status_code)"
    fi
done