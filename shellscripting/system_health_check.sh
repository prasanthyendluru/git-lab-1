
DATE=$(date +%F)

# Filenames
PROCESS_LOG="process_log_$DATE.log"
HIGH_MEM_LOG="high_mem_processes.log"

echo " Logging all running processes to $PROCESS_LOG..."
ps aux > "$PROCESS_LOG"

echo " Checking for processes using more than 30% memory..."
HIGH_MEM=$(ps aux --sort=-%mem | awk '$4>30')

if [[ -n "$HIGH_MEM" ]]; then
    echo " Warning: High memory usage detected!"
    echo "$HIGH_MEM" >> "$HIGH_MEM_LOG"
fi

echo " Checking disk usage on root (/) partition..."
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$DISK_USAGE" -gt 80 ]; then
    echo " Warning: Disk usage on / is above 80%! Currently at ${DISK_USAGE}%"
fi

# Summary
TOTAL_PROCESSES=$(ps aux | wc -l)
HIGH_MEM_COUNT=$(echo "$HIGH_MEM" | wc -l)

echo ""
echo " System Health Summary:"
echo "--------------------------"
echo " Total running processes      : $TOTAL_PROCESSES"
echo " Processes >30% memory usage  : $HIGH_MEM_COUNT"
echo " Disk usage on / partition    : ${DISK_USAGE}%"
echo "--------------------------"
