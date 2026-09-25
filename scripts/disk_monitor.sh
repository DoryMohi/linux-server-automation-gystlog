#!/bin/bash

THRESHOLD=80

BOT_TOKEN="YOUR_TELEGRAM_BOT_TOKEN"
CHAT_ID="YOUR_TELEGRAM_CHAT_ID"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')

USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
DISK=$USAGE

if [ "$USAGE" -gt "$THRESHOLD" ]; then
    MESSAGE="WARNING: Disk usage above ${THRESHOLD}% (Current usage: ${USAGE}%)"

    echo "$MESSAGE"

    curl -s -X POST https://api.telegram.org/bot$BOT_TOKEN/sendMessage \
        -d chat_id=$CHAT_ID \
        -d text="$MESSAGE"
else
    echo "Disk usage within safe limits (${USAGE}%)"
fi

echo "$TIMESTAMP | CPU:${CPU}% | MEM:${MEM_USED}/${MEM_TOTAL}MB | DISK:${DISK}%"
echo "$TIMESTAMP | CPU:${CPU}% | MEM:${MEM_USED}/${MEM_TOTAL}MB | DISK:${DISK}%" >> /home/dory/system_monitor.log
