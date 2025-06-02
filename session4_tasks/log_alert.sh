#!/bin/bash

PARSE_FILE="/var/log/messages"
KEYWORDS="error|failure|critical"
LOG_FILE="/var/log/error_count.log"
MATCH_COUNT=$(grep -iE "$KEYWORDS" "$PARSE_FILE" | wc -l )

if [ "$MATCH_COUNT" -gt 0 ]; then
    echo "$(date) Found $MATCH_COUNT matches." | tee -a $LOG_FILE
else
    echo "$(date) No errors found" | tee -a $LOG_FILE
fi 