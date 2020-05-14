#!/bin/sh

FROM_DATE="May 08, 2020 19:00:00"
TO_DATE="May 09, 2020 09:00:00"
LOG_LEVEL="SEVERE"
LOGS_DIR="logs"

#read -p 'Enter log level: ' LOG_LEVEL
#read -p 'Enter log files directory (absolute path): ' LOGS_DIR
#read -p 'Enter log from timestamp: ' FROM_DATE
#read -p 'Enter log to timestamp: ' TO_DATE

echo > /home/testuser/test.txt
for file in $(find $LOGS_DIR -type f); do
    grep "$LOG_LEVEL" $file | awk '$0>=from && $0<=to' from="$FROM_DATE" to="$TO_DATE" | awk -v prefix="$file " '{print prefix $0}' >> /home/testuser/test.txt
done
