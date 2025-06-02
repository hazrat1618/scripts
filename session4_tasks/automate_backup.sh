#!/bin/bash

TIMESTAMP=$(date +'%Y-%m-%d_%H-%M-%S')
BACKUP_DIR="/root/scripts/backups"
ARCHIVE_NAME="backup_dir_$TIMESTAMP.tar.gz"

mkdir -p "$BACKUP_DIR"

read -r -p "Enter directory you want to archive and its path: " dir
dir=$(echo "$dir" | xargs)  # remove whitespace

if [ -d "$dir" ]; then
    tar -czf "$ARCHIVE_NAME" "$dir"
    
    if [ -f "$ARCHIVE_NAME" ]; then
        cp "$ARCHIVE_NAME" "$BACKUP_DIR"
        echo "Backup completed: $ARCHIVE_NAME"
    else
        echo "Backup archive was not created."
        exit 1
    fi

    SPACE_INDICATION=$(df -h "$BACKUP_DIR" | tail -n 1 | awk '{print $4}')
    echo "Remaining disk space on $BACKUP_DIR is $SPACE_INDICATION"
else
    echo "Directory does not exist: $dir"
fi