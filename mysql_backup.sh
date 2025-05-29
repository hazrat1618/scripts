#!/bin/bash

DB_NAME="demo_db"
DB_USER="root"
BACKUP_DIR="/root/db_backup"
DATE=$(date +%Y%m%d)
BACKUP_FILE="$BACKUP_DIR/backup.sql"

mkdir -p $BACKUP_DIR

echo "Starting backup of $DB_NAME"
if mysqldump -u $DB_USER -p $DB_NAME > $BACKUP_FILE; then
    echo "Backup completed."
else 
    echo "Backup failed!" 
fi 
