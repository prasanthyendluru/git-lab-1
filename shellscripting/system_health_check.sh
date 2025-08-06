#!/bin/bash


CURRENT_DATE=$(date +"%Y-%m-%d")


PROCESS_LOG="process_log_$CURRENT_DATE.log"
ps > "$PROCESS_LOG"


HIGH_MEM_LOG="high_mem_processes.log"

HIGH_MEM_PROCESSES=$(ps | awk '{if($4+0 > 30) print $0}')

if [[ -n "$HIGH_MEM_PROCESSES" ]]; then
    echo "  Warning: High memory usage detected!" >&2
    echo "[$(date)] High memory usage processes:" >> "$HIGH_MEM_LOG"
    echo "$HIGH_MEM_PROCESSES" >> "$HIGH_MEM_LOG"
    echo "" >> "$HIGH_MEM_LOG"
fi

ROOT_USAGE=$(df / | awk 'NR==2 {gsub("%",""); print $5}')
if [[ "$ROOT_USAGE" -gt 80 ]]; then
    echo "  Warning: Disk usage on / is above 80%! Currently at ${ROOT_USAGE}%" >&2
fi

TOTAL_PROCESSES=$(ps | wc -l)
HIGH_MEM_COUNT=$(echo "$HIGH_MEM_PROCESSES" | wc -l)
echo "===== System Health Summary ====="
echo "Total running processes:           $TOTAL_PROCESSES"
echo " Processes >30% memory usage:       $HIGH_MEM_COUNT"
echo " Disk usage on root partition (/): ${ROOT_USAGE}%"
echo "=================================="
