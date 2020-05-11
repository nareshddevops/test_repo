#!/bin/sh

FROM_DATE=""
TO_DATE=""
LOG_LEVEL="SEVERE"
LOGS_DIR="/logs"

#read -p 'Enter log level: ' LOG_LEVEL
#read -p 'Enter log files directory (absolute path): ' LOGS_DIR
#read -p 'Enter log from timestamp: ' FROM_DATE
#read -p 'Enter log to timestamp: ' TO_DATE

echo > /extractedlog.txt
for file in $(find $LOGS_DIR -type f); do 
    grep "$LOG_LEVEL" $file | awk '$0>=from && $0<=to' from="$FROM_DATE" to="$TO_DATE" | awk -v prefix="$file" '{print prefix $0}' >> /test.txt
done
